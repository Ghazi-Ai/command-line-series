// المشروع الرابع عشر: نشر موقع بإصدار ورجوع
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, danger, try-it, define, challenge, objectives, session

#chapter[المشروع 14: نشر موقع بإصدار ورجوع]

#objectives((
  [تنشر موقعًا ثابتًا في مجلد إصدار لا فوق الحي مباشرة.],
  [تفحص إعداد Nginx قبل إعادة التحميل.],
  [تبدل رابط current وتنفذ رجوعًا سريعًا.],
  [تختبر الموقع محليًا ومن عميل خارجي.],
))

سننشر صفحة ثابتة على خادم أوبونتو باستخدام إنجن إكس (Nginx).
القيمة ليست في الصفحة؛ بل في طريقة النشر: إصدار جديد بجانب القديم،
فحص، ثم تحويل رابط واحد. إذا فشل، نعيد الرابط.

#define("النشر الذري عمليًا", [
  تجهيز إصدار كامل خارج المسار الحي، ثم تحويل مؤشر مثل رابط رمزي
  في خطوة قصيرة. يقلل رؤية حالة نصف مكتملة، لكنه لا يجعل كل طبقات
  النظام معاملة واحدة.
])

#section[المتطلبات والحدود]

- خادم مختبر أو VPS تملكه.
- Nginx من مستودع النظام.
- حساب نشر غير المدير كلما أمكن.
- المنفذ 80 مسموح إن كنت تختبر من الخارج.
- صفحة لا تحوي سرًا.

ثبت Nginx بعد مراجعة الحزمة:

```bash
sudo apt update
sudo apt install nginx
systemctl status nginx --no-pager
```

#section[شجرة الإصدارات]

```bash
sudo mkdir -p /srv/terminal-site/releases
sudo chown -R "$USER":"$USER" /srv/terminal-site
mkdir -p /srv/terminal-site/releases/001
```

تفترض الأوامر أن `/srv/terminal-site` مسار جديد مخصص لهذا المشروع.
إذا كان موجودًا، اعرض ملكيته ومحتواه أولًا؛ لا تغير الملكية تكراريًا
لمسار قد تستعمله خدمة أخرى. وفي الإنتاج اجعل حساب النشر يكتب مجلد
الإصدارات فقط بدل منحه كل الشجرة بلا حاجة.

في `001/index.html` ضع صفحة عربية بسيطة مع وسم الإصدار. لا تجعل
خدمة الويب تملك صلاحية كتابة ملفات الموقع إذا كانت تحتاج القراءة
فقط.

#section[إعداد الموقع]

أنشئ `/etc/nginx/sites-available/terminal-site` بعد حفظ خطة الرجوع:

```nginx
server {
    listen 80;
    listen [::]:80;
    server_name _;

    root /srv/terminal-site/current;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

فعّله برابط في `sites-enabled`, وعطّل الموقع الافتراضي فقط إذا
فهمت أنه لا يخدم شيئًا آخر. ثم:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

الفحص يأتي قبل إعادة التحميل دائمًا.

#danger[
  لا تستبدل مجلد `/etc/nginx` كاملًا من مثال. قد يستضيف الخادم
  مواقع وخدمات أخرى. عدل ملف موقع محدد، وافحص الفروق والصيغة.
]

#section[أول تفعيل]

قبل إعادة التحميل اجعل `current` يشير إلى إصدار معلوم:

```bash
ln -sfn /srv/terminal-site/releases/001 /srv/terminal-site/current
readlink -f /srv/terminal-site/current
curl --fail --show-error http://127.0.0.1/
```

قد يختار Nginx موقعًا افتراضيًا آخر إذا كانت إعدادات الاستماع
متعارضة. افحص `nginx -T` بحذر؛ المخرج قد يحوي مسارات وإعدادات، فلا
تنشره بلا تنقيح.

#section[نشر الإصدار الثاني]

محليًا ابنِ الموقع في مجلد `dist/`, ثم انقله إلى مسار جديد. مثال
باستعمال `rsync` عبر SSH:

```bash
rsync -av --delete --dry-run dist/ user@server:/srv/terminal-site/releases/002/
rsync -av --delete dist/ user@server:/srv/terminal-site/releases/002/
```

استعمل `--delete` فقط داخل مجلد إصدار جديد صريح؛ فهو يحذف الزائد
من الهدف. بعد النقل على الخادم افحص الملفات، ثم شغّل خادم معاينة
محليًا على الحلقة المرتدة كي تختبر المرشح نفسه لا الإصدار الذي
يشير إليه `current`:

```bash
find /srv/terminal-site/releases/002 -maxdepth 2 -type f -print
test -r /srv/terminal-site/releases/002/index.html
if (
  set -euo pipefail
  preview_log=$(mktemp)
  python3 -m http.server 8089 --bind 127.0.0.1 \
    --directory /srv/terminal-site/releases/002 \
    >"$preview_log" 2>&1 &
  preview_pid=$!
  trap 'kill "$preview_pid" 2>/dev/null || true; rm -f "$preview_log"' EXIT
  curl --fail --show-error --retry 5 --retry-connrefused --retry-delay 1 \
    http://127.0.0.1:8089/
); then
  ln -sfn /srv/terminal-site/releases/002 /srv/terminal-site/current
  curl --fail --show-error http://127.0.0.1/
else
  printf 'فشل اختبار المرشح؛ لم يتغير current\n' >&2
fi
```

خادم بايثون هنا أداة معاينة محلية للموقع الثابت، لا خادم إنتاج.
إذا فشل الطلب فأوقف عملية المعاينة قبل التشخيص، ولا تحوّل الرابط
حتى ينجح اختبار المرشح. وبعد التحويل اختبر إنجن إكس نفسه، ثم أضف
اختبار الاسم من عميل خارجي حين تضيف النطاق.

#section[الرجوع]

إذا فشل القبول:

```bash
ln -sfn /srv/terminal-site/releases/001 /srv/terminal-site/current
curl --fail --show-error http://127.0.0.1/
```

لا تحذف الإصدار الفاشل فورًا؛ احتفظ به قصيرًا للتحليل، ثم طبّق
سياسة احتفاظ معلومة.

#section[اختبر من الخارج]

نجاح `127.0.0.1` يثبت Nginx محليًا، لا DNS ولا جدار المزود ولا
طريق الإنترنت. من جهاز آخر تملكه:

```bash
curl --include http://SERVER_IP/
```

لا تضع العنوان الحقيقي في مستودع عام. سجل رمز HTTP ووسم الإصدار.

#note[
  الموقع عبر HTTP غير مشفر. يكفي للاختبار الأول بلا بيانات حساسة،
  لكنه ليس نهاية نشر عام. المشروع التالي يضيف الاسم والشهادة
  والاتصال المشفر.
]

#try-it[
  أنشئ إصدارًا ثالثًا فيه خطأ مقصود: احذف `index.html`. ينبغي أن
  يفشل اختبار المرشح قبل تحويل `current`. أثبت أن الموقع الحي بقي
  على الإصدار الثاني.
]

#section[اختبارات القبول]

- [ ] كل إصدار في مجلد مستقل.
- [ ] إعداد Nginx في ملف موقع محدد ونجح `nginx -t`.
- [ ] يُختبر المرشح قبل تحويل `current`.
- [ ] الرابط يشير إلى إصدار معلوم ويمكن إرجاعه.
- [ ] ينجح الاختبار محليًا وخارجيًا أو يُوثق سبب تعذر الخارجي.
- [ ] لا تحوي الصفحة أو أوامر النقل أسرارًا.

#section[ما تعلمناه]

أصبح النشر انتقالًا بين حالتين معلومتين، لا كتابة فوق الحي. في
المشروع التالي نعطي الخدمة اسمًا، ونثبت هوية الخادم بشهادة، ونضع
بوابة عكسية أمام خدمة محلية من دون كشف منفذها للعالم.

#challenge[
  اكتب `deploy.sh` يقبل رقم إصدار من نمط رقمي فقط، يرفض مجلدًا
  موجودًا، ينقل، يختبر، ثم يبدل الرابط. لا تجعله يحذف الإصدارات
  القديمة أو ينشر خارج `/srv/terminal-site/releases`.
]
