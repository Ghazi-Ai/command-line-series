// المشروع السابع: حارس سلامة الملفات
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, try-it, define, challenge, objectives, session

#chapter[المشروع 7: حارس سلامة الملفات]

#objectives((
  [تنشئ بيان بصمات بطريقة لا تحمل الملف كاملًا في الذاكرة.],
  [تصنف الملفات إلى سليم ومتغير ومفقود وجديد.],
  [تحمي خط الأساس من التعديل العارض.],
  [تفهم أن تغير البصمة دليل تغير لا دليل هوية الفاعل.],
))

نريد أن نعرف هل تغيرت ملفات إعداد مختارة منذ اعتمادها. مقارنة
التاريخ والحجم تساعد، لكن البصمة أقوى للكشف عن تغير المحتوى. سنبني
بيانًا ونقارنه بالحالة الحالية.

#define("خط أساس السلامة", [
  قائمة معتمدة من المسارات والبصمات تمثل حالة سليمة معروفة في زمن
  محدد. إذا استطاع من يغير الملفات تغيير الخط الأساس نفسه، ضعفت
  قيمته.
])

#section[التسليم]

```text
07-integrity-guard/
├── protected-demo/
├── tools/integrity.py
├── baseline.json
└── output/report.json
```

لا تبدأ بـ`/etc` كله. اختر عينة مصطنعة أو ملفات إعداد تملكها. كثرة
الضوضاء تجعل الحارس يُهمل.

#section[البرنامج]

```python
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path

root = Path(__file__).resolve().parent
protected = root / "protected-demo"
baseline_path = root / "baseline.json"
report_path = root / "output" / "report.json"

def digest(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()

def snapshot() -> dict[str, str]:
    return {
        p.relative_to(protected).as_posix(): digest(p)
        for p in sorted(protected.rglob("*")) if p.is_file()
    }

parser = argparse.ArgumentParser()
parser.add_argument("command", choices=("init", "check"))
args = parser.parse_args()

if args.command == "init":
    if baseline_path.exists():
        raise SystemExit("خط الأساس موجود؛ لن أستبدله صامتًا")
    baseline_path.write_text(
        json.dumps(snapshot(), indent=2) + "\n", encoding="utf-8"
    )
    print(baseline_path)
else:
    expected = json.loads(baseline_path.read_text(encoding="utf-8"))
    current = snapshot()
    report = {
        "ok": sorted(k for k in expected.keys() & current.keys()
                     if expected[k] == current[k]),
        "changed": sorted(k for k in expected.keys() & current.keys()
                          if expected[k] != current[k]),
        "missing": sorted(expected.keys() - current.keys()),
        "new": sorted(current.keys() - expected.keys()),
    }
    report_path.parent.mkdir(exist_ok=True)
    report_path.write_text(
        json.dumps(report, indent=2) + "\n", encoding="utf-8"
    )
    print(report_path)
    raise SystemExit(1 if report["changed"] or report["missing"] else 0)
```

لم نجعل الملف الجديد فشلًا تلقائيًا؛ قد تسمح السياسة به. يمكنك
تغيير القرار، لكن وثقه.

#section[أنشئ واعتمد]

```bash
python3 integrity.py init
python3 integrity.py check
```

اقرأ `baseline.json` قبل اعتباره معتمدًا. ثم احفظ بصمته في مكان
منفصل أو إيداع (Commit) موثوق:

```bash
sha256sum baseline.json
```

#section[اختبر الحالات الأربع]

1. لا تغير شيئًا: يظهر الملف تحت `ok`.
2. غير ملفًا: يظهر تحت `changed` ويخرج البرنامج برمز 1.
3. احذف ملفًا: يظهر تحت `missing`.
4. أضف ملفًا: يظهر تحت `new`.

#session("python3 integrity.py check", output: ".../output/report.json")

#section[ما الذي لا تثبته البصمة؟]

إذا تغير الملف، لا تعرف البصمة هل السبب تحديثًا مشروعًا أو تلفًا
أو مهاجمًا. وإذا لم يتغير، لا تعرف هل شغّل أحد أمرًا ضارًا لم يكتب
في هذه الملفات. الحارس يجيب سؤالًا محدودًا: هل البايتات الحالية
تطابق الخط الأساس؟

#warn[
  لا تعلن «لا اختراق» لأن تقرير البصمات أخضر. سلامة الملفات طبقة
  واحدة ضمن سجلات وصلاحيات وعمليات وشبكة وتحديثات وتحقق مستقل.
]

#section[تحديث خط الأساس قرار]

لا تضف خيارًا يستبدل الخط الأساس عند كل اختلاف؛ سيحوّل الإنذار إلى
اعتماد تلقائي للتغيير. اتبع:

```text
تغيير مخطط
→ مراجعة الفرق
→ اختبار الخدمة
→ موافقة
→ إنشاء خط أساس جديد باسم مؤرخ
→ حفظ سبب الاعتماد
```

#tip[
  احفظ خطوط الأساس مؤرخة بدل استبدال ملف واحد أثناء التعلم. يسهل
  ذلك معرفة متى دخل التغير ومن وافق عليه.
]

#try-it[
  أضف إلى البيان الحجم ووضع الصلاحية بجانب البصمة. اجعل المقارنة
  تميز تغير المحتوى من تغير الصلاحية. لا تحاول توحيد صلاحيات
  ويندوز مع POSIX في رقم واحد بلا شرح.
]

#section[اختبارات القبول]

- [ ] يرفض `init` استبدال خط أساس موجود.
- [ ] يحسب البصمة في أجزاء.
- [ ] يميز الحالات الأربع.
- [ ] يخرج برمز غير صفري عند تغير أو فقد ملف معتمد.
- [ ] خط الأساس محفوظ أو مبصوم في موضع مستقل.
- [ ] التوثيق لا يساوي بين التغير والاختراق.

#section[ما تعلمناه]

أصبح لدينا شاهد يقارن الحاضر بحالة سليمة معروفة. لكن الحارس لا
يعيد ملفًا مفقودًا. المشروع التالي يجمع النسخة والبصمة والزمن في
تمرين تعافٍ كامل، لأن الخطة التي لم تتمرن عليها فرضية.

#challenge[
  أضف قائمة سماح لمسارات محددة في ملف إعداد، وارفض المسار المطلق
  أو `..`. اختبر أن الأداة لا تستطيع الخروج من `protected-demo`.
]
