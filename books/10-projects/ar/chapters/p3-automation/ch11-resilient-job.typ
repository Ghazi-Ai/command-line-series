// المشروع التاسع: مهمة آلية تتحمل الفشل
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, danger, try-it, define, challenge, objectives, session

#chapter[المشروع 9: مهمة آلية تتحمل الفشل]

#objectives((
  [تبني مهمة دورية لا تعمل نسختان منها في الوقت نفسه.],
  [تكتب سجلًا وحالةً قابلة للقراءة الآلية.],
  [تميز نجاح التشغيل من حداثة آخر نجاح.],
  [تختبر الفشل قبل ربط المهمة بجدول.],
))

المهمة الآلية لا تتعب، لكنها تستطيع تكرار الخطأ بدقة مذهلة. سنبني
مهمة تولد تقريرًا يوميًا من عينات المختبر، وتمنع التداخل، وتكتب
آخر نجاح وآخر فشل. الجدول يأتي في النهاية، لا البداية.

#define("الفشل الصامت", [
  أن تتوقف المهمة أو تنتج نتيجة ناقصة من دون إشارة تصل إلى من
  يعتمد عليها. وجود سجل لا يكفي إذا لم يقرأه أحد أو لم تُراقب
  حداثة النجاح.
])

#section[التسليم]

```text
09-resilient-job/
├── input/events.csv
├── job.py
├── state/status.json
├── output/report.txt
├── logs/job.log
└── RUNBOOK.md
```

#section[قفل بسيط محمول]

سنستخدم إنشاء ملف حصريًا. أنشئ `job.py`:

```python
from __future__ import annotations

import csv
import json
import os
import sys
from datetime import datetime, timezone
from pathlib import Path

root = Path(__file__).resolve().parent
lock = root / "state" / "job.lock"
status = root / "state" / "status.json"
report = root / "output" / "report.txt"
log = root / "logs" / "job.log"
for d in (lock.parent, report.parent, log.parent):
    d.mkdir(exist_ok=True)

def now():
    return datetime.now(timezone.utc).isoformat()

def write_status(state, message):
    status.write_text(json.dumps({
        "state": state, "time_utc": now(), "message": message
    }, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

try:
    fd = os.open(lock, os.O_CREAT | os.O_EXCL | os.O_WRONLY, 0o600)
except FileExistsError:
    print("مهمة أخرى تعمل أو بقي قفل قديم", file=sys.stderr)
    raise SystemExit(3)

try:
    os.write(fd, f"pid={os.getpid()} time={now()}\n".encode())
    os.close(fd)
    write_status("running", "بدأ التشغيل")

    source = root / "input" / "events.csv"
    with source.open(encoding="utf-8", newline="") as f:
        rows = list(csv.DictReader(f))
    if not rows or "level" not in rows[0]:
        raise ValueError("المدخل فارغ أو لا يحوي حقل level")
    if any(not (row.get("level") or "").strip() for row in rows):
        raise ValueError("توجد قيمة level فارغة")

    counts = {}
    for row in rows:
        level = row["level"].strip()
        counts[level] = counts.get(level, 0) + 1
    body = "\n".join(f"{k}: {counts[k]}" for k in sorted(counts)) + "\n"
    temporary = report.with_suffix(".tmp")
    temporary.write_text(body, encoding="utf-8")
    temporary.replace(report)

    with log.open("a", encoding="utf-8") as f:
        f.write(f"{now()} success rows={len(rows)}\n")
    write_status("success", f"rows={len(rows)}")
except Exception as exc:
    with log.open("a", encoding="utf-8") as f:
        f.write(f"{now()} failure type={type(exc).__name__}\n")
    write_status("failure", f"type={type(exc).__name__}; راجع السجل المنقح")
    raise
finally:
    lock.unlink(missing_ok=True)
```

الكتابة إلى ملف مؤقت ثم استبداله تقلل فرصة أن يقرأ المستفيد نصف
تقرير. لكنها لا تحول كل نظام ملفات إلى معاملة كاملة.

#section[اختبر يدويًا]

```bash
python3 job.py
cat output/report.txt
python3 -m json.tool state/status.json
tail -n 5 logs/job.log
```

أنشئ قفلًا يدويًا ثم شغل المهمة؛ ينبغي أن ترفض. احذف القفل بعد أن
تتأكد أن لا عملية حقيقية تعمل.

#warn[
  القفل الملفي البسيط قد يبقى بعد انهيار قاسٍ. لا تحذف قفل إنتاج
  آليًا لمجرد قدمه؛ اقرأ PID والزمن، وتحقق من العملية، ووثق قرار
  إزالة القفل.
]

#section[اكسر المدخل]

غير نسخة العينة بحيث يغيب عمود `level`. ينبغي:

- ألا يستبدل التقرير السليم بنصف مخرج.
- تصبح الحالة `failure`.
- يسجل نوع الخطأ بلا نسخ نص الاستثناء أو محتوى حساس إلى الحالة.
- يخرج البرنامج برمز غير صفري.
- يزول القفل في `finally`.

أعد المدخل وشغل، ثم أثبت عودة `success`.

#section[اربطها بجدول بعد الاختبارات]

على لينكس الحديث يمكن استعمال مدير الخدمات «سيستم دي» (`systemd`)
ومؤقتاته، وعلى ماك `launchd`، وعلى ويندوز «مجدول المهام»، وعلى بي
إس دي `cron`. لا
تنسخ ملف خدمة بين هذه الأنظمة.

للتجربة على لينكس، اجعل الخدمة تعمل بحسابك وبمسارات مطلقة. شغلها
يدويًا من `systemd` وتحقق من السجل قبل تفعيل المؤقت. لا تبدأ بمؤقت
كل دقيقة على خادم إنتاج.

#note[
  الجدولة ليست مراقبة. قد يستدعي الجدول المهمة كل يوم بينما تفشل
  منذ شهر. راقب حداثة `status.json` وحالته، لا وجود الجدول فقط.
]

#section[اختبار الحداثة]

اكتب فاحصًا صغيرًا يقرأ `time_utc` ويقرر هل آخر نجاح أقدم من حدك.
تعامل مع غياب الملف أو خطأ JSON بوصفه فشلًا، لا «لا أخبار جيدة».

#try-it[
  أضف `run_id` عشوائيًا لكل تشغيل، واكتبه في الحالة والسجل. يجب أن
  تستطيع ربط سطر البداية بالنهاية، وأن ترى تشغيلًا بدأ ولم يصل إلى
  نهاية إن قتلت العملية في المختبر.
]

#section[اختبارات القبول]

- [ ] التشغيل اليدوي ينجح قبل الجدولة.
- [ ] لا تعمل نسختان بالتزامن.
- [ ] المخرج يستبدل ذريًا قدر الإمكان.
- [ ] الفشل يكتب حالة ورمز خروج ولا يمحو آخر تقرير سليم.
- [ ] التعافي يعيد حالة النجاح.
- [ ] توجد طريقة لكشف تقادم آخر نجاح.

#section[ما تعلمناه]

لم تعد الأتمتة «سكربتًا في cron»؛ أصبحت مهمة لها قفل وحالة وسجل
وفشل وتعافٍ. المشروع التالي يمنحها وجهًا شبكيًا صغيرًا: خدمة محلية
تعلن هل هي حية وهل هي جاهزة.

#challenge[
  أضف مهلة قصوى لقراءة المدخل أو لمعالجة مصطنعة، واختبر أن تجاوزها
  يترك حالة فشل مفهومة ولا يترك قفلًا دائمًا.
]
