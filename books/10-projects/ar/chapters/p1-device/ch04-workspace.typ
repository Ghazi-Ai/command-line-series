// المشروع الثاني: مساحة عمل لا تضيع
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, try-it, define, challenge, objectives, session

#chapter[المشروع 2: مساحة عمل لا تضيع]

#objectives((
  [تبني قالب مشروع يعيد إنشاء البنية نفسها.],
  [تفصل المدخلات والمخرجات والسجلات والمؤقتات.],
  [تستخدم Git لحفظ القرارات لا لحفظ الأسرار والضوضاء.],
  [تثبت أن شخصًا آخر يستطيع بدء مشروع من القالب.],
))

أكثر المشروعات لا تضيع لأن القرص تعطل؛ تضيع لأن أحدًا لا يعرف أي
ملف هو الأصل، وأي مخرج يمكن توليده، وأي أمر شغّل آخر مرة. سنبني
قالبًا صغيرًا يجعل المكان يشرح نفسه.

#section[التسليم]

```text
02-workspace-template/
├── README.md
├── PLAN.md
├── RUNBOOK.md
├── ACCEPTANCE.md
├── CHANGELOG.md
├── .gitignore
├── input/
├── src/
├── output/
├── logs/
├── tmp/
└── tools/
    └── init_project.py
```

#define("المصدر القابل للتعقب", [
  ملف كتبه الإنسان أو مدخل اعتمده المشروع ويجب حفظه ومراجعته. أما
  المخرج القابل لإعادة التوليد فلا يعامل تلقائيًا بوصفه مصدرًا.
])

#section[القالب]

أنشئ الملفات الفارغة، ثم اكتب `.gitignore`:

```gitignore
output/
logs/
tmp/
.env
.venv/
__pycache__/
*.key
*.pem
```

لا تتجاهل `input/` آليًا. بعض المدخلات جزء من المثال، وبعضها بيانات
شخصية أو كبيرة. اكتب القرار في README، واستعمل عينات مصطنعة في
المستودع بدل الأصل الحساس.

#section[مولّد القالب]

أنشئ `tools/init_project.py`:

```python
from __future__ import annotations

import argparse
from pathlib import Path

DIRS = ("input", "src", "output", "logs", "tmp", "tools")
DOCS = ("README.md", "PLAN.md", "RUNBOOK.md", "ACCEPTANCE.md", "CHANGELOG.md")

parser = argparse.ArgumentParser()
parser.add_argument("name", help="اسم بسيط من حروف لاتينية وأرقام وشرطات")
args = parser.parse_args()

name = args.name
if not name or any(c not in "abcdefghijklmnopqrstuvwxyz0123456789-" for c in name):
    raise SystemExit("الاسم غير صالح؛ استعمل a-z و0-9 والشرطة فقط")

root = Path.cwd() / name
root.mkdir(exist_ok=False)
for d in DIRS:
    (root / d).mkdir()
for f in DOCS:
    (root / f).write_text(f"# {name}\n", encoding="utf-8")
(root / ".gitignore").write_text(
    "output/\nlogs/\ntmp/\n.env\n.venv/\n__pycache__/\n*.key\n*.pem\n",
    encoding="utf-8",
)
print(root)
```

من المجلد الأم:

```bash
python3 02-workspace-template/tools/init_project.py demo-project
find demo-project -maxdepth 2 -print | LC_ALL=C sort
```

استخدم `exist_ok=False` عمدًا. لا نريد مولدًا «لطيفًا» يدخل مجلدًا
قديمًا ويكتب فوق ملفات صاحبه.

#section[أول تاريخ]

```bash
cd demo-project
git init
git status --short
git add README.md PLAN.md RUNBOOK.md ACCEPTANCE.md CHANGELOG.md .gitignore
git commit -m "chore: initialize project workspace"
```

إذا لم يكن اسم Git وبريده مضبوطين، سيطلبهما. لا تخترع هوية ولا
تغير إعدادًا عامًا على جهاز شخص آخر. يمكن ضبط الهوية داخل المستودع
وفق سياقك.

#subsection[ما الذي لا يدخل Commit؟]

- سر أو مفتاح أو ملف جلسة.
- ناتج ضخم يمكن بناؤه من المصدر.
- سجل تشغيل يومي بلا حاجة للمراجعة.
- مدخل شخصي استُبدل بعينة.
- بيئة افتراضية كاملة.

لكن لا تجعل القاعدة آلية بلا تفكير. أحيانًا يكون الناتج المنشور
أصلًا مطلوبًا، مثل PDF معتمد أو صورة محسنة. وثق الاستثناء.

#section[اختبر القالب من مكان جديد]

شغّل المولد باسم آخر. ثم اطلب منه الاسم غير الصالح `../escape`.
ينبغي أن يرفضه. هذا الاختبار ليس تجميليًا؛ يمنع خروج المولد من
المجلد المقصود.

#session("python3 tools/init_project.py ../escape", output: "الاسم غير صالح؛ استعمل a-z و0-9 والشرطة فقط")

#warn[
  منع `../` لا يجعل كل مولد آمنًا. تجنب أيضًا الروابط الرمزية
  والمجلدات الموجودة، ولا تمنح أداة إنشاء القالب صلاحية المدير.
]

#section[اجعل README باب الدخول]

لا تبدأ README بتاريخ المشروع. ابدأ بما يحتاجه القادم:

```markdown
# اسم المشروع

جملة واحدة: ما المشكلة التي يحلها؟

## البدء السريع
1. المتطلبات.
2. الأمر الآمن الأول.
3. المخرج المتوقع.

## الحدود
- ما يقرأه.
- ما يكتبه.
- ما لا يلمسه.

## التحقق والتنظيف
```

#tip[
  إذا احتاج القادم إلى قراءة الشيفرة ليعرف أول أمر، فوثيقة البدء
  ناقصة. وإذا احتاج إلى تخمين أثر الأمر، فالحدود ناقصة.
]

#try-it[
  أضف خيار `--dry-run` إلى المولد يعرض الشجرة التي سينشئها من دون
  الكتابة. اختبر أن المسار لا يظهر بعد التشغيل الجاف، ثم أن التشغيل
  الحقيقي ينشئه مرة واحدة ويرفض الثانية.
]

#section[اختبارات القبول]

- [ ] ينشئ المولد مشروعًا جديدًا كامل الشجرة.
- [ ] يرفض الاسم الذي يحاول الخروج من المجلد.
- [ ] يرفض الكتابة في مشروع موجود.
- [ ] لا يتعقب Git المخرجات والمؤقتات والأسرار.
- [ ] يستطيع شخص آخر العثور على أمر البدء والحدود في README.
- [ ] يوجد Commit أول واضح للمصادر فقط.

#section[ما تعلمناه]

أنشأنا مكانًا يعيد نفسه ولا يخلط المصدر بالناتج. في المشروع التالي
ندخل إليه دفعة ملفات فوضوية، ونبني مصنعًا لا يغير الأصل ولا يخفي
ما فعله.

#challenge[
  أنشئ مشروعًا بالقالب، ثم سلّمه لزميل أو وكيل واطلب منه إضافة
  ملف عينة وتشغيل اختبار قبول من دون سؤال. سجل كل سؤال اضطر إلى
  طرحه، وحوّل الإجابة المتكررة إلى توثيق.
]
