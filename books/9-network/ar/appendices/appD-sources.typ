#import "/lib/book.typ": appendix, section
#import "/lib/components.typ": note

#appendix("د", "المصادر والمراجع")

صيغ متن هذا الكتاب خصيصًا للسلسلة. واستُعملت المراجع الرسمية
الآتية للتحقق من المفاهيم والأوامر، لا لنقل نصوصها. تاريخ الاطلاع
على المصادر الحية: 2026-07-31. تبقى صفحات الدليل المثبتة على جهاز
القارئ المرجع الأدق لخيارات إصدار أدواته.

#section[بروتوكول الإنترنت والنقل]

- مواصفة بروتوكول التحكم بالنقل الحالية، RFC 9293:
  `rfc-editor.org/rfc/rfc9293`
- مواصفة الإصدار السادس من بروتوكول الإنترنت، RFC 8200:
  `rfc-editor.org/rfc/rfc8200`
- العناوين الخاصة في الإصدار الرابع، RFC 1918:
  `rfc-editor.org/rfc/rfc1918`
- عناوين IPv4 المحجوزة للتوثيق، RFC 5737، وسابقة توثيق IPv6،
  RFC 3849:
  `rfc-editor.org/rfc/rfc5737` و`rfc-editor.org/rfc/rfc3849`
- نطاق العناوين المشتركة لدى مزودي الخدمة، RFC 6598:
  `rfc-editor.org/rfc/rfc6598`
- اكتشاف الجيران في IPv6، RFC 4861:
  `rfc-editor.org/rfc/rfc4861`
- العنونة المحلية التلقائية للرابط في IPv4، RFC 3927:
  `rfc-editor.org/rfc/rfc3927`
- بروتوكول الإعداد الآلي للمضيف DHCP، RFC 2131:
  `rfc-editor.org/rfc/rfc2131`
- مواصفة بروتوكول كويك (`QUIC`)، RFC 9000:
  `rfc-editor.org/rfc/rfc9000`
- استعمال TLS لتأمين كويك، RFC 9001:
  `rfc-editor.org/rfc/rfc9001`

#section[الأسماء والويب والتشفير]

- مفاهيم نظام أسماء النطاقات ومرافقه، RFC 1034:
  `rfc-editor.org/rfc/rfc1034`
- أسماء النطاقات المحجوزة للاختبار، ومنها `.invalid`، RFC 2606:
  `rfc-editor.org/rfc/rfc2606`
- دلالات HTTP، RFC 9110:
  `rfc-editor.org/rfc/rfc9110`
- أمن طبقة النقل 1.3، RFC 9846 الصادرة في يوليو 2026 والتي
  حلّت محل RFC 8446:
  `rfc-editor.org/rfc/rfc9846`
- دليل curl الرسمي وأمثلة خيارات الطلب والتوقيت:
  `curl.se/docs/manpage.html`
- دليل `openssl s_client` الرسمي، ولا سيما التحقق من الاسم وإرجاع
  أخطاء التحقق:
  `docs.openssl.org/master/man1/openssl-s_client/`
- سجل أسماء الخدمات وأرقام المنافذ لدى IANA:
  `iana.org/assignments/service-names-port-numbers/`
- توثيق خادم HTTP البسيط في بايثون وتحذيراته الأمنية:
  `docs.python.org/3/library/http.server.html`

#section[لينكس]

- صفحات دليل مجموعة `iproute2`، ومنها `ip-route`:
  `man7.org/linux/man-pages/man8/ip-route.8.html`
- صفحة دليل `ss`:
  `man7.org/linux/man-pages/man8/ss.8.html`
- توثيق `systemd-resolved` و`resolvectl`:
  `freedesktop.org/software/systemd/man/latest/systemd-resolved.service.html`
  و`freedesktop.org/software/systemd/man/latest/resolvectl.html`
- توثيق مساحات أسماء الشبكة في لينكس:
  `man7.org/linux/man-pages/man8/ip-netns.8.html`
- صفحة دليل `tcpdump` الأصلية:
  `tcpdump.org/manpages/tcpdump.1.html`

#section[ويندوز]

- توثيق Microsoft للأمر `Get-NetIPConfiguration`:
  `learn.microsoft.com/powershell/module/nettcpip/get-netipconfiguration`
- أوامر NetTCPIP، ومنها `Get-NetRoute` و`Get-NetNeighbor` و
  `Get-NetTCPConnection`:
  `learn.microsoft.com/powershell/module/nettcpip/`
- توثيق `Resolve-DnsName`:
  `learn.microsoft.com/powershell/module/dnsclient/resolve-dnsname`
- توثيق `Test-NetConnection`:
  `learn.microsoft.com/powershell/module/nettcpip/test-netconnection`

#section[ماك وبي إس دي]

- دليل Terminal الرسمي من Apple:
  `support.apple.com/guide/terminal/welcome/mac`
- دليل فري بي إس دي، فصل الشبكات:
  `docs.freebsd.org/en/books/handbook/network/`
- صفحات الدليل المحلية في ماك أو نظام بي إس دي للأوامر:

```text
man ifconfig
man netstat
man route
man arp
man ndp
man scutil
man traceroute
man sockstat
```

#section[حدود الاستعمال]

تختلف الأسماء الافتراضية للواجهات، ومديرو الشبكة، وسياسة محلل
الأسماء، وصلاحيات عرض العمليات والتقاط الحزم بين الأنظمة
والإصدارات. لذلك لا يحول هذا الملحق مثالًا واحدًا إلى وصف لكل
جهاز.

#note[
  أوامر الالتقاط والمختبرات وردت ضمن حدود أخلاقية وتشغيلية واضحة:
  جهاز أو شبكة تملكها أو تملك إذنًا بإدارتها، ومرشح ضيق ومدة
  محدودة. لا تمنح الأداة إذنًا، ولا يجعل توفر الأمر مراقبة حركة
  الآخرين مشروعة.
]
