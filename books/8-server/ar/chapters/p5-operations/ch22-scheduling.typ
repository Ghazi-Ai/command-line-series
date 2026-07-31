// الفصل الثاني والعشرون: الأعمال المجدولة وتقاريرها
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, try-it, define, challenge, objectives, session

#chapter[الأعمالُ المجدولة وتقاريرها]

#objectives((
  [تصمم المهمة قبل اختيار أداة الجدولة.],
  [تنشئ خدمة ومؤقت systemd مع سجل واضح.],
  [تمنع تداخل نسختين من المهمة.],
  [تفرق إعادة المحاولة من تكرار الأثر.],
))

المنبه يوقظك في الموعد، لكنه لا يضمن أنك أنجزت المهمة ولا أنك لم
تنجزها مرتين. الجدولة تجيب عن «متى يبدأ؟»، وتبقى عليك أسئلة
المدخل والأثر والفشل والسجل.

#section[عقد المهمة]

قبل المؤقت اكتب:

- الأمر والمستخدم.
- المدخل والمخرج.
- أقصى مدة.
- هل تشغيله مرتين آمن؟
- ماذا يحدث إذا فات الموعد؟
- أين يذهب المخرج والخطأ؟
- من يتلقى الفشل؟

ابدأ بأمر قراءة، مثل إنشاء تقرير مساحة، لا حذف الملفات.

#section[خدمة من نوع مرة واحدة]

أنشئ سكربتًا في المختبر يكتب تقريرًا:

```bash
sudoedit /usr/local/sbin/book-disk-report
```

```bash
#!/usr/bin/env bash
set -eu
date --iso-8601=seconds
df -hT /
df -i /
```

```bash
sudo chmod 755 /usr/local/sbin/book-disk-report
```

ووحدة:

```ini
[Unit]
Description=Book laboratory disk report

[Service]
Type=oneshot
DynamicUser=true
StateDirectory=book-report
ExecStart=/usr/bin/flock --nonblock \
  /var/lib/book-report/task.lock /usr/local/sbin/book-disk-report
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=true
```

احفظها في `/etc/systemd/system/book-disk-report.service`، ثم:

```bash
sudo systemd-analyze verify \
  /etc/systemd/system/book-disk-report.service
sudo systemctl daemon-reload
sudo systemctl start book-disk-report.service
journalctl -u book-disk-report.service -n 30 --no-pager
```

#section[المؤقت]

في `/etc/systemd/system/book-disk-report.timer`:

```ini
[Unit]
Description=Run the book disk report daily

[Timer]
OnCalendar=daily
Persistent=true
RandomizedDelaySec=10m

[Install]
WantedBy=timers.target
```

افحص الموعد:

```bash
systemd-analyze calendar daily
sudo systemctl enable --now book-disk-report.timer
systemctl list-timers book-disk-report.timer
```

`Persistent=true` يجعل المهمة الفائتة أثناء توقف الخادم تُشغل مرة
واحدة بعد عودته، مع مراعاة التأخير العشوائي. هذا مناسب لتقرير، وقد
يكون خطرًا لمهمة لا تريدها عند الإقلاع. القرار جزء من العقد.

#section[لا تتداخل]

إذا كانت الوحدة التي يستهدفها المؤقت نشطة عند حلول الموعد، فلا
يشغّل `systemd` نسخة ثانية منها. لكن المهمة قد تُستدعى من وحدة
أخرى أو من أداة خارجية؛ لذلك أضفنا قفل `flock` إلى عقد الخدمة:

```bash
flock --nonblock /var/lib/book-report/task.lock \
  /usr/local/sbin/book-disk-report
```

المجلد في المثال ينشئه `StateDirectory` ويمنح حساب الخدمة المؤقت
حق الكتابة فيه. حدد هل الخروج بسبب القفل نجاح متوقع أم فشل يستحق
تنبيهًا. قفل `flock` يرتبط بالعملية ويزول بانتهائها.

#warn[
  لا تضف `2>/dev/null` إلى مهمة مجدولة لإسكات البريد أو السجل؛ قد
  تخفي الدليل الوحيد على الفشل. وجّه المخرج إلى سجل محدود أو نظام
  تنبيه، ثم أصلح الضوضاء من مصدرها.
]

#section[إعادة المحاولة]

إعادة محاولة طلب قراءة آمنة تختلف عن إعادة تحويل مال أو حذف سجل.
اجعل المهمة قابلة للتكرار، أو احفظ معرّفًا يثبت أن الأثر لم ينفذ،
واستخدم تأخيرًا متزايدًا وحدًا للمحاولات.

#try-it[
  ابنِ خدمة التقرير ومؤقتها في المختبر، وشغل الخدمة يدويًا، ثم
  افحص السجل والموعد. غيّر السكربت مؤقتًا ليخرج بحالة `1` وتأكد
  أن الفشل ظاهر، ثم أعده.
]

#section[خلاصة الفصل]

المؤقت يحدد موعدًا، والخدمة تحدد تنفيذًا، وعقد المهمة يحدد أثرًا
وفشلًا. جعلنا السجل مرئيًا، ومنعنا التداخل، ورفضنا إعادة المحاولة
العمياء.

حين تفشل مهمة أو خدمة رغم ذلك، تبدأ ليلة العطل. الفصل التالي يعطيك
ترتيبًا يحمي المستخدم والدليل ويعيد الخدمة قبل أن تتحول العجلة
إلى فوضى.

#challenge[
  صمّم مهمة نسخ يومية: ماذا لو بدأت النسخة السابقة؟ ماذا لو انقطع
  النقل بعد 80%؟ ماذا لو امتلأت الوجهة؟ اكتب حالة الخروج والتنبيه
  وطريقة منع اعتبار الملف الناقص نسخة ناجحة.
]
