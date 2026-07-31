#import "/lib/book.typ": appendix, section, subsection
#import "/lib/components.typ": note, tip, warn

#appendix("ب", "خريطة الأدوات بين الأنظمة")

المشروعات المتقدمة اتخذت أوبونتو أساسًا للخادم ومختبر لينكس أساسًا
للشبكة. هذه الخريطة تساعد في نقل الفكرة، ولا تزعم تطابق الخيارات.
اقرأ صفحة الدليل في نظامك قبل أمر تغيير.

#section[هوية الجهاز]

- لينكس: `cat /etc/os-release` و`uname -a` و`df -h`.
- ماك: `sw_vers` و`uname -a` و`df -h`.
- ويندوز — باورشِل: `Get-ComputerInfo` و`Get-Volume`.
- بي إس دي: `uname -a` و`freebsd-version` في فري بي إس دي و`df -h`.

برنامج بطاقة الجهاز ببايثون يقلل الاختلاف للحقائق العامة، لكنه لا
يستبدل أدوات النظام لكل التفاصيل.

#section[البصمة]

- لينكس: `sha256sum FILE`.
- ماك: `shasum -a 256 FILE`.
- ويندوز: `Get-FileHash FILE -Algorithm SHA256`.
- فري بي إس دي: `sha256 FILE` أو الأداة الموجودة في إصدارك.

صيغة المخرج تختلف. لا تمرر ملف بصمة من أداة إلى خيار تحقق في أداة
أخرى وتتوقع التوافق بلا اختبار.

#section[البحث]

- الملفات والنص: `rg` عند توفره.
- معيار واسع: `grep` و`find` مع مراعاة اختلاف الخيارات.
- ويندوز: `Select-String` و`Get-ChildItem`.
- قاعدة محلية: Python `sqlite3` أو أداة `sqlite3` إن كانت مثبتة.

#section[الأرشفة والنسخ]

- لينكس/ماك/بي إس دي: `tar`, و`rsync` عند توفره.
- ويندوز: `Compress-Archive`, و`robocopy` للنسخ، أو أدوات نسخ
  مؤسسية مناسبة.

#warn[
  الأرشيف ليس نسخة كاملة تلقائيًا. اختبر الصلاحيات والروابط والملفات
  المفتوحة والتشفير والاستعادة وفق حاجتك ونظامك.
]

#section[الخدمات والجدولة]

- لينكس مع systemd: `systemctl`, و`journalctl`, ووحدات `.service`
  و`.timer`.
- ماك: `launchctl` وملفات `launchd`.
- ويندوز: Services و`Get-Service` وTask Scheduler.
- بي إس دي: `service`, و`sysrc`, و`cron` بحسب النظام.

لا تحول ملف systemd إلى مهمة ويندوز بترجمة الكلمات؛ انقل العقد:
المستخدم، الأمر، البيئة، إعادة المحاولة، السجل، والجدول.

#section[الشبكة والمنافذ]

- لينكس: `ip`, و`ss`, و`resolvectl`.
- ماك: `ifconfig`, و`netstat`, و`scutil --dns`, و`lsof`.
- ويندوز: `Get-NetIPConfiguration`, و`Get-NetTCPConnection`,
  و`Resolve-DnsName`.
- بي إس دي: `ifconfig`, و`netstat`, و`sockstat`, و`drill` بحسب النظام.

#section[الجدار]

- أوبونتو: `ufw` واجهة شائعة فوق netfilter.
- لينكس آخر: قد يستعمل `firewalld` أو`nftables` مباشرة.
- ماك: جدار التطبيقات و`pf` لأدوار مختلفة.
- ويندوز: Windows Defender Firewall وأوامر NetSecurity.
- بي إس دي: `pf` أو`ipfw` بحسب العائلة والإعداد.

#warn[
  لا تنقل قاعدة جدار حرفيًا بين الأنظمة. افهم اتجاه الحركة والعنوان
  والمنفذ والبروتوكول والحالة، واكتب قاعدة رجوع قبل التطبيق.
]

#section[الخادم والويب]

- اختبار HTTP: `curl` على الأنظمة المدعومة، و`curl.exe` عند الحاجة
  في ويندوز.
- DNS: `dig` أو`drill` أو`Resolve-DnsName`.
- TLS: `openssl s_client` عند توفر OpenSSL، أو مكتبات النظام.
- الويب: Nginx مثال الكتاب؛ Apache وCaddy وغيرهما خيارات لها
  نماذج إعداد وصيانة مختلفة.

#section[العمليات والسجلات]

- لينكس: `ps`, و`systemctl`, و`journalctl`, و`/proc`.
- ماك/بي إس دي: `ps`, و`lsof`, وسجلات النظام الأصلية.
- ويندوز: `Get-Process`, وEvent Viewer و`Get-WinEvent`.

#note[
  وجود اسم الأمر نفسه لا يضمن الخيارات نفسها؛ مثال `sed` و`date`
  و`stat` يختلف بين GNU وBSD. اختبر السكربت في الأنظمة التي تعلن
  دعمها، أو اكتب طبقة بايثون موحدة بحدود واضحة.
]
