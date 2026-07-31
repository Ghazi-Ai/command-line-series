#import "/lib/book.typ": appendix, section, subsection
#import "/lib/components.typ": note, tip, warn

#appendix("أ", "خريطة أوامر الشبكة")

هذا الملحق خريطة بدء، لا وعد بأن المخرجات متطابقة بين الأنظمة.
اقرأ صفحة الدليل في جهازك قبل استعمال خيار يغير الإعداد. الأوامر
المختارة هنا تقرأ الحالة في الأصل، ما لم يذكر خلاف ذلك صراحة.

#section[بطاقة الشبكة في دقيقة]

#subsection[الواجهات والعناوين]

- لينكس: `ip -brief address`
- ماك أو بي إس دي: `ifconfig`
- ويندوز — باورشِل: `Get-NetIPConfiguration`

#subsection[الطريق الافتراضي]

- لينكس: `ip route`
- ماك أو بي إس دي: `netstat -rn`
- ويندوز — باورشِل: `Get-NetRoute -DestinationPrefix "0.0.0.0/0"`
  للإصدار الرابع، و`Get-NetRoute -DestinationPrefix "::/0"`
  للإصدار السادس

#subsection[الجيران]

- لينكس: `ip neighbor`
- ماك أو بي إس دي: `arp -an` و`ndp -an`
- ويندوز — باورشِل: `Get-NetNeighbor`

#subsection[المنافذ المستمعة]

- لينكس: `ss -lntup`
- ماك: `lsof -nP -iTCP -sTCP:LISTEN`
- فري بي إس دي: `sockstat -l`
- ويندوز — باورشِل: `Get-NetTCPConnection -State Listen`

#subsection[إعداد محلل الأسماء]

- لينكس: `resolvectl status`
- ماك: `scutil --dns`
- ويندوز — باورشِل: `Get-DnsClientServerAddress`

#subsection[اختبار الاسم]

- لينكس أو ماك: `dig example.com`
- بي إس دي: `drill example.com` أو `dig example.com` إن كانت مثبتة
- ويندوز — باورشِل: `Resolve-DnsName example.com`

#subsection[اختبار وجهة أو طريق]

- لينكس: `ping -c 3 192.0.2.1` و`tracepath example.com`
- ماك أو بي إس دي:
  `ping -c 3 192.0.2.1` و`traceroute example.com`
- ويندوز — باورشِل:
  `Test-Connection 192.0.2.1 -Count 3` و`tracert example.com`

#subsection[اختبار منفذ وبروتوكول]

- لينكس أو ماك أو بي إس دي: `nc -vz example.com 443`
- ويندوز — باورشِل: `Test-NetConnection example.com -Port 443`
- طلب HTTP على الأنظمة المدعومة:
  `curl -I https://example.com`، أو `curl.exe` في ويندوز

#note[
  قد لا تكون `dig` أو `tracepath` أو `nc` مثبتة افتراضيًا. لا تثبت
  أداة أثناء حادث قبل أن تعرف سياسة الجهاز ومصدر الحزمة. قد توفر
  الأدوات الموجودة أصلًا الدليل نفسه. اختبر منفذ خدمة تملكها أو
  خدمة عامة معدة للاستعمال، ولا تحول المثال إلى مسح عناوين أو نطاق
  منافذ.
]

#section[لينكس]

```bash
ip -brief link
ip -brief address
ip route
ip -6 route
ip neighbor
ss -lntup
resolvectl status
```

يعرض `ip` الواجهات والعناوين والطرق والجيران. ويعرض `ss` المقابس
والعمليات المرتبطة بها عندما تسمح الصلاحية. لا تعني علامة
`LISTEN` أن الخدمة متاحة من الإنترنت؛ فهي تثبت وجود مستمع على
عنوان محلي محدد فقط.

لاختبار الطريق الذي سيختاره لينكس دون إرسال حركة إلى الوجهة، نستعمل
عنوانين محجوزين للتوثيق:

```bash
ip route get 192.0.2.1
ip -6 route get 2001:db8::1
```

ولفصل الاسم عن العنوان:

```bash
getent ahosts example.com
dig example.com A
dig example.com AAAA
```

#section[ماك]

```bash
ifconfig
netstat -rn
route -n get default
scutil --dns
arp -an
ndp -an
lsof -nP -iTCP -sTCP:LISTEN
```

يعرض `scutil --dns` أكثر من محلل لأن ماك قد يختار محللًا مختلفًا
بحسب النطاق أو الشبكة الخاصة. لذلك لا يكفي دائمًا النظر إلى خادم
واحد ثم افتراض أنه يعالج كل الأسماء.

```bash
dig example.com
traceroute example.com
curl -I https://example.com
```

#section[ويندوز]

نفّذ أوامر القراءة الآتية في باورشِل:

```powershell
Get-NetIPConfiguration
Get-NetRoute
Get-NetNeighbor
Get-NetTCPConnection -State Listen
Get-DnsClientServerAddress
Resolve-DnsName example.com
Test-NetConnection example.com -Port 443
```

يقدم `Test-NetConnection` اختبارًا مناسبًا للمنفذ والطريق، لكن
نجاح الاتصال لا يثبت صحة التطبيق الذي يعمل خلفه. بعده اختبر
البروتوكول نفسه، مثل HTTP:

```powershell
curl.exe -I https://example.com
```

#section[فري بي إس دي وأنظمة بي إس دي]

```sh
ifconfig
netstat -rn
route -n get default
arp -an
ndp -an
sockstat -l
drill example.com
traceroute example.com
```

قد تستعمل توزيعات بي إس دي أدوات أو خيارات مختلفة. في فري بي إس
دي يعرض `sockstat` المقابس بوضوح، بينما قد يكون `lsof` إضافة
اختيارية. ارجع إلى `man` في النظام الفعلي.

#section[أوامر تغيّر الحالة]

الأوامر التالية أمثلة على فئات تحتاج خطة رجوع وصلاحية، وليست
خطوات تشخيص عادية:

```text
ip link set ...
ip address add|delete ...
ip route add|delete ...
networksetup ...
netsh ...
New-NetIPAddress
Set-DnsClientServerAddress
```

#warn[
  لا تنسخ أمر تغيير بين لينكس وماك وبي إس دي وويندوز على أساس أن
  الأسماء متقاربة. اكتب الحالة قبل التغيير، والتغيير الواحد،
  والنتيجة المتوقعة، وأمر الرجوع، ثم اختبر من جلسة لا يقطعها
  التغيير إن كان الجهاز بعيدًا.
]

#section[ترتيب سريع لا يضللك]

```text
واجهة وعنوان
→ جار وبوابة
→ طريق
→ حل اسم
→ وصول إلى منفذ
→ بروتوكول التطبيق
→ دليل من الطرف الآخر
```

#tip[
  لا تجعل `ping` حكمًا نهائيًا. قد تمنع الشبكة رسائل الصدى وتسمح
  بالخدمة، وقد ينجح الصدى بينما يتعطل حل الاسم أو المنفذ أو
  التطبيق. هو اختبار واحد ضمن سلّم، لا سلّم التشخيص كله.
]
