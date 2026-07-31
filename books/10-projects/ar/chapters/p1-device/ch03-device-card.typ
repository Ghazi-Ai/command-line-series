// المشروع الأول: بطاقة جهاز قابلة للتحديث
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, try-it, define, challenge, objectives, session

#chapter[المشروع 1: بطاقة جهاز قابلة للتحديث]

#objectives((
  [تجمع وصفًا تقنيًا مفيدًا بلا أسرار.],
  [تنتج ملفًا بصيغة جيسون (JSON) يقرأه الإنسان والبرنامج.],
  [تفصل الحقائق المجمعة آليًا من الملاحظات التحريرية.],
  [تثبت أن البطاقة قابلة للتحديث والمقارنة.],
))

حين يتعطل جهاز، تبدأ الأسئلة التي كان ينبغي أن تكون لها إجابة:
ما النظام؟ كم المساحة الحرة؟ ما إصدار بايثون؟ هل الجهاز نفسه الذي
نجح عليه البناء بالأمس؟ مشروعنا الأول بطاقة تُنشأ بأمر واحد، لا
لقطة شاشة تموت لحظة التقاطها.

#section[التسليم]

```text
01-device-card/
├── README.md
├── collect.py
├── output/
│   ├── machine.json
│   └── machine.txt
└── ACCEPTANCE.md
```

لن نجمع أسماء الشبكات اللاسلكية ولا العنوان العام ولا قائمة كل
عملية ولا متغيرات البيئة؛ لأن بعضها يكشف مستخدمًا أو سرًا ولا يخدم
حاجة البطاقة.

#define("الجرد الأدنى", [
  أقل مجموعة حقائق تكفي لاتخاذ قرار أو تشخيص فرق: النظام والمعمارية
  وإصدار الأداة والمساحة المتاحة والزمن، من دون جمع بيانات لمجرد
  إمكان جمعها.
])

#section[اكتب الجامع]

أنشئ `collect.py`:

```python
from __future__ import annotations

import json
import os
import platform
import shutil
import socket
import sys
from datetime import datetime, timezone
from pathlib import Path

root = Path(__file__).resolve().parent
out = root / "output"
out.mkdir(exist_ok=True)

disk = shutil.disk_usage(root)
data = {
    "schema": 1,
    "collected_at_utc": datetime.now(timezone.utc).isoformat(),
    "host_label": socket.gethostname(),
    "os": platform.system(),
    "os_release": platform.release(),
    "machine": platform.machine(),
    "python": platform.python_version(),
    "logical_cpus": os.cpu_count(),
    "project_disk_total_bytes": disk.total,
    "project_disk_free_bytes": disk.free,
}

(out / "machine.json").write_text(
    json.dumps(data, ensure_ascii=False, indent=2) + "\n",
    encoding="utf-8",
)

lines = [f"{key}: {value}" for key, value in data.items()]
(out / "machine.txt").write_text("\n".join(lines) + "\n", encoding="utf-8")
print(out / "machine.json")
```

شغله:

```bash
python3 collect.py
python3 -m json.tool output/machine.json
```

في ويندوز قد يكون الأمر `py collect.py` إذا كان مشغل بايثون هو
المثبت. لا تغير البرنامج؛ غير طريقة الاستدعاء فقط.

#note[
  اسم المضيف قد يكشف اسم شخص أو شركة. إذا ستنشر البطاقة، استبدله
  بوسم مثل `workstation-01` أو أضف خيارًا يحجبه. «ليس كلمة مرور» لا
  يعني «مناسب للنشر».
]

#section[افصل الحقيقة من الرأي]

الملف الآلي يقول إن المساحة الحرة رقم. أما «المساحة تكفي لبناء
الكتب» فاستنتاج يعتمد على حاجة المشروع. ضع الاستنتاج في `README.md`:

```markdown
# بطاقة الجهاز

## الغرض
تثبيت البيئة التي بُني عليها المشروع ومقارنة التغير بمرور الزمن.

## ما لا نجمعه
- مفاتيح أو رموز وصول.
- متغيرات البيئة كاملة.
- عناوين عامة أو شبكات مجاورة.

## التفسير
تحتاج عملية البناء الحالية إلى 8 GiB مساحة مؤقتة على الأقل.
```

#section[قارن بطاقتين]

احتفظ بنسخة أولى:

```bash
cp output/machine.json output/machine-baseline.json
python3 collect.py
diff -u output/machine-baseline.json output/machine.json
```

سيتغير الزمن دائمًا، وقد تتغير المساحة. الهدف أن ترى الفرق وتقرر
هل هو متوقع. لا تجعل الاختبار يطلب تطابق الملف كاملًا.

#subsection[اختبار البنية]

```bash
python3 - <<'PY'
import json
from pathlib import Path

d = json.loads(Path("output/machine.json").read_text(encoding="utf-8"))
required = {"schema", "collected_at_utc", "os", "machine", "python"}
missing = required - d.keys()
assert not missing, f"حقول مفقودة: {sorted(missing)}"
assert d["schema"] == 1
print("البنية سليمة")
PY
```

#section[اختبار الفشل]

غيّر مؤقتًا اسم مجلد `output` إلى ملف عادي، ثم شغل الجامع. ينبغي أن
يفشل برسالة واضحة وألا يمسح الملف. أعد الاسم بعد تسجيل النتيجة. هذا
يكشف افتراضًا: البرنامج يحتاج أن يكون `output` مجلدًا أو قابلًا
للإنشاء.

#warn[
  لا تشغل جامع معلومات مجهول بصلاحية المدير. برنامج الجرد الجيد
  يصرح بما يجمع ويحفظ محليًا ويعمل بأقل صلاحية.
]

#try-it[
  أضف حقلًا يخدم مشروعك فعلًا، مثل إصدار `git` عبر
  `subprocess.run(["git", "--version"], ...)`. تعامل مع غياب الأداة
  بوصفه قيمة معروفة، لا انهيارًا غامضًا. وثق سبب الحقل.
]

#section[اختبارات القبول]

- [ ] ينشأ `machine.json` و`machine.txt` بأمر واحد.
- [ ] JSON صالح ويحتوي الحقول المطلوبة.
- [ ] لا توجد أسرار أو قائمة متغيرات بيئة.
- [ ] يذكر README ما لا يُجمع.
- [ ] يظهر الفرق بين بطاقتين بلا توقع تطابق الزمن والمساحة.
- [ ] جُرب فشل واحد وسُجل.

#section[ما تعلمناه]

سلّمنا أصلًا صغيرًا لكنه حقيقي: وصفًا يمكن تحديثه وقراءته آليًا.
المشروع التالي يبني المكان الذي ستعيش فيه الأصول من دون أن تتحول
المشروعات العشرون إلى كومة أسماء مبهمة.

#challenge[
  أنشئ نسخة منقحة للنشر اسمها `machine-public.json`. لا تحذف الحقول
  يدويًا بعد كل تشغيل؛ أضف إلى البرنامج قائمة سماح للحقول العامة،
  ثم اختبر أن `host_label` لا يظهر فيها.
]
