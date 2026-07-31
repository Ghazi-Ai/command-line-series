// المشروع الحادي عشر: مصنع إصدار قابل للتكرار
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, danger, try-it, define, challenge, objectives, session

#chapter[المشروع 11: مصنع إصدار قابل للتكرار]

#objectives((
  [تربط الفحص والبناء والحزمة في أوامر واضحة.],
  [تمنع الملفات الداخلية والأسرار من دخول الأرشيف.],
  [تنتج بصمة وبيان مصدر للحزمة.],
  [تفهم الفرق بين اتساق النتيجة وتطابق البايتات.],
))

«أرسل المجلد عندي» ليست عملية إصدار. قد يحوي ملفات مؤقتة أو أسرارًا
أو شيفرة لم تُختبر. سنبني مصنعًا صغيرًا يأخذ إيداعًا (Commit)
محددًا، يفحصه، ثم يصنع أرشيفًا وبصمة وبيانًا.

#define("أثر البناء", [
  ملف ينتج من المصادر بأمر موثق، مثل أرشيف أو PDF أو برنامج. يجب
  أن نستطيع ربطه بالمصدر والإعداد والأداة التي صنعته.
])

#section[هيكل المشروع]

```text
11-release-factory/
├── src/
├── tests/
├── VERSION
├── Makefile
├── .gitattributes
├── .gitignore
└── tools/release.sh
```

اكتب في `.gitattributes` ما لا يدخل أرشيف Git:

```gitattributes
tests/ export-ignore
tmp/ export-ignore
logs/ export-ignore
.env export-ignore
*.key export-ignore
```

هذا لا يعفيك من فحص الأسرار؛ هو خريطة حزمة.

#section[أهداف قليلة وواضحة]

```make
.PHONY: check build package clean

check:
	python3 -m unittest -q
	git diff --check

build:
	mkdir -p build
	python3 src/app.py > build/result.txt

package: check build
	bash tools/release.sh

clean:
	rm -rf build dist
```

تذكر أن Tab في Makefile جزء من الصيغة. لا تجعل `clean` هدفًا
افتراضيًا، ولا تستعمل متغيرات فارغة لأهداف الحذف.

#section[سكربت الإصدار]

```bash
#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
cd "$root"

version=$(tr -d '[:space:]' < VERSION)
[[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || {
  echo "VERSION غير صالح" >&2; exit 2;
}

if [ -n "$(git status --porcelain=v1 --untracked-files=all)" ]; then
  echo "شجرة العمل غير نظيفة" >&2; exit 2;
fi

commit=$(git rev-parse HEAD)
mkdir -p dist
archive="dist/project-$version.tar.gz"

git archive --format=tar.gz --prefix="project-$version/" \
  --output="$archive" HEAD
sha256sum "$archive" > "$archive.sha256"
printf 'version=%s\ncommit=%s\n' "$version" "$commit" \
  > "dist/project-$version.build-info"
printf '%s\n' "$archive"
```

على ماك استبدل حساب البصمة بأداة النظام أو اجعل السكربت يكتشفها
كما فعل مشروع النسخ. فحص الحالة أعلاه يشمل الملفات غير المتعقبة؛
فالفرق المرحلي وحده لا يكفي للحكم على نظافة الشجرة.

#section[افحص الأرشيف قبل تسميته إصدارًا]

```bash
tar -tzf dist/project-1.0.0.tar.gz | sed -n '1,80p'
```

ابحث عن:

```bash
tar -tzf dist/project-1.0.0.tar.gz \
  | rg '(^|/)(\.env|.*\.key|.*\.pem|logs|tmp)(/|$)' && exit 1 || true
```

الأنماط تحتاج مراجعة؛ قد يظهر ملف توثيق اسمه `keys.md` وهو آمن،
وقد يفوت سر في `config.txt`.

#warn[
  لا تجعل قائمة الاستبعاد بديلًا عن قائمة ما يجب أن يدخل. كلما
  أمكن، ابنِ الحزمة من مصادر معروفة أو من شجرة Git المحددة بدل
  ضغط مجلد العمل كاملًا. والملف المتجاهل لا يظهر في فحص الحالة؛
  فلا تجعل الاختبارات أو البناء يعتمدان خفيةً على ملف `.env` أو
  اعتماد محلي غير مثبت.
]

#section[كرر البناء]

ابنِ مرتين من الإيداع نفسه وقارن البصمتين. `git archive` يثبت كثيرًا
من تفاصيل الأرشيف نسبة إلى الإيداع، لكن أدوات الضغط والبناء قد تختلف
بين الإصدارات. إذا تطابقت البايتات في بيئتك سجل الدليل؛ وإذا لم
تتطابق فافحص الزمن والترتيب والأداة.

#note[
  لا تقل «متطابق بايتًا على كل جهاز» لمجرد نجاح تجربتين على جهازك.
  يمكن أن يكون البناء متسقًا في المحتوى والسلوك من دون تطابق كل
  بايت بين أدوات وإصدارات مختلفة.
]

#section[الوسم يأتي بعد القرار]

يمكن إنشاء وسم محلي مشروح:

```bash
git tag -a v1.0.0 -m "release v1.0.0"
git show v1.0.0 --no-patch
```

لا تدفعه تلقائيًا. النشر تغيير خارجي يحتاج موافقة، ويجب أن يشير
الوسم إلى Commit الذي بُنيت منه المرفقات فعلًا.

#try-it[
  أضف `make verify-package` يفك الأرشيف إلى مجلد مؤقت آمن، ويشغل
  اختبارًا من داخل الحزمة، ثم يحذف المجلد المؤقت المحدد. يجب أن
  يفشل إذا غاب VERSION أو اختلف عن اسم الأرشيف.
]

#section[اختبارات القبول]

- [ ] لا تُبنى الحزمة قبل نجاح الفحص.
- [ ] يرفض السكربت VERSION غير صالح وشجرة غير نظيفة.
- [ ] الحزمة من Commit محدد لا من ملفات عشوائية غير متعقبة.
- [ ] لا تظهر الأسرار والمؤقتات في قائمة الأعضاء.
- [ ] توجد بصمة وبيانات الإصدار والـCommit.
- [ ] لا يحدث دفع (Push) أو نشر إصدار ضمن البناء المحلي.

#section[ما تعلمناه]

صار التسليم سلسلة أدلة، لا حركة سحب وإفلات. المشروع التالي يطبق
الانضباط نفسه حين يشارك وكيل ذكاء اصطناعي في العمل: نحدد صلاحياته
وبوابات القرار، ثم نتحقق من الأثر لا من بلاغته.

#challenge[
  أنشئ حزمة من وسم محلي، ثم أضف إيداعًا بعده. أثبت أن أرشيف الوسم
  لا يتغير وأن أرشيف HEAD تغير، وسجل كلا المعرفين في تقريرك.
]
