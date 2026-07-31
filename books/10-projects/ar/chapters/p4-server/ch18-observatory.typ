// المشروع السادس عشر: مرصد خدمة وتنبيه ونسخ
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, danger, try-it, define, challenge, objectives, session

#chapter[المشروع 16: مرصد خدمة وتنبيه ونسخ]

#objectives((
  [تحول الصحة والقرص والنسخة إلى قياسات ذات حدود.],
  [تشغل الفاحص دوريًا بخدمة ومؤقت systemd.],
  [تمنع التنبيه الدائم والنجاح الوهمي.],
  [تكتب لوحة حالة صغيرة وتمرن عطلًا وتعافيًا.],
))

المراقبة ليست نافذة خضراء. هي أسئلة متكررة تصل نتيجتها إلى شخص
قادر على الفعل. سنبني فاحصًا محليًا يختبر الخدمة والمساحة وحداثة
آخر نسخة، ويكتب JSON ورمز خروج. ثم يشغله مؤقت.

#define("مؤشر قابل للفعل", [
  قياس له حد ورسالة وصاحب وخطوة أولى. «القرص 81%» معلومة؛ «تجاوز
  حد 80%، راجع أكبر ثلاثة مسارات وسياسة الاحتفاظ» إنذار قابل للفعل.
])

#section[الفاحص]

أنشئ `/opt/terminal-observer/check.py` بملكية إدارية وقراءة مناسبة:

```python
from __future__ import annotations

import json
import shutil
import subprocess
import time
from pathlib import Path

status_path = Path("/var/lib/terminal-observer/status.json")
backup_marker = Path("/var/backups/terminal-site/latest.ok")
checks = []

def add(name, ok, detail):
    checks.append({"name": name, "ok": bool(ok), "detail": detail})

curl = subprocess.run(
    ["curl", "--fail", "--silent", "--show-error", "--max-time", "5",
     "http://127.0.0.1/"],
    text=True, capture_output=True,
)
add("http-local", curl.returncode == 0,
    "ok" if curl.returncode == 0 else f"curl-exit={curl.returncode}")

disk = shutil.disk_usage("/")
used_percent = round((disk.used / disk.total) * 100, 1)
add("disk-root", used_percent < 80, f"used_percent={used_percent}")

if backup_marker.exists():
    age_hours = round((time.time() - backup_marker.stat().st_mtime) / 3600, 1)
    add("backup-age", 0 <= age_hours < 30, f"age_hours={age_hours}")
else:
    add("backup-age", False, "marker-missing")

payload = {"schema": 1, "time_epoch": int(time.time()), "checks": checks}
status_path.parent.mkdir(parents=True, exist_ok=True)
tmp = status_path.with_suffix(".tmp")
tmp.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
tmp.replace(status_path)

failed = [c["name"] for c in checks if not c["ok"]]
print("failed=" + ",".join(failed) if failed else "all-checks-ok")
raise SystemExit(1 if failed else 0)
```

ملف `latest.ok` لا يُلمس لمجرد أن أمر النسخ بدأ؛ تحدثه عملية النسخ
بعد تحقق الأرشيف أو الاختبار الذي اعتمدته.

#section[شغله بحساب محدود]

أنشئ مستخدم نظام لا يملك صدفة دخول، وثبّت البرنامج بملكية إدارية،
وأنشئ مجلد الحالة بملكية ذلك المستخدم. تحقق من الأسماء والسياسة
في إصدار نظامك قبل التنفيذ، ولا تستبدل حسابًا موجودًا. ثم أنشئ وحدة
`/etc/systemd/system/terminal-observer.service`:

```ini
[Unit]
Description=Terminal project health checks

[Service]
Type=oneshot
User=terminal-observer
Group=terminal-observer
ExecStart=/usr/bin/python3 /opt/terminal-observer/check.py
NoNewPrivileges=true
PrivateTmp=true
ProtectHome=true
ProtectSystem=strict
ReadWritePaths=/var/lib/terminal-observer
```

امنح الحساب قراءة ما يحتاجه فقط وكتابة مجلد حالته، لا `sudo`.
اختبر الوحدة يدويًا:

```bash
sudo systemd-analyze verify /etc/systemd/system/terminal-observer.service
sudo systemctl daemon-reload
sudo systemctl start terminal-observer.service
sudo systemctl status terminal-observer.service --no-pager
sudo journalctl -u terminal-observer.service -n 30 --no-pager
```

#section[المؤقت]

`/etc/systemd/system/terminal-observer.timer`:

```ini
[Unit]
Description=Run terminal project health checks every five minutes

[Timer]
OnBootSec=2min
OnUnitActiveSec=5min

[Install]
WantedBy=timers.target
```

ثم:

```bash
sudo systemd-analyze verify /etc/systemd/system/terminal-observer.timer
sudo systemctl daemon-reload
sudo systemctl enable --now terminal-observer.timer
systemctl list-timers terminal-observer.timer
```

#warn[
  مؤقت كل خمس دقائق مثال لمختبر صغير. كثرة الفحوص قد تصبح حملًا،
  وقلتها قد تؤخر الكشف. اختر التواتر من زمن الاستجابة المطلوب وكلفة
  الفحص. خيار `Persistent=` لا يعوض التشغيلات الفائتة هنا؛ فهو يؤثر
  في مؤقتات `OnCalendar=` فقط وفق توثيق systemd.
]

#section[من الفشل إلى تنبيه]

رمز خروج غير صفري يظهر في systemd والسجل، لكنه لا يوقظك. اربطه
بطريقة إخطار تناسبك: خدمة مراقبة خارجية، بريد محلي مضبوط، أو
`OnFailure=` إلى وحدة ترسل حدثًا محدودًا. لا تضع رمز webhook داخل
ملف عام أو نص الوحدة إن كان يمكن حفظه في صلاحية أضيق.

اكتب لكل تنبيه:

```text
الاسم:
الحد:
المالك:
القناة:
الخطوة الأولى:
متى يصعّد؟
كيف يسكت أثناء صيانة مخططة؟
```

#section[المراقبة من الداخل لا تكفي]

فحص `127.0.0.1` لا يرى DNS ولا طريق الإنترنت ولا الشهادة. أضف فاحصًا
من جهاز أو خدمة خارج الخادم إلى `https://app.example.com/`. لا
تجعل الفاحصين يقرآن المصدر نفسه؛ نريد منظورين.

#note[
  المراقبة الخارجية قد تجمع عنوانًا وزمن توفر عند طرف ثالث. راجع
  الخصوصية والاحتفاظ، ولا ترسل أسرارًا في رابط الصحة.
]

#section[اختبر الإنذار والتعافي]

في نافذة صيانة:

1. أوقف خدمة الخلفية أو ضع علامة نسخة قديمة في المختبر.
2. شغل الفاحص يدويًا.
3. تحقق من رمز الخروج وJSON والسجل والتنبيه.
4. أعد الخدمة أو العلامة.
5. شغل ثانية وتحقق من رسالة التعافي.

الإنذار الذي لم يُختبر قد يكون ديكورًا، والتنبيه الذي لا يرسل
تعافيًا يترك الناس يظنون أن الحادث مستمر.

#danger[
  لا تملأ القرص الحقيقي لاختبار حد المساحة. اختبر دالة القرار
  بقيمة مصطنعة أو اجعل مسارًا تجريبيًا على نظام ملفات محدودًا.
]

#try-it[
  أضف فحصًا لعمر الشهادة من عميل خارجي وفحصًا لوحدة الخلفية. اجعل
  التقرير يميز «فشل الفحص نفسه» من «الخدمة غير سليمة»، ثم تمرن
  انقطاعًا واحدًا فقط.
]

#section[اختبارات القبول]

- [ ] لكل قياس حد وتفصيل محدود.
- [ ] الفاحص يكتب JSON ذريًا ويخرج بغير صفر عند الفشل.
- [ ] يعمل بحساب بلا صلاحية مدير.
- [ ] اختُبرت الخدمة والمؤقت يدويًا.
- [ ] توجد قناة إنذار أو خطر غيابها موثق.
- [ ] جُرب فشل وتعافٍ من منظور داخلي، والخارجي مخطط أو عامل.

#section[ما تعلمناه]

أصبح الخادم معروفًا، والموقع قابلًا للرجوع، والاتصال مشفرًا،
والخدمة مراقبة. الآن نتحول من البناء إلى سؤال دفاعي: ما الأبواب
التي يراها الآخر، وما الذي ينبغي أن يبقى مغلقًا؟

#challenge[
  اكتب لوحة نصية تجمع آخر حالة ووقت آخر نجاح وعمر النسخة والمساحة،
  من دون كشف عنوان أو رمز. اجعلها ترفض تقريرًا أقدم من عشر دقائق
  حتى لو كانت كل قيمه القديمة خضراء.
]
