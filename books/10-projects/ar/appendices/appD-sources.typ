#import "/lib/book.typ": appendix, section
#import "/lib/components.typ": note, warn

#appendix("د", "المصادر والتوثيق الرسمي")

استندت الأوامر والمفاهيم الحساسة إلى التوثيق الرسمي الآتي. تاريخ
الاطلاع للمصادر الحية: 31 يوليو 2026. تتغير الأدوات؛ اقرأ الصفحة
الحالية وتوثيق إصدار نظامك قبل تطبيق تغيير على إنتاج.

#section[بايثون والمكتبة القياسية]

- توثيق Python: `pathlib` للمسارات:
  #link("https://docs.python.org/3/library/pathlib.html")
- `hashlib` للبصمات:
  #link("https://docs.python.org/3/library/hashlib.html")
- `sqlite3` لقاعدة SQLite المدمجة:
  #link("https://docs.python.org/3/library/sqlite3.html")
- `subprocess` لتشغيل العمليات وحدود `shell=True`:
  #link("https://docs.python.org/3/library/subprocess.html")
- `http.server` وتحذير عدم ملاءمته للإنتاج:
  #link("https://docs.python.org/3/library/http.server.html")
- البيئات الافتراضية `venv`:
  #link("https://docs.python.org/3/library/venv.html")

#section[Git والإصدار]

- مرجع Git:
  #link("https://git-scm.com/docs")
- `git archive` و`export-ignore`:
  #link("https://git-scm.com/docs/git-archive")
- `.gitattributes`:
  #link("https://git-scm.com/docs/gitattributes")

#section[الأسرار]

- GitHub: مفهوم فحص الأسرار في التاريخ والفروع:
  #link("https://docs.github.com/en/code-security/concepts/secret-security/secret-scanning")
- GitHub: إزالة بيانات حساسة وضرورة إلغاء السر أو تدويره أولًا:
  #link("https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository")

#section[أوبونتو والخادم]

- توثيق Ubuntu Server:
  #link("https://ubuntu.com/server/docs/")
- إدارة OpenSSH والتحقق من الإعداد قبل إعادة الخدمة:
  #link("https://ubuntu.com/server/docs/how-to/security/openssh-server/")
- جدار UFW ووضع `--dry-run`:
  #link("https://ubuntu.com/server/docs/security-firewall/")
- إدارة البرمجيات والتحديثات:
  #link("https://ubuntu.com/server/docs/tutorial/managing-software/")
- إعداد Nginx وكتل المواقع:
  #link("https://ubuntu.com/server/docs/how-to/web-services/configure-nginx/")

#section[الخدمات والجدولة]

- مشروع systemd والصفحات المرجعية:
  #link("https://systemd.io/")
- `systemd.service`:
  #link("https://www.freedesktop.org/software/systemd/man/latest/systemd.service.html")
- `systemd.timer`:
  #link("https://www.freedesktop.org/software/systemd/man/latest/systemd.timer.html")
- `systemd-analyze verify`:
  #link("https://www.freedesktop.org/software/systemd/man/latest/systemd-analyze.html")

#section[الشهادات وTLS]

- توثيق Certbot الرسمي:
  #link("https://eff-certbot.readthedocs.io/")
- إرشادات EFF/Certbot بحسب النظام وخادم الويب:
  #link("https://certbot.eff.org/")

#section[الشبكة والمسح المأذون]

- سجل IANA الرسمي للعناوين الخاصة؛ يبين أن `192.0.2.0/24`
  مخصص للتوثيق وغير قابل للوصول عالميًا:
  #link("https://www.iana.org/assignments/iana-ipv4-special-registry/iana-ipv4-special-registry.xhtml")
- RFC 5737 لعناوين IPv4 المستخدمة في الأمثلة والتنبيه إلى أنها ليست
  للاستخدام التشغيلي المحلي:
  #link("https://datatracker.ietf.org/doc/html/rfc5737")
- توثيق نواة الشبكة وأداة `ip` ضمن `iproute2`:
  #link("https://man7.org/linux/man-pages/man8/ip-netns.8.html")
- دليل Nmap الرسمي ومعاني حالات المنافذ وخيارات المسح:
  #link("https://nmap.org/book/man.html")

#section[أمن تطبيقات الويب]

- OWASP: عبور المسار وحدوده وأشكال الترميز:
  #link("https://owasp.org/www-community/attacks/Path_Traversal")
- OWASP: قائمة التحقق من المدخلات:
  #link("https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html")

#section[الاستجابة للحوادث]

- NIST SP 800-61 Rev. 3: دمج الاستجابة للحوادث في إدارة المخاطر:
  #link("https://csrc.nist.gov/pubs/sp/800/61/r3/final")
- NIST Cybersecurity Framework 2.0:
  #link("https://www.nist.gov/cyberframework")

#note[
  وجود رابط رسمي لا يجعل كل مثال صالحًا لإصدارك أو مزودك. دوّن
  الإصدار الفعلي، واقرأ صفحة الدليل المحلية، واختبر في مختبر.
]

#warn[
  لا تفسر فصول الأمن بوصفها تفويضًا عامًا. التوثيق يشرح قدرة
  الأداة؛ الإذن يأتي من ملكية الهدف أو موافقة صريحة محددة.
]
