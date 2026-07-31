// الفصل الرابع والعشرون: ابنِ شبكة صغيرة معزولة
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, danger, try-it, define, challenge, objectives, session

#chapter[ابنِ شبكة صغيرة معزولة]

#objectives((
  [تنشئ على لينكس وصلة افتراضية معزولة من طرفين.],
  [تضبط عنوانين وتثبت الجوار والوصول.],
  [ترى أن الشبكة الصغيرة تحتاج واجهة وعنوانًا وطريقًا.],
  [تحذف المختبر وتثبت زواله.],
))

حتى الآن قرأنا شبكة موجودة. الآن نبني حارة من بيتين داخل لينكس:
واجهة في النظام الرئيس، وطرفها الآخر داخل حيز شبكة مستقل. لا
نضيف طريق إنترنت ولا NAT ولا جدارًا؛ الهدف رؤية الأساس فقط.

#define("حيز الشبكة (Network Namespace)", [
  عزل في لينكس يمنح مجموعة عمليات واجهات وعناوين وجداول توجيه
  خاصة بها. لا يساوي آلة افتراضية كاملة، لكنه مختبر مفيد لبنية
  الشبكة.
])

#note[
  هذا عزل لمكدس الشبكة، لا حاجز أمان كاملًا. يظل النظام الرئيس
  متصلًا بالطرف الآخر من الوصلة، وتظل صلاحية المدير قادرة على إدارة
  الحيز. لا تشغّل فيه برنامجًا غير موثوق على أنه صندوق احتواء.
]

#section[قبل الإنشاء]

يتطلب المختبر لينكس وأداة `ip` وصلاحية إدارية. تأكد أن الأسماء لا
توجد:

```bash
ip link show lab-host
ip netns list
ip route show 10.203.0.0/30
```

إذا وجدت `lab-host` أو `netlab`، أو ظهر طريق سابق للنطاق، فلا
تكمل؛ قد تخص مختبرًا آخر. اختر أسماء أو نطاقًا توثيقيًا آخر لا
يتعارض مع جهازك، وافهم ما هو موجود قبل الإنشاء.

#section[أنشئ الحيز والوصلة]

```bash
sudo ip netns add netlab
sudo ip link add lab-host type veth peer name lab-peer
sudo ip link set lab-peer netns netlab
```

وصلة `veth` مثل سلك افتراضي: ما يدخل طرفًا يخرج من الآخر. نقلنا
`lab-peer` إلى الحيز.

#section[أعط الطرفين عنوانين]

نستعمل سابقة صغيرة من نطاق IPv4 الخاص بعد التحقق من عدم تعارضها:

```bash
sudo ip address add 10.203.0.1/30 dev lab-host
sudo ip link set lab-host up
sudo ip netns exec netlab ip link set lo up
sudo ip netns exec netlab ip address add 10.203.0.2/30 dev lab-peer
sudo ip netns exec netlab ip link set lab-peer up
```

السابقة `/30` تجعل العنوانين في شبكة صغيرة واحدة.

#section[اقرأ من الجانبين]

في النظام الرئيس:

```bash
ip -brief address show lab-host
ip route get 10.203.0.2
```

داخل الحيز:

```bash
sudo ip netns exec netlab ip -brief address
sudo ip netns exec netlab ip route
```

ثم اختبر:

```bash
ping -c 2 10.203.0.2
sudo ip netns exec netlab ping -c 2 10.203.0.1
```

لم نضف بوابة؛ لا يحتاج الطرفان واحدة لأنهما جاران في السابقة
نفسها.

#section[راقب الجيران]

```bash
ip neighbor show dev lab-host
sudo ip netns exec netlab ip neighbor show dev lab-peer
```

ينبغي أن ترى كل جهة عنوان الأخرى بعد الاختبار. هنا تجتمع مفاهيم
الواجهة والعنوان والسابقة والجار والطريق المتصل.

#warn[
  لا تضف مسارًا افتراضيًا أو NAT إلى المختبر من وصف عشوائي. ذلك
  يفتح موضوع إعادة التوجيه وسياسات الجدار. يكفي أن ينجح الجاران.
]

#section[اكسر شيئًا واحدًا]

أنزل طرف الحيز:

```bash
sudo ip netns exec netlab ip link set lab-peer down
```

كرر الاختبار وسجل الفرق، ثم أعده:

```bash
sudo ip netns exec netlab ip link set lab-peer up
```

أثبت التعافي. أنت تعرف التغيير الوحيد، فلا تحتاج التخمين.

#section[التنظيف جزء من المختبر]

احذف الوصلة ثم الحيز:

```bash
sudo ip link delete lab-host
sudo ip netns delete netlab
```

تحقق:

```bash
ip link show lab-host
ip netns list
```

يفترض أن يفشل الأول وألا يظهر الاسم في الثاني.

#danger[
  نفذ أوامر الحذف بالأسماء المحددة فقط. لا تحولها إلى متغير فارغ
  أو نمط عام، ولا تحذف حيزًا لم تنشئه في هذه الجلسة.
]

#try-it[
  نفذ المختبر من البداية إلى التنظيف. احفظ في دفتر الشبكة مخرجات
  قبل الكسر وأثناءه وبعد التعافي، ثم دليل زوال الواجهة والحيز.
]

#section[خلاصة الفصل]

بنينا شبكة من وصلة افتراضية وسابقة وجارين، بلا إنترنت. كسرنا رابطًا
واحدًا ورأينا الدليل ثم استعدناه ونظفنا. هذه هي هندسة التجربة:
متغير واحد وحدود واضحة ونهاية قابلة للإثبات.

#challenge[
  قبل إعادة تنفيذ المختبر، ارسم جدول الطريق المتوقع في الطرفين
  وجدول الجيران قبل أول `ping` وبعده. نفذ، ثم قارن الرسم بالواقع
  واكتب سبب أي اختلاف.
]
