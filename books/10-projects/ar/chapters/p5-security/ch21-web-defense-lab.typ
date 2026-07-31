// المشروع التاسع عشر: مختبر دفاع لتطبيق ويب ضعيف عمدًا
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, danger, ethics, try-it, define, challenge, objectives, session

#chapter[المشروع 19: مختبر اختراق أخلاقي وإصلاح]

#objectives((
  [تشغل تطبيقًا ضعيفًا عمدًا على الحلقة المرتدة.],
  [تثبت ثغرة عبور مسار على ملف مصطنع فقط.],
  [تصلح التحقق من المسار وتضيف اختبار منع.],
  [تتعلم أن الإصلاح يكتمل بإعادة الاختبار لا بتغيير الشيفرة.],
))

هذا أول مشروع نستغل فيه خللًا عمدًا، لكن الهدف برنامج كتبناه وبيانات
مصطنعة على `127.0.0.1`. الثغرة هي *عبور المسار*: التطبيق يظن أن
اسم الملف سيبقى داخل `data/`، بينما يستطيع الاسم `../` الصعود إلى
مجلد مجاور.

#define("إثبات المفهوم", [
  أصغر تجربة تثبت أن الخلل قابل للوقوع ضمن نطاق مأذون، من دون
  توسيع الأثر أو جمع بيانات لا يحتاجها الإثبات.
])

#section[حدود صارمة]

```text
الهدف: http://127.0.0.1:8099 فقط.
البيانات: welcome.txt وoutside-demo.txt المصطنعان.
المسموح: طلب قراءة بالاسم و../ لإثبات واحد.
الممنوع: ملفات الجهاز الأخرى، شبكة، صلاحية مدير، استمرار الخدمة.
```

أنشئ مجلدًا جديدًا، ولا تشغله من المنزل:

```text
19-web-defense/
├── vulnerable.py
├── outside-demo.txt
└── data/
    └── welcome.txt
```

اكتب في الملف الخارجي `LAB-OUTSIDE-DEMO` فقط.

#section[التطبيق الضعيف]

```python
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import parse_qs, urlparse

root = Path(__file__).resolve().parent
data_root = root / "data"

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        parsed = urlparse(self.path)
        if parsed.path != "/read":
            self.send_error(404)
            return
        name = parse_qs(parsed.query).get("file", [""])[0]
        path = data_root / name  # ضعيف عمدًا: لا يثبت بقاء المسار في data
        try:
            body = path.read_bytes()
        except OSError:
            self.send_error(404)
            return
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

ThreadingHTTPServer(("127.0.0.1", 8099), Handler).serve_forever()
```

شغله بلا `sudo`:

```bash
python3 vulnerable.py
```

#warn[
  هذه الشيفرة ضعيفة عمدًا. لا تغير الربط إلى `0.0.0.0`، ولا تضعها
  خلف بوابة أو على خادم. احذفها أو وسمها بوضوح بعد المختبر.
]

#section[أثبت السلوك السليم أولًا]

```bash
curl --fail --show-error --get \
  --data-urlencode 'file=welcome.txt' \
  http://127.0.0.1:8099/read
```

ثم إثبات المفهوم المحدود:

```bash
curl --fail --show-error --get \
  --data-urlencode 'file=../outside-demo.txt' \
  http://127.0.0.1:8099/read
```

إذا ظهر `LAB-OUTSIDE-DEMO`, ثبت أن التطبيق تجاوز جذر البيانات.
توقف. لا تطلب `/etc/passwd` ولا مفتاحًا ولا ملفًا آخر؛ لا تحتاجه
لإثبات الخلل.

#ethics[
  إثبات ثغرة في تطبيق لا تملكه يحتاج تفويضًا وحدودًا وإبلاغًا.
  ظهور الخلل لا يعطيك حق «رؤية ما يمكن الوصول إليه». قلل البيانات
  والأثر، وأوقف الاختبار عند تحقق الدليل.
]

#section[أصلح الحد]

استبدل بناء المسار:

```python
candidate = (data_root / name).resolve()
base = data_root.resolve()
if not candidate.is_relative_to(base) or not candidate.is_file():
    self.send_error(400, "invalid file")
    return
path = candidate
```

استخدمنا `resolve()` كي نعالج `..` والروابط الرمزية، ثم طلبنا أن
يبقى المرشح تحت الجذر. وقصرنا القراءة على ملف.

#note[
  هذا إصلاح تعليمي لمدخل المسار الذي اختبرناه، وليس تصميمًا كاملًا
  لخدمة ملفات متزامنة وغير موثوقة. قد يتغير رابط رمزي بين التحقق
  والقراءة؛ لذلك يظل قبول معرف من قائمة سماح، أو فتح الملف بآلية
  حصر يوفرها النظام، أقوى في تطبيق إنتاجي.
]

#section[أضف رؤوسًا محدودة]

قبل `end_headers()`:

```python
self.send_header("X-Content-Type-Options", "nosniff")
self.send_header("Cache-Control", "no-store")
```

الرؤوس لا تصلح عبور المسار؛ هي طبقات أخرى. لا تجمع إصلاحات غير
مفهومة وتعلن أن التطبيق «مؤمن».

#section[اختبار رجوع الثغرة]

اكتب اختبارًا يتوقع:

- `welcome.txt` يعيد 200 والمحتوى المتوقع.
- `../outside-demo.txt` يعيد 400 ولا يعيد العلامة.
- اسم غائب يعيد 400 أو404 بحسب العقد الموثق.
- رابط رمزي داخل `data` يشير إلى الخارج يُرفض.

شغل الإثبات القديم بعد الإصلاح. إذا لم يعد يقرأ الملف الخارجي فقد
أغلقت المسار الذي اختبرته. لا تقل «أغلقنا كل عبور مسار» بلا حالات
وترميزات واختبارات أوسع.

#danger[
  لا تجعل رسالة الخطأ تعيد المسار المطلق؛ قد تكشف بنية الخادم.
  سجل التفاصيل محليًا بصلاحية مناسبة، وأعد للعميل خطأ عامًا.
]

#section[حل أقوى من قبول اسم حر]

إن كانت الملفات معلومة، لا تقبل مسارًا أصلًا. استعمل معرفًا وخريطة:

```python
FILES = {"welcome": data_root / "welcome.txt"}
path = FILES.get(name)
```

قائمة السماح أصغر وأوضح من محاولة تنقية كل شكل لمسار حر.

#try-it[
  نفذ المختبر كاملًا داخل المجلد المخصص: أثبت العلامة المصطنعة، ثم
  أصلح واختبر الملف العادي و`..` ورابطًا رمزيًا. احفظ طلبات
  الإثبات ورموز HTTP فقط، لا مسارات حساسة.
]

#section[اختبارات القبول]

- [ ] الخدمة مرتبطة بـ`127.0.0.1` وتعمل بلا مدير.
- [ ] البيانات كلها مصطنعة.
- [ ] توقف الإثبات عند ملف العلامة المحدد.
- [ ] يعتمد الإصلاح على مسار محلول وحد أو قائمة سماح.
- [ ] يعاد تشغيل إثبات المفهوم بوصفه اختبار منع.
- [ ] لا يدعي التقرير خلو التطبيق من كل ثغرة.

#section[ما تعلمناه]

الاختراق الأخلاقي ليس كثرة ما تستطيع أخذه؛ هو أقل دليل يكشف الخلل
ثم إصلاح قابل للاختبار. المشروع التالي يفترض أن إنذارًا ظهر فعلًا:
منفذ غير متوقع وملف تغير. سندير غرفة حادث تحفظ الدليل وتحتوي الأثر
وتعيد الحالة.

#challenge[
  غيّر واجهة التطبيق لتقبل معرفًا من قائمة سماح بدل اسم ملف، واكتب
  اختبارًا عشوائيًا لمئة قيمة لا تظهر في القائمة. يجب ألا يقرأ أي
  ملف أو يكشف مسارًا.
]
