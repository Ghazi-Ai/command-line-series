#import "/lib/book.typ": appendix, section
#import "/lib/components.typ": note

#appendix("د", "المصادر والمراجع")

جميع نصوص هذا الكتاب *أصليّة*، صيغت خصّيصًا له، ولم تُنسخ من أيّ مصدر. وقد تحقّقنا من كلّ أمرٍ ومخرجٍ بتشغيله فعليًّا على نظام ماك (macOS). وفي ما يلي المراجع الموثوقة التي اعتُمِدت للتحقّق من الدقّة، عرفانًا لأصحابها وضمانًا للأمانة العلميّة.

#section[المعايير]

- معيار POSIX ومواصفة يونِكس الموحّدة — IEEE Std 1003.1 (The Open Group Base Specifications).

#section[توثيق Apple الرسميّ]

- دليل مستخدم الطرفية (Terminal User Guide) — ‏`support.apple.com/guide/terminal`‎.
- صفحات الدليل في macOS — تُقرأ بالأمر `man` في الطرفية، ويكمّلها توثيق مطوّري Apple على ‏`developer.apple.com/documentation`‎.
- موقع مطوّري Apple (Apple Developer) وأدلّة سطر الأوامر ومنصّة Xcode — ‏`developer.apple.com`‎.

#section[Homebrew]

- التوثيق الرسميّ لمدير الحزم Homebrew — ‏`docs.brew.sh`‎.

#section[الصدفة zsh]

- دليل zsh الرسميّ (zsh manual) — ‏`zsh.sourceforge.io/Doc`‎؛ وهي الصدفة الافتراضيّة في macOS منذ Catalina.

#section[عالم BSD]

- صفحات دليل BSD وأدلّة FreeBSD (FreeBSD Handbook وصفحات `man` لـ FreeBSD) — ‏`docs.freebsd.org`‎؛ إذ إنّ نواة macOS (Darwin/XNU) وكثيرًا من أدواتها الأساسيّة تنحدر من BSD.

#section[أدوات GNU المجلوبة]

- أدلّة GNU الرسميّة للأدوات التي تُثبَّت عبر Homebrew — دليل GNU Coreutils، ودليل مرجع صدفة GNU Bash، وأدلّة `grep` و`sed` و`gawk` — ‏`gnu.org/manual`‎.

#section[مراجع الأدوات]

- دليل Git الرسميّ وكتاب Pro Git (سكوت شاكون وبن سترواب، مفتوحٌ مجّانًا) — ‏`git-scm.com`‎.
- أدلّة OpenSSH الرسميّة (`ssh` و`scp` و`ssh-keygen`) — ‏`openssh.com`‎.

#note[
  المراجع أعلاه للتحقّق والعزو؛ أسماؤها وروابطها صحيحةٌ كما وردت في مصادرها الرسميّة،
  ولم يُنسخ منها نصّ. أمّا مقترحات مواصلة التعلّم فتجدها في الملحق «هـ: مصادر للاستزادة».
]
