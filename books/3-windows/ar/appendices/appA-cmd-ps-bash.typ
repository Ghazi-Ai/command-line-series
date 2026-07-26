#import "/lib/book.typ": appendix, section, subsection
#import "/lib/components.typ": note, tip, warn
#import "/lib/theme.typ": SIZE

// الكود المضمّن يساريّ LTR كي لا تنعكس رموزٌ مثل `cd ..` و`$X` و`%X%` و`app &` و`.bat`
// حين تُوضع داخل نصٍّ عربيٍّ أو خليّةِ جدولٍ يمينيّة. القاعدة محصورةٌ في هذا الملفّ.
#show raw.where(block: false): set text(dir: ltr)

#appendix("أ", "جدول مقارنة CMD وPowerShell وBash")

الصَّدفات الثلاث التي رافقتك في هذا الكتاب — موجّه الأوامر (CMD)، وPowerShell، وBash خلف باب WSL — كثلاث لغاتٍ تقول المعنى نفسه بمفرداتٍ مختلفة. فحين تريد سرد مجلّدٍ أو نسخ ملفٍّ أو إنهاء عمليّة، لكلٍّ منها كلمتُها الخاصّة للمهمّة نفسها. من عرف المهمّة في لغةٍ واحدة، لم يحتج إلّا إلى «المعجم» ليقولها في الأخرى؛ وهذا الملحق هو ذلك المعجم.

اقرأ الجدول هكذا: ابحث عن المهمّة في العمود الأيمن، ثم اقرأ الأمر المكافئ تحت كلّ صدفة. حيثما ترى `FILE` فاستبدلها باسم الملفّ، و`DIR` باسم المجلّد، و`NAME` باسم الخدمة، و`X` باسم المتغيّر، و`A` و`B` بالاسمين اللذين يقتضيهما الأمر (ملفَّين في النسخ والنقل، وأمرَين في صفّ الأنبوب). أمّا الشَّرطة `—` فتعني أنّه لا مكافئ مدمجٌ مباشر.

#note[
  عمودُ *CMD* هو موجّه أوامر ويندوز الكلاسيكيّ. عمودُ *PowerShell* يفترض PowerShell 7، وأوامره (cmdlets) تعمل على ويندوز ولِينُكس وماك على السواء، ما لم نشِر إلى أنّها *ويندوزيّةٌ خالصة*. عمودُ *Bash* يمثّل صدفة Bash وأدوات لِينُكس كما تصل إليها عبر WSL — وهي نفسها موضوع كتاب لِينُكس من هذه السلسلة. وعلى ويندوز خاصّةً تحمل أوامرُ PowerShell أسماءً مستعارةً شبيهةً بيونِكس (`ls`، `cat`، `cp`، `rm`...) تسهّل العبور؛ ملحق «مرجع cmdlets السريع» يسردها.
]

#section[التنقّل في نظام الملفّات]

#block(breakable: true, {
  set text(size: SIZE.small)
  show raw: set text(size: 8pt)
  table(
    columns: (auto, 0.9fr, 1.3fr, 0.9fr),
    inset: 5pt,
    align: (x, y) => if x == 0 { right + horizon } else { center + horizon },
    table.header([المهمّة], [CMD], [PowerShell], [Bash]),

    [المجلّد الحاليّ],
    [`cd`],
    [`Get-Location`],
    [`pwd`],

    [سرد المحتويات],
    [`dir`],
    [`Get-ChildItem`],
    [`ls`],

    [الانتقال إلى مجلّد],
    [`cd DIR`],
    [`Set-Location DIR`],
    [`cd DIR`],

    [الصعود مستوًى],
    [`cd ..`],
    [`cd ..`],
    [`cd ..`],

    [المجلّد المنزليّ],
    [`cd %USERPROFILE%`],
    [`cd ~`],
    [`cd ~`],

    [إنشاء مجلّد],
    [`mkdir DIR`],
    [`New-Item -ItemType Directory DIR`],
    [`mkdir DIR`],

    [حذف مجلّد فارغ],
    [`rmdir DIR`],
    [`Remove-Item DIR`],
    [`rmdir DIR`],

    [حذف مجلّد بمحتواه],
    [`rmdir /s DIR`],
    [`Remove-Item -Recurse DIR`],
    [`rm -r DIR`],

    [مسح الشاشة],
    [`cls`],
    [`Clear-Host`],
    [`clear`],
  )
})

#note[
  على ويندوز يستجيب `Get-ChildItem` للمستعارَين `ls` و`dir`، و`Set-Location` للمستعار `cd`، و`Get-Location` للمستعار `pwd`؛ فالأوامر القصيرة التي تعرفها تعمل كما هي. أمّا على لِينُكس وماك فيُحذف من هذه المستعارات ما يحجب أمرًا أصليًّا في النظام — مثل `ls` — ويبقى ما لا يزاحم شيئًا مثل `dir` و`cd` و`pwd`. فاعتَدِ الاسم الكامل في السكربتات كي تعمل حيثما نُقلت.
]

#section[عرض الملفّات ومعالجتها]

#block(breakable: true, {
  set text(size: SIZE.small)
  show raw: set text(size: 8pt)
  table(
    columns: (auto, 0.9fr, 1.3fr, 0.9fr),
    inset: 5pt,
    align: (x, y) => if x == 0 { right + horizon } else { center + horizon },
    table.header([المهمّة], [CMD], [PowerShell], [Bash]),

    [عرض محتوى ملفّ],
    [`type FILE`],
    [`Get-Content FILE`],
    [`cat FILE`],

    [أوّل عشرة أسطر],
    [`—`],
    [`Get-Content FILE -Head 10`],
    [`head FILE`],

    [آخر عشرة أسطر],
    [`—`],
    [`Get-Content FILE -Tail 10`],
    [`tail FILE`],

    [متابعة ملفٍّ حيًّا],
    [`—`],
    [`Get-Content FILE -Wait -Tail 10`],
    [`tail -f FILE`],

    [نسخ ملفّ],
    [`copy A B`],
    [`Copy-Item A B`],
    [`cp A B`],

    [نقلٌ أو إعادة تسمية],
    [`move A B`],
    [`Move-Item A B`],
    [`mv A B`],

    [حذف ملفّ],
    [`del FILE`],
    [`Remove-Item FILE`],
    [`rm FILE`],

    [إنشاء ملفٍّ فارغ],
    [`type nul > FILE`],
    [`New-Item FILE`],
    [`touch FILE`],

    [إلحاق نصٍّ بملفّ],
    [`echo hi >> FILE`],
    [`Add-Content FILE hi`],
    [`echo hi >> FILE`],

    [كتابة نصٍّ يستبدل المحتوى],
    [`echo hi > FILE`],
    [`Set-Content FILE hi`],
    [`echo hi > FILE`],
  )
})

#section[المتغيّرات والبيئة]

#block(breakable: true, {
  set text(size: SIZE.small)
  show raw: set text(size: 8pt)
  table(
    columns: (auto, 0.9fr, 1.3fr, 0.9fr),
    inset: 5pt,
    align: (x, y) => if x == 0 { right + horizon } else { center + horizon },
    table.header([المهمّة], [CMD], [PowerShell], [Bash]),

    [متغيّرٌ في الجلسة],
    [`set X=val`],
    [`$X = "val"`],
    [`X=val`],

    [قراءة قيمة متغيّر],
    [`echo %X%`],
    [`$X`],
    [`echo $X`],

    [متغيّر بيئة],
    [`set X=val`],
    [`$env:X = "val"`],
    [`export X=val`],

    [قراءة متغيّر بيئة],
    [`echo %PATH%`],
    [`$env:PATH`],
    [`echo $PATH`],

    [سرد كلّ المتغيّرات],
    [`set`],
    [`Get-ChildItem Env:`],
    [`env`],
  )
})

#note[
  موجّه الأوامر لا يفرّق بين متغيّر الجلسة ومتغيّر البيئة، فكلاهما `set`. أمّا *تثبيت* المتغيّر ليبقى بعد إغلاق النافذة فطريقٌ مستقلٌّ في كلٍّ: في CMD الأمرُ `setx X val` يكتبه للجلسات *القادمة* لا للحاليّة؛ وفي PowerShell تكتب `[Environment]::SetEnvironmentVariable('X','val','User')` بثلاثة وسائط هي الاسم والقيمة والنطاق؛ وفي Bash يُضاف سطرُ `export` إلى ملفّ `~/.bashrc` ليُقرأ عند كلّ جلسةٍ جديدة.
]

#section[الأنبوب والترشيح والنصّ]

#block(breakable: true, {
  set text(size: SIZE.small)
  show raw: set text(size: 8pt)
  table(
    columns: (auto, 0.9fr, 1.3fr, 0.9fr),
    inset: 5pt,
    align: (x, y) => if x == 0 { right + horizon } else { center + horizon },
    table.header([المهمّة], [CMD], [PowerShell], [Bash]),

    [وصل الأوامر بالأنبوب],
    [`A | B`],
    [`A | B`],
    [`A | B`],

    [البحث عن نمط],
    [`findstr pat FILE`],
    [`Select-String pat FILE`],
    [`grep pat FILE`],

    [الترتيب],
    [`sort`],
    [`Sort-Object`],
    [`sort`],

    [عدّ الأسطر],
    [`find /c /v ""`],
    [`Measure-Object -Line`],
    [`wc -l`],

    [أوّل عددٍ من العناصر],
    [`—`],
    [`Select-Object -First 5`],
    [`head -n 5`],

    [إزالة المكرّر],
    [`—`],
    [`Sort-Object -Unique`],
    [`sort -u`],

    [الاستبدال في النصّ],
    [`—`],
    [`$x -replace 'a','b'`],
    [`sed 's/a/b/'`],
  )
})

#warn[
  الأنبوب `|` يبدو واحدًا، لكنّ ما يجري فيه مختلف: في CMD وBash يسيل *نصٌّ* خام تقصّه بأدواتٍ نصّيّة، وفي PowerShell تسيل *كائناتٌ* كاملةٌ ترشّحها بخصائصها لا بحروف اسمها. ولهذا إن سالت في أنبوب PowerShell قيمٌ عدديّةٌ لا نصّيّة رتّبها `Sort-Object` ترتيبًا عدديًّا، بينما يرتّب `sort` سطورَه حرفًا حرفًا فيأتي `10` قبل `2`. وانتبه: لو جاءت الأسطر إلى `Sort-Object` نصًّا — كسطور ملفٍّ قرأها `Get-Content` — لرتّبها حرفًا حرفًا هو أيضًا؛ فالعبرة بنوع ما يسيل لا باسم الأمر. الفصل العاشر يشرح هذا الفرق الجوهريّ.
]

#section[العمليّات والخدمات]

#block(breakable: true, {
  set text(size: SIZE.small)
  show raw: set text(size: 8pt)
  table(
    columns: (auto, 0.9fr, 1.3fr, 0.9fr),
    inset: 5pt,
    align: (x, y) => if x == 0 { right + horizon } else { center + horizon },
    table.header([المهمّة], [CMD], [PowerShell], [Bash]),

    [سرد العمليّات],
    [`tasklist`],
    [`Get-Process`],
    [`ps aux`],

    [إنهاء عمليّةٍ بالمعرّف],
    [`taskkill /PID 123`],
    [`Stop-Process -Id 123`],
    [`kill 123`],

    [إنهاء عمليّةٍ بالاسم],
    [`taskkill /IM app.exe`],
    [`Stop-Process -Name app`],
    [`pkill app`],

    [تشغيل برنامج],
    [`start app`],
    [`Start-Process app`],
    [`app &`],

    [سرد الخدمات],
    [`sc query`],
    [`Get-Service`],
    [`systemctl`],

    [تشغيل خدمة],
    [`net start NAME`],
    [`Start-Service NAME`],
    [`systemctl start NAME`],

    [إيقاف خدمة],
    [`net stop NAME`],
    [`Stop-Service NAME`],
    [`systemctl stop NAME`],
  )
})

#note[
  أوامرُ الخدمات `Get-Service` و`Start-Service` و`Stop-Service` *ويندوزيّةٌ خالصة*؛ فهي تخاطب مدير خدمات ويندوز ولا وجود لها في PowerShell على لِينُكس. وفي عمود Bash المكافئُ هو `systemctl` (من systemd)، وهو أداةُ لِينُكس لا أمرٌ مدمجٌ في الصدفة؛ يعمل داخل WSL على التوزيعات التي تشغّل systemd.
]

#section[الشبكة]

#block(breakable: true, {
  set text(size: SIZE.small)
  show raw: set text(size: 8pt)
  table(
    columns: (auto, 0.85fr, 1.4fr, 0.9fr),
    inset: 5pt,
    align: (x, y) => if x == 0 { right + horizon } else { center + horizon },
    table.header([المهمّة], [CMD], [PowerShell], [Bash]),

    [العناوين والواجهات],
    [`ipconfig`],
    [`Get-NetIPAddress`],
    [`ip addr`],

    [اختبار الوصول],
    [`ping host`],
    [`Test-Connection host`],
    [`ping host`],

    [جدول التوجيه],
    [`route print`],
    [`Get-NetRoute`],
    [`ip route`],

    [استعلام DNS],
    [`nslookup name`],
    [`Resolve-DnsName name`],
    [`dig name`],

    [المنافذ المفتوحة],
    [`netstat -ano`],
    [`Get-NetTCPConnection`],
    [`ss -tulpn`],

    [تنزيل ملفّ],
    [`curl -O url`],
    [`Invoke-WebRequest url -OutFile f`],
    [`wget url`],
  )
})

#note[
  أوامرُ `Get-NetIPAddress` و`Get-NetRoute` و`Get-NetTCPConnection` و`Resolve-DnsName` *ويندوزيّةٌ خالصة* من وحدات إدارة شبكة ويندوز. وعلى ويندوز تعمل الأدوات الكلاسيكيّة (`ipconfig`، `ping`، `nslookup`) من داخل PowerShell أيضًا لأنّها برامج مستقلّة.
]

#warn[
  في PowerShell 7 لم يعد `curl` و`wget` مستعارَين لـ `Invoke-WebRequest` كما كانا في الإصدار 5.1؛ صار كلٌّ منهما ينادي البرنامج المستقلّ الذي يحمل اسمه إن كان مثبَّتًا. و`curl.exe` مشمولٌ في ويندوز حديثًا فيعمل فورًا، أمّا `wget.exe` فلا يأتي مع النظام وتحتاج إلى تثبيته. ولتضمن أن يعمل أمرُ PowerShell نفسُه أينما كنت، استعمل الاسم الكامل `Invoke-WebRequest` أو مستعاره `iwr`.
]

#section[بنية السكربت: التعليق والشرط والحلقة]

#block(breakable: true, {
  set text(size: SIZE.small)
  show raw: set text(size: 8pt)
  table(
    columns: (auto, 0.9fr, 1.3fr, 0.9fr),
    inset: 5pt,
    align: (x, y) => if x == 0 { right + horizon } else { center + horizon },
    table.header(
      [المفهوم],
      text(dir: ltr)[CMD `.bat`],
      text(dir: ltr)[PowerShell `.ps1`],
      text(dir: ltr)[Bash `.sh`],
    ),

    [تعليق],
    [`REM TEXT`],
    [`# TEXT`],
    [`# TEXT`],

    [طباعة نصّ],
    [`echo TEXT`],
    [`Write-Output TEXT`],
    [`echo TEXT`],

    [شرط],
    [`if "%X%"=="y" (...)`],
    [`if ($X -eq "y") {...}`],
    [`if [ "$X" = y ]; then`],

    [حلقة عدّ],
    [`for /l %%i in (1,1,3)`],
    [`1..3 | ForEach-Object {...}`],
    [`for i in 1 2 3; do`],

    [حلقة على ملفّات],
    [`for %%f in (*.txt)`],
    [`Get-ChildItem *.txt | ForEach-Object {...}`],
    [`for f in *.txt; do`],

    [تعريف دالة],
    [`:name ... call :name`],
    [`function name {...}`],
    [`name() {...}`],

    [متغيّر عنصر الحلقة],
    [`%%f`],
    [`$_`],
    [`$f`],
  )
})

#note[
  رمزُ متغيّر الحلقة في CMD يختلف بحسب الموضع: داخل ملفّ باتش `.bat` تكتب `%%f` بنسبتَين مئويّتَين، وفي السطر التفاعليّ المباشر تكتبه بواحدةٍ فقط `%f`. أمّا `$_` في PowerShell فهو «الكائن الحاليّ» المارُّ في الأنبوب، ويقابله في Bash اسمُ المتغيّر الذي تختاره أنت في `for`.
]

#section[أربعة فروقٍ جوهريّة تحت الجدول]

الجدول يعطيك الكلمة المكافئة، لكنّ إتقان العبور بين الصَّدفات يقتضي وعيًا بأربعة فروقٍ بنيويّةٍ لا تظهر في صفٍّ واحد، وهي مصدرُ أكثر المفاجآت حين ينتقل السكربت من عالمٍ إلى آخر.

#subsection[فاصل المسار: شرطةٌ عكسيّةٌ أم أماميّة]

ويندوز يفصل أجزاء المسار بالشَّرطة العكسيّة `\` (مثل `C:\Users\Data`)، ولِينُكس بالأماميّة `/` (مثل `/home/user/data`). موجّه الأوامر يصرّ على العكسيّة، وBash على الأماميّة، بينما PowerShell متسامحٌ فيقبل الاثنين. والأدهى أنّ الشَّرطة العكسيّة نفسها في Bash *حرفُ تهريب*، أي حرفٌ لا يُطبع بذاته بل يُلغي المعنى الخاصّ للحرف الذي يليه؛ فإن نسختَ مسارًا ويندوزيًّا كما هو إلى سكربت Bash ابتلعت شَرطاتُه حروفَ المسار وانكسر.

#subsection[نصٌّ أم كائنات]

CMD وBash يمرّران في أنبوبهما *نصًّا* خامًا، فأنت تقصّه وترشّحه بأدواتٍ نصّيّة (`findstr`، `grep`، `awk`). PowerShell يمرّر *كائناتٍ* تحمل خصائصها ومعناها، فترشّح بخاصّيّةٍ لا بموضع حرف. هذا أعمق فرقٍ بين الفلسفتَين، وقد أفردنا له الجزء الثالث من الكتاب.

#subsection[حساسيّة حالة الأحرف]

نظام ملفّات ويندوز لا يفرّق بين `Report.txt` و`report.txt`، فهما اسمٌ واحد؛ أمّا لِينُكس فيعدّهما ملفّين منفصلَين تمامًا. سكربتٌ يعمل على ويندوز قد يفشل في WSL لمجرّد فرقٍ في حالة حرفٍ من اسم ملفّ.

#subsection[نهايات الأسطر: CRLF مقابل LF]

ملفّات ويندوز تنهي كلّ سطرٍ بمحرفَين (CRLF)، ولِينُكس بمحرفٍ واحد (LF). وسكربتُ Bash الذي حُرِّر بمحرّر ويندوز وحُفِظ بنهايات CRLF قد يرفض العمل في WSL بخطأٍ غامضٍ مثل `bad interpreter`، أي «مفسِّرٌ غير صالح». والسبب أنّ أوّل سطرٍ في السكربت يسمّي البرنامج الذي ينفّذه — ويسمّى *المفسِّر* — فيَعُدّ لِينُكس محرف `\r` الزائد جزءًا من ذلك الاسم فلا يجد له برنامجًا. حوّل النهايات إلى LF قبل التشغيل.

#warn[
  حين تنقل سكربتًا بين ويندوز وWSL، هذان الفخّان — حالة الأحرف ونهايات الأسطر — هما أكثر ما يوقع المبتدئ في خطأٍ يصعب تفسيره. اضبط محرّرك على حفظ سكربتات `.sh` بنهايات LF، وانتبه إلى حالة أسماء الملفّات بدقّة.
]

#section[خلاصةٌ عمليّة]

القاعدةُ الجامعة أنّ المهمّة واحدةٌ والمفردة تختلف: من عرف «كيف يسرد مجلّدًا» أو «كيف يُنهي عمليّة» يحتاج فقط أن يترجم الفعل إلى لغة الصدفة التي أمامه، وهذا الجدول معجمه. والفرق الأعمق الذي يجاوز المفردات هو أنّ CMD وBash يعملان بالنصّ، بينما PowerShell يعمل بالكائنات؛ فمتى انتقلت إليه فكّر بالخصائص لا بالحروف. وإن أردت التوسّع، فكتاب لِينُكس من هذه السلسلة هو المرجع الكامل لعمود Bash وأدواته وفلسفته كاملةً، تمامًا كما لمحتَها خلف باب WSL.
