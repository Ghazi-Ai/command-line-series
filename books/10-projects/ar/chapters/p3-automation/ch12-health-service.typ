// المشروع العاشر: خدمة محلية بواجهة صحة
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, danger, try-it, define, challenge, objectives, session

#chapter[المشروع 10: خدمة محلية بواجهة صحة]

#objectives((
  [تشغل خدمة HTTP صغيرة على الحلقة المرتدة فقط.],
  [تفصل الحياة من الجاهزية.],
  [تختبر رمز الحالة والمحتوى من عميل.],
  [توقف الخدمة وتثبت فشل الاختبار ثم تعافيها.],
))

العملية التي تظهر في قائمة العمليات قد تكون عالقة، والمنفذ المفتوح
قد يعيد خطأ لكل طلب. نحتاج سؤالًا من خارج العملية. سنبني خدمة
تعليمية محلية ببروتوكول نقل النص الفائق (HTTP) لا تصلح للإنتاج،
لكنها تعلمنا عقد الصحة.

#define("اختبار الحياة", [
  سؤال يجيب: هل العملية قادرة على الاستجابة؟ لا يثبت أنها جاهزة
  لخدمة المستخدم أو أن اعتمادياتها سليمة.
])

#define("اختبار الجاهزية", [
  سؤال يجيب: هل تستطيع هذه النسخة استقبال عمل مفيد الآن؟ قد تكون
  العملية حية وغير جاهزة أثناء بدء التشغيل أو غياب اعتماد.
])

#section[الخدمة]

أنشئ `service.py`:

```python
from __future__ import annotations

import json
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

HOST = "127.0.0.1"
PORT = 8088
root = Path(__file__).resolve().parent

class Handler(BaseHTTPRequestHandler):
    def send_json(self, code, payload):
        body = (json.dumps(payload, ensure_ascii=False) + "\n").encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        if self.path == "/health":
            self.send_json(200, {"status": "alive"})
        elif self.path == "/ready":
            ready = (root / "state" / "ready.flag").is_file()
            self.send_json(200 if ready else 503,
                           {"status": "ready" if ready else "not-ready"})
        else:
            self.send_json(404, {"error": "not-found"})

    def log_message(self, fmt, *args):
        print("request", self.address_string(), fmt % args)

print(f"http://{HOST}:{PORT}")
ThreadingHTTPServer((HOST, PORT), Handler).serve_forever()
```

هذه تستخدم مكتبة بايثون التعليمية، وليست خادم إنتاج. ربطناها
بـ`127.0.0.1` كي لا تظهر على واجهات الشبكة.

#warn[
  توثيق بايثون نفسه لا يوصي بـ`http.server` للإنتاج؛ فهو يقدم
  فحوصًا أمنية أساسية فقط. نستعمله داخل المختبر لفهم العقد، لا
  لاستضافة تطبيق على الإنترنت.
]

#section[شغل من نافذتين]

في الأولى:

```bash
python3 service.py
```

وفي الثانية:

```bash
curl --fail --show-error http://127.0.0.1:8088/health
curl --include http://127.0.0.1:8088/ready
```

سيعيد `/health` نجاحًا، بينما يعيد `/ready` الحالة `503` حتى تنشئ:

```bash
mkdir -p state
touch state/ready.flag
curl --fail --show-error http://127.0.0.1:8088/ready
```

#session("curl --include http://127.0.0.1:8088/ready", output: "HTTP/1.0 503 Service Unavailable\n...\n{\"status\": \"not-ready\"}")

#section[اختبر العقد لا النص الجميل]

اكتب `check.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail
base=${1:-http://127.0.0.1:8088}
curl --fail --silent --show-error --max-time 3 "$base/health" >/dev/null
curl --fail --silent --show-error --max-time 3 "$base/ready" >/dev/null
printf 'service-ready\n'
```

المهلة تمنع الفاحص من الانتظار بلا نهاية. لا تجعلها قصيرة إلى حد
أن شبكة طبيعية تبدو فاشلة في الإنتاج؛ هنا الاتصال محلي.

#section[اكسر وأعد]

1. احذف `ready.flag`: تبقى الحياة ناجحة وتفشل الجاهزية.
2. أوقف العملية بـ`Ctrl+C`: يفشل الاختباران في الاتصال.
3. شغل الخدمة وأعد العلامة: ينجح `check.sh`.

أصبحت لديك ثلاثة أعراض مختلفة بدل كلمة «الخدمة متوقفة».

#section[لا تكشف في الصحة أكثر مما تحتاج]

لا تعيد:

- سلسلة اتصال قاعدة البيانات.
- متغيرات البيئة.
- أثرًا كاملًا لخطأ داخلي.
- إصدارات دقيقة بلا حاجة.
- أسماء مستخدمين أو مسارات أسرار.

تكفي حالة عامة، وتذهب التفاصيل إلى سجل محمي.

#danger[
  لا تجعل نقطة الصحة تنفذ إصلاحًا أو تعيد تحميل خدمة عند كل طلب.
  فحص الصحة قراءة. تحويله إلى زر تغيير غير موثق يوسع سطح الهجوم.
]

#section[من المختبر إلى خدمة حقيقية]

في خدمة إنتاج تستعمل إطارًا وخادم تطبيق مدعومين، وتضع الخدمة خلف
بوابة عكسية، وتفصل نقاط الصحة الداخلية من العامة بحسب الحاجة.
لكن العقد يبقى: رمز حالة صحيح، مهلة، محتوى محدود، واعتماديات معروفة.

#try-it[
  أضف اعتمادًا مصطنعًا: ملف `state/data.json` يجب أن يكون JSON
  صالحًا. اجعل الجاهزية تفشل إذا غاب أو فسد، مع رسالة عامة لا تطبع
  المحتوى. اختبر الحياة والجاهزية في الحالات الثلاث.
]

#section[اختبارات القبول]

- [ ] تستمع الخدمة على`127.0.0.1` فقط.
- [ ] الحياة والجاهزية عقدان منفصلان.
- [ ] تستخدم الجاهزية `503` عند غياب الاعتماد.
- [ ] للفاحص مهلة ورمز خروج غير صفري.
- [ ] لا تكشف الاستجابة سرًا أو أثر خطأ.
- [ ] جُرب التوقف وعدم الجاهزية والتعافي.

#section[ما تعلمناه]

بنينا أول خدمة يمكن لأداة أخرى أن تحكم عليها. لكن تسليم الخدمة لا
يعني تسليم مجلد عشوائي. المشروع التالي يبني مصنع إصدار يربط المصدر
بالاختبار والحزمة والبصمة.

#challenge[
  اكتب اختبار بايثون يشغل الخادم على منفذ يختاره النظام داخل
  عملية فرعية، ويختبر المسارين ثم يوقفه. لا تعتمد على المنفذ 8088
  في الاختبار الآلي.
]
