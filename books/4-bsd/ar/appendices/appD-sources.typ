#import "/lib/book.typ": appendix, section
#import "/lib/components.typ": note

#appendix("د", "المصادر والمراجع")

جميع نصوص هذا الكتاب *أصليّة*، صيغت خصّيصًا له، ولم تُنسخ من أيّ مصدر. وقد تحقّقنا من أوامر الأساس ومخرجاتها بتشغيلها فعليًّا على نظامٍ دارْوينيٍّ مشتقٍّ من BSD، وراجعنا ما ينفرد به FreeBSD وOpenBSD من مصادرهما الرسميّة. وفي ما يلي المراجع الموثوقة التي اعتُمِدت للتحقّق من الدقّة، عرفانًا لأصحابها وضمانًا للأمانة العلميّة.

#section[المعايير]

- معيار POSIX ومواصفة يونِكس الموحّدة — IEEE Std 1003.1 من The Open Group، على `pubs.opengroup.org`

#section[توثيق FreeBSD الرسميّ]

- كتيّب FreeBSD (FreeBSD Handbook)، المرجع الشامل للنظام — `docs.freebsd.org`
- صفحات دليل FreeBSD على الوِب، تُقرأ محلّيًّا بالأمر `man` — `man.freebsd.org`
- دليل مطوّري FreeBSD ودليل كاتب المنافذ (Porter's Handbook) لشجرة ports — `docs.freebsd.org`

#section[توثيق OpenBSD الرسميّ]

- أسئلة OpenBSD الشائعة (OpenBSD FAQ)، ومنها دليل `pf` وإدارة الحزم والخدمات — `openbsd.org/faq`
- صفحات دليل OpenBSD (تُعرف بجودتها ودقّتها) — `man.openbsd.org`

#section[NetBSD وDragonFly]

- دليل NetBSD الرسميّ ومنظومة الحزم `pkgsrc` — `netbsd.org/docs`
- توثيق DragonFly BSD وصفحات دليله — `dragonflybsd.org`

#section[نظام الملفّات ZFS]

- توثيق مشروع OpenZFS الرسميّ (الأوامر والخصائص والإدارة) — `openzfs.github.io/openzfs-docs`

#section[الأدوات المشتركة]

- أدلّة OpenSSH الرسميّة (`ssh` و`scp` و`ssh-keygen`)، وهي من OpenBSD أصلًا — `openssh.com`
- دليل Git الرسميّ وكتاب Pro Git (سكوت شاكون وبن سترواب، مفتوحٌ مجّانًا) — `git-scm.com`
- أدلّة GNU للأدوات التي تُثبَّت اختياريًّا عبر `pkg` (coreutils وgsed وgawk) — `gnu.org/manual`

#section[كتبٌ مرجعيّة معتمدة]

- The Design and Implementation of the FreeBSD Operating System — مارشال كيرك مكيوزِك ورفاقه؛ المرجعُ الأعمقُ لبنية النظام
- Absolute FreeBSD — مايكل و. لوكاس؛ مرجعٌ عمليٌّ واسعٌ لإدارة FreeBSD
- The Book of PF — مايكل و. لوكاس؛ المرجعُ العمليُّ لجدار `pf` الناريّ

#note[
  المراجع أعلاه للتحقّق والعزو؛ أسماؤها وروابطها صحيحةٌ كما وردت في مصادرها الرسميّة، ولم يُنسخ منها نصّ. أمّا مقترحاتُ مواصلة التعلّم فتجدها في الملحق «هـ: مصادر للاستزادة».
]
