// المشروع الثالث: مصنع ملفات من الفوضى
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, danger, try-it, define, challenge, objectives

#chapter[المشروع 3: مصنع ملفات من الفوضى]

#objectives((
  [تحول دفعة ملفات إلى مخرجات منظمة من دون تعديل الأصل.],
  [تسجل كل ملف في بيان يحوي الاسم والحجم والبصمة.],
  [تتعامل مع التصادم والامتداد المجهول بقرار صريح.],
  [تعيد التشغيل وتحصل على نتيجة مفهومة لا نسخ متراكمة.],
))

مجلد التنزيلات مثال صغير على مشكلة كبيرة: أسماء غير متسقة، نسخ
متعددة، امتدادات بحروف مختلفة، وملف لا تعرف من أين جاء. الحذف
والنقل بالعين يصلحان لعشرة ملفات؛ لا يصلحان لمصنع.

سننسخ عينة إلى مجلدات بحسب الامتداد، وننشئ بيانًا بصيغة القيم
المفصولة بفواصل (CSV). لا نحاول تفسير محتوى الملف أو الثقة
بالامتداد؛ هذا مشروع تنظيم، لا ماسح برمجيات خبيثة.

#section[بطاقة المشروع]

```text
المدخل: input/ للقراءة فقط.
المخرج: output/by-extension/ وoutput/manifest.csv.
الخارج: مجلد التنزيلات الحقيقي.
قرار التصادم: لا كتابة فوق ملف؛ أضف جزءًا من البصمة للاسم.
قرار المجهول: ضعه في _no-extension أو اسم الامتداد المنقح.
```

#section[اصنع العينة]

```bash
mkdir -p 03-file-factory/{input,output,tools,logs}
cd 03-file-factory
printf 'ألف\n' > 'input/report final.TXT'
printf 'باء\n' > 'input/report-final.txt'
printf '{}' > input/data.JSON
printf 'بلا امتداد\n' > input/README
```

سجل البصمات قبل العمل.

#section[المعالج]

أنشئ `tools/organize.py`:

```python
from __future__ import annotations

import csv
import hashlib
import shutil
from pathlib import Path

root = Path(__file__).resolve().parents[1]
source = root / "input"
target = root / "output" / "by-extension"
manifest = root / "output" / "manifest.csv"

if not source.is_dir():
    raise SystemExit(f"مجلد المدخل غير موجود: {source}")

target.mkdir(parents=True, exist_ok=True)
rows = []

for src in sorted(p for p in source.rglob("*") if p.is_file()):
    digest = hashlib.sha256(src.read_bytes()).hexdigest()
    suffix = src.suffix.lower().lstrip(".") or "_no-extension"
    safe_suffix = "".join(c for c in suffix if c.isalnum() or c in "-_")
    safe_suffix = safe_suffix or "_unknown"
    folder = target / safe_suffix
    folder.mkdir(exist_ok=True)

    dst = folder / src.name
    if dst.exists() and hashlib.sha256(dst.read_bytes()).hexdigest() != digest:
        dst = folder / f"{src.stem}-{digest[:10]}{src.suffix.lower()}"

    if not dst.exists():
        shutil.copy2(src, dst)

    rows.append({
        "source": src.relative_to(source).as_posix(),
        "output": dst.relative_to(root / "output").as_posix(),
        "bytes": src.stat().st_size,
        "sha256": digest,
    })

manifest.parent.mkdir(exist_ok=True)
with manifest.open("w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=("source", "output", "bytes", "sha256"))
    writer.writeheader()
    writer.writerows(rows)

print(f"processed={len(rows)} manifest={manifest}")
```

استخدمنا `src.read_bytes()` لبساطة العينة، لا لأنه الأنسب لكل حجم.
للملفات الكبيرة ينبغي قراءة أجزاء متتابعة. سنصحح ذلك في التحدي.

#section[نفذ واقرأ البيان]

```bash
python3 tools/organize.py
find output -type f -print | LC_ALL=C sort
python3 - <<'PY'
import csv
with open("output/manifest.csv", encoding="utf-8") as f:
    for row in csv.DictReader(f):
        print(row["source"], "->", row["output"], row["bytes"])
PY
```

شغّل البرنامج ثانية. لا ينبغي أن تتضاعف الملفات. هذا معنى بسيط
لإمكان تكرار التشغيل من دون تضخيم النتيجة.

#define("التكرار الآمن", [
  أن يعيد التشغيل الوصول إلى الحالة المطلوبة أو يؤكدها من دون
  آثار متراكمة غير مقصودة. لا يعني بالضرورة أن كل بايت في السجل
  سيكون متطابقًا.
])

#section[لا تثق بالامتداد]

ملف اسمه `.jpg` قد لا يكون صورة. مشروعنا يصنف الاسم فقط. اكتب في
README:

```text
التصنيف شكلي بحسب الامتداد، ولا يثبت نوع المحتوى أو سلامته.
لا تُفتح الملفات غير الموثوقة تلقائيًا.
```

#warn[
  لا تجعل المصنع يشغل الملف أو يستدعي برنامجًا بحسب امتداده. مدخل
  غير موثوق قد يتحول من بيانات إلى شيفرة. القراءة والنسخ أقل خطرًا
  من «المعالجة الذكية» غير المحددة.
]

#section[اكسر التصادم]

أضف ملفين بالاسم نفسه داخل مجلدين فرعيين وبمحتويين مختلفين:

```bash
mkdir -p input/a input/b
printf 'one\n' > input/a/same.txt
printf 'two\n' > input/b/same.txt
python3 tools/organize.py
```

ينبغي أن يحتفظ المصنع بكليهما، وأن يظهر مسار كل مصدر في البيان.
إذا كتب أحدهما فوق الآخر فقد فشل اختبار القبول حتى لو خرج بصفر.

#section[تنظيف محسوب]

المخرج قابل للتوليد، لكن لا تحذفه قبل التأكد أن المصدر والبرنامج
والبيان محفوظة. أبسط تنظيف أثناء المختبر:

```bash
find output -maxdepth 2 -type f -print
```

راجع، ثم احذف مجلد `output` الصريح وأعد التشغيل. يجب أن يعيد
المصنع النتيجة.

#danger[
  لا تحول التنظيف إلى `rm -rf output/*` من دليل قد يتغير. انتقل
  إلى جذر المشروع المثبت، واطبع `pwd`، وتحقق من وجود `tools/organize.py`
  قبل حذف المخرج التجريبي.
]

#try-it[
  استبدل حساب البصمة بقراءة الملف في أجزاء حجمها 1 MiB، ثم أنشئ
  ملفًا أكبر من الذاكرة التي ترغب باستهلاكها. راقب الذاكرة وتأكد
  أن البصمة تطابق `sha256sum` أو`Get-FileHash`.
]

#section[اختبارات القبول]

- [ ] لا يتغير شيء داخل `input/`.
- [ ] لكل ملف مدخل صف واحد في البيان.
- [ ] البصمة في البيان تطابق الأصل والمخرج.
- [ ] يحفظ التصادم الملفين ولا يكتب فوقهما.
- [ ] التشغيل الثاني لا يضاعف النتيجة.
- [ ] يمكن حذف `output` وإعادة توليده.

#section[ما تعلمناه]

حولنا النقل اليدوي إلى عملية لها سياسة وبيان ورجوع. في المشروع
التالي لا نرتب الملفات فقط؛ نبني أرشيفًا نصيًا يمكن سؤاله من
الطرفية بدل فتح كل وثيقة على حدة.

#challenge[
  أضف وضعًا جافًا `--dry-run` يكتب البيان المتوقع إلى الطرفية ولا
  ينشئ مخرجًا. اختبره على التصادم، ثم قارن قراره بالتشغيل الحقيقي.
]
