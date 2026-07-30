#import "/lib/book.typ": appendix, section
#import "/lib/components.typ": note

#appendix("د", "المصادر والمراجع")

صيغ متن هذا الكتاب خصيصًا للسلسلة. واستُخدمت المراجع الرسمية
الآتية للتحقق من المفاهيم والأوامر، لا لنقل نصوصها. تاريخ الاطلاع
على المصادر الحية: 2026-07-30.

#section[أوبونتو وإدارة النظام]

- وثائق خادم أوبونتو الرسمية:
  `documentation.ubuntu.com/server/`
- اقتراحات الأمان وأقل صلاحية والتحديث والجدار:
  `documentation.ubuntu.com/server/explanation/security/security_suggestions/`
- إدارة مستخدمي أوبونتو وأدوات النظام، ضمن أدلة الخادم الرسمية.
- إدارة البرامج والحزم:
  `documentation.ubuntu.com/server/tutorial/managing-software/`
- التحديثات الآلية:
  `documentation.ubuntu.com/server/how-to/software/automatic-updates/`
- تحديثات الأمان:
  `documentation.ubuntu.com/security/security-updates/`
- ترقية إصدار أوبونتو:
  `documentation.ubuntu.com/server/how-to/software/upgrade-your-release/`
- النسخ والاستعادة:
  `documentation.ubuntu.com/server/how-to/backups/`

#section[الاتصال والجدار والشبكة]

- إعداد خادم OpenSSH في أوبونتو:
  `documentation.ubuntu.com/server/how-to/security/openssh-server/`
- صفحات دليل OpenSSH الأصلية، ولا سيما `ssh` و`sshd_config` و
  `ssh-keygen`:
  `man.openbsd.org/ssh`
- جدار أوبونتو UFW:
  `documentation.ubuntu.com/server/how-to/security/firewalls/`
- خدمة أسماء النطاقات وأداة `dig`:
  `documentation.ubuntu.com/server/how-to/networking/install-dns/`
- صفحات الدليل المحلية للأوامر `ss` و`ip` و`getent` بحسب إصدار
  أوبونتو المثبت.

#section[الخدمات والسجلات والجدولة]

- توثيق systemd الرسمي لوحدات الخدمة:
  `freedesktop.org/software/systemd/man/latest/systemd.service.html`
- المؤقتات:
  `freedesktop.org/software/systemd/man/latest/systemd.timer.html`
- أداة الإدارة `systemctl`:
  `freedesktop.org/software/systemd/man/latest/systemctl.html`
- سجل اليومية و`journalctl`:
  `freedesktop.org/software/systemd/man/latest/journalctl.html`
- صفحات الدليل المحلية لـ`systemd-analyze` و`timedatectl` و
  `loginctl`.

#section[خادم الويب والاتصال المشفر]

- دليل Nginx للمبتدئ، ويشمل تقديم الملفات والوكيل وإعادة تحميل
  الإعداد:
  `nginx.org/en/docs/beginners_guide.html`
- مرجع وحدة الوكيل في Nginx:
  `nginx.org/en/docs/http/ngx_http_proxy_module.html`
- توثيق Certbot:
  `eff-certbot.readthedocs.io/`
- توثيق Let's Encrypt وحدود الإصدار:
  `letsencrypt.org/docs/`
  و`letsencrypt.org/docs/rate-limits/`
- توثيق OpenSSL المحلي للأمرين `s_client` و`x509`.

#section[الحاويات]

- نظرة أمان Docker Engine وحدود مدير الخدمة:
  `docs.docker.com/engine/security/`
- توثيق التخزين الدائم:
  `docs.docker.com/engine/storage/volumes/`
- توثيق الشبكات ونشر المنافذ:
  `docs.docker.com/engine/network/`
- عند استعمال Podman أو أداة أخرى، يرجع إلى توثيق إصدارها الرسمي
  بدل نقل خيارات Docker تلقائيًا.

#section[مصادر النظام المحلية]

الأوامر والملفات التالية تُراجع بصفحات الدليل في الخادم الفعلي؛
لأن الخيارات والسلوك قد يختلفان بالإصدار:

```text
man ssh
man sshd_config
man ufw
man systemctl
man journalctl
man apt
man unattended-upgrade
man ss
man findmnt
man df
man du
man tar
man flock
```

#note[
  المسودة تستهدف أوبونتو طويل الدعم، لكنها لا تثبت رقم إصدار واحدًا
  لكل قارئ. قبل اعتماد الكتاب للنشر تُختبر الأوامر على مصفوفة
  إصدارات محددة، وتُراجع روابط المصادر وتوصيات تثبيت Certbot
  والحاويات مرة أخرى.
]
