// الفصل الثامن عشر: التطبيق بوصفه خدمة
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, danger, try-it, define, challenge, objectives, session

#chapter[التطبيقُ بوصفه خدمة]

#objectives((
  [تنشئ مستخدم خدمة بلا صلاحية دخول يومية.],
  [تكتب وحدة سيستم دي (`systemd`) واضحة لتطبيق مختبر.],
  [تفصل الشيفرة والإعداد والبيانات والسجل.],
  [تختبر البدء والفشل والإقلاع والرجوع.],
))

برنامج يعمل داخل نافذتك يشبه بائعًا لا يفتح متجره إلا حين تقف
بجواره. الخدمة تحتاج عنوانًا ومفتاحًا وساعات عمل ومديرًا يعرف كيف
يعيدها إذا تعثرت.

#section[حساب لا يدخل]

في المختبر:

```bash
sudo adduser --system --group \
  --home /var/lib/book-app --no-create-home \
  --shell /usr/sbin/nologin book-app
sudo install -d -m 750 -o book-app -g book-app /var/lib/book-app
sudo install -d -m 755 -o root -g root \
  /srv/book-app/public
```

ضع صفحة:

```bash
printf '%s\n' '<h1>awake</h1>' \
  | sudo tee /srv/book-app/public/index.html >/dev/null
```

يبقى مجلد الإصدار والصفحة بملكية الجذر وقابلين للقراءة؛ يستطيع
حساب الخدمة تقديمهما، ولا يستطيع تعديل شيفرته بنفسه. خصصنا
`/var/lib/book-app` للبيانات التي تحتاج الخدمة كتابتها لاحقًا.

سنستخدم خادم بايثون المدمج للتعليم داخل المختبر فقط؛ ليس خادم
إنتاج.

#warn[
  `python -m http.server` مناسب لشرح دورة الخدمة، لا لتقديم تطبيق
  حقيقي للعامة. أبقه على العنوان المحلي خلف إنجن إكس واستبدله في
  الإنتاج بخادم التطبيق الذي توصي به تقنيتك.
]

#section[اكتب الوحدة]

```bash
sudoedit /etc/systemd/system/book-app.service
```

```ini
[Unit]
Description=Book 8 laboratory status service
After=network.target

[Service]
Type=simple
User=book-app
Group=book-app
WorkingDirectory=/srv/book-app
ExecStart=/usr/bin/python3 -m http.server 8000 \
  --bind 127.0.0.1 --directory /srv/book-app/public
Restart=on-failure
RestartSec=3
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=true
ReadWritePaths=/var/lib/book-app

[Install]
WantedBy=multi-user.target
```

علامة `\` في نهاية السطر طريقة استمرار يدعمها تركيب وحدات
`systemd`؛ يجب أن تكون آخر محرف مؤثر في السطر. ويمكنك كتابة
`ExecStart` كله في سطر واحد وحذف العلامة والمسافة البادئة.

#section[افحص وابدأ]

```bash
sudo systemd-analyze verify /etc/systemd/system/book-app.service
sudo systemctl daemon-reload
sudo systemctl start book-app
systemctl status book-app --no-pager
curl -I http://127.0.0.1:8000/
```

بعد نجاح الوظيفة:

```bash
sudo systemctl enable book-app
systemctl is-enabled book-app
```

ثم اضبط إنجن إكس ليمرر الاسم إلى `127.0.0.1:8000`.

#section[افصل ما يتغير]

نمط معقول:

```text
/srv/book-app/releases/   إصدارات التطبيق
/srv/book-app/current     رابط إلى الإصدار الحالي
/etc/book-app/            الإعداد
/var/lib/book-app/        البيانات الدائمة
/var/log/book-app/        سجل إن لم يستخدم journal
```

لا تجعل ترقية الشيفرة تمسح البيانات، ولا تضع السر داخل مجلد إصدار
يُنسخ إلى المستودع.

#subsection[إعادة التشغيل ليست نشرًا]

النشر سلسلة:

1. ضع إصدارًا جديدًا بجوار القديم.
2. افحص الملفات والإعداد.
3. نفّذ ترحيل بيانات مخططًا إن وجد.
4. حوّل `current`.
5. أعد تشغيل الخدمة.
6. اختبر محليًا ثم عبر إنجن إكس.
7. راقب السجل.
8. أعد الرابط إلى القديم عند الفشل إن كان متوافقًا.

#section[اختبر الفشل]

في المختبر، غيّر المنفذ مؤقتًا إلى منفذ مستخدم أو مسار غير موجود،
ثم:

```bash
sudo systemctl restart book-app
systemctl status book-app --no-pager
journalctl -u book-app -n 40 --no-pager
```

أعد الإعداد الصحيح واختبر العودة. لا تجرب فشلًا متعمدًا على خدمة
إنتاج.

#danger[
  `Restart=always` قد يصنع حلقة سريعة تخفي خطأ إعداد وتملأ السجل.
  ضع تأخيرًا، وراقب عدد المحاولات، وعالج السبب بدل جعل المدير
  يركض بلا نهاية.
]

#try-it[
  أنشئ خدمة المختبر، واختبرها محليًا، ثم فعّلها وأعد تشغيل خادم
  المختبر في نافذة صيانة. بعد العودة، أثبت المستخدم والمنفذ
  والحالة والصفحة والسجل.
]

#section[خلاصة الفصل]

نقلنا التطبيق من نافذة شخصية إلى خدمة ذات مستخدم ووحدة ومسار
وسجل وسياسة فشل. فصلنا الإصدار من الإعداد والبيانات، وجعلنا
الاختبار والرجوع جزءًا من النشر.

في الفصل التالي نحمي أثمن طبقة: البيانات التي لا تستطيع إعادة
تنزيلها من مستودع.

#challenge[
  صمّم نشر إصدارين `v1` و`v2` برابط `current`. اكتب خطوات التحويل
  والاختبار والرجوع، ثم حدد ما الذي يمنع الرجوع إذا غيّر `v2`
  بنية البيانات.
]
