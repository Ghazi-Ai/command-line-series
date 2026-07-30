// الفصل السابع: الخدمات التي تبدأ وحدها
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, try-it, define, challenge, objectives, session

#chapter[الخدماتُ التي تبدأ وحدها]

#objectives((
  [تفهم الخدمة والوحدة ومدير النظام.],
  [تميز البدء الآن من التمكين عند الإقلاع.],
  [تقرأ حالة وحدة وملفها الفعلي قبل تعديلها.],
  [تختبر الإعداد ثم تعيد التحميل دون إعادة تشغيل عشوائية.],
))

في فندق لا يوقظ المدير كل عامل بيده كل صباح. توجد مناوبات وقوائم
واعتمادات: لا يبدأ الإفطار قبل المطبخ، ولا تفتح المغسلة إن تعطلت
المياه. مدير الخدمات ينظم برامج الخادم بالطريقة نفسها.

#define("الخدمة", [
  برنامج أو مجموعة عمليات تعمل في الخلفية لتقديم وظيفة مستمرة،
  مثل الاتصال الآمن أو خادم الويب أو قاعدة البيانات.
])

#define("وحدة سيستم دي (systemd)", [
  وصف يديره نظام `systemd` لشيء مثل خدمة أو مؤقت أو نقطة وصل.
  يحدد كيفية البدء والتوقف والاعتمادات وسياسة الفشل.
])

#section[الحالة أول سؤال]

```bash
systemctl status ssh --no-pager
systemctl is-active ssh
systemctl is-enabled ssh
```

- `active` تعني أن الخدمة نشطة الآن.
- `enabled` تعني أن لها روابط تجعلها تبدأ وفق هدف عند الإقلاع.

قد تكون خدمة نشطة لكنها غير ممكّنة لأن شخصًا بدأها يدويًا، أو
ممكّنة لكنها فاشلة الآن. لا تستبدل السؤالين بواحد.

#session("systemctl is-active ssh; systemctl is-enabled ssh", output: "active\nenabled")

#section[أربعة أفعال مختلفة]

```bash
sudo systemctl start example.service
sudo systemctl stop example.service
sudo systemctl restart example.service
sudo systemctl reload example.service
```

إعادة التحميل تطلب من الخدمة قراءة إعداد جديد إن كانت تدعم ذلك،
وغالبًا تقلل الانقطاع. إعادة التشغيل توقف ثم تبدأ؛ وقد تقطع
اتصالات. لا تستخدم `restart` بوصفه زر «جرّب».

للتمكين عند الإقلاع:

```bash
sudo systemctl enable example.service
```

وللتمكين والبدء في خطوة واحدة:

```bash
sudo systemctl enable --now example.service
```

افصل الخطوتين أول مرة كي تعرف أيهما فشل.

#section[اقرأ ما يديره النظام]

```bash
systemctl cat ssh.service
systemctl show ssh.service \
  -p FragmentPath -p DropInPaths -p User -p ExecStart
```

قد يأتي ملف الوحدة من الحزمة، وتضاف إليه ملفات إسقاط في
`/etc/systemd/system/...d/`. لا تعدل ملفًا تحت `/usr/lib` أو
`/lib` مباشرة؛ قد يستبدله تحديث.

لإنشاء تعديل محلي:

```bash
sudo systemctl edit example.service
```

ثم بعد الحفظ:

```bash
sudo systemctl daemon-reload
sudo systemctl restart example.service
```

`daemon-reload` يجعل المدير يعيد قراءة تعريفات الوحدات؛ لا يعيد
تشغيل الخدمة وحده.

#warn[
  قبل إعادة تشغيل خدمة اتصال أو قاعدة بيانات، اعرف أثر الانقطاع
  وطريق التحقق والرجوع. نجاح `systemctl restart` يعني أن طلب
  المدير نجح، لا أن التطبيق يقدم نتيجة صحيحة للمستخدم.
]

#section[لماذا فشلت؟]

```bash
systemctl status example.service --no-pager
journalctl -u example.service -n 80 --no-pager
systemctl show example.service -p Result -p ExecMainStatus
```

اقرأ أول خطأ زمني ذي معنى، لا آخر سطر فقط؛ السطر الأخير قد يكون
«فشلت الخدمة» بينما السبب قبله: ملف إعداد غير صالح أو منفذ مستخدم.

#subsection[اعتماد وانتظار]

يمكن للوحدة أن ترتب نفسها بعد الشبكة أو قبل خدمة أخرى، لكن
«الشبكة متاحة» لا يعني أن قاعدة بيانات بعيدة جاهزة. الاعتمادات
تصف علاقة تشغيل، وليست اختبار صحة كاملًا.

#section[اختبر الإقلاع]

الخدمة التي تعمل الآن قد تفشل بعد إعادة التشغيل بسبب مسار موقت أو
متغير بيئة أو ترتيب اعتماد. لا تعلنها مكتملة حتى تنفذ إعادة تشغيل
مخططة في المختبر وتتحقق:

```bash
systemctl is-active example.service
systemctl is-enabled example.service
journalctl -u example.service -b --no-pager
```

الخيار `-b` يقيد السجل بالإقلاع الحالي.

#try-it[
  اختر خدمة موجودة مثل `ssh`. اعرض حالتها وتمكينها ومصدر ملف
  وحدتها والأمر الذي يبدأها. لا تعدلها. أضف النتيجة إلى دفتر
  الخادم تحت «خدمات أساسية».
]

#section[خلاصة الفصل]

الخدمة وظيفة مستمرة، والوحدة عقد تشغيل، و`systemd` يدير الحالة
والاعتماد والإقلاع. فصلنا النشاط الحالي من التمكين المستقبلي،
وقرأنا الوحدة وملفات إسقاطها، ورفضنا إعادة التشغيل بوصفها تشخيصًا.

لكن حالة الخدمة تعرض جزءًا صغيرًا من القصة. في الفصل التالي ندخل
ذاكرة الخادم: السجلات، والوقت، والطريقة التي تحول رسالة مبعثرة إلى
خط زمني.

#challenge[
  اكتب خطة تغيير إعداد خدمة: نسخة من الإعداد، وفحص قبل التطبيق،
  وإعادة تحميل أو تشغيل، واختبار وظيفة، وقراءة سجل، ورجوع. اجعل
  لكل خطوة أمرًا أو دليلًا.
]
