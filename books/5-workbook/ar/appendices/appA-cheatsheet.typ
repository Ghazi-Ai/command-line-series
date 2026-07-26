#import "/lib/book.typ": appendix, section
#import "/lib/components.typ": note
#import "/lib/theme.typ": SIZE

#appendix("أ", "بطاقةُ الغشّ: مهمّةٌ واحدة، أربعةُ ألسنة")

هذه بطاقةُ مرجعٍ سريعةٌ تجمع أشيعَ مهامّ الكتاب وأوامرَها في الأنظمة الأربعة، صفحاتٍ معدوداتٍ تقتطعها وتُبقيها إلى جانب لوحة مفاتيحك. عمودُ «يونِكس» يجمع لِينُكس وماك وBSD حين يتّفقون (وأكثرُ الأوامر الأساسيّة كذلك)؛ فإذا افترقوا نبّهنا عليه في سطرٍ تحت الجدول.

#note[
  البطاقةُ للتذكير لا للتعلّم؛ كلُّ أمرٍ هنا شُرح وفُصّل في تمرينه. وحيثما احتجت تفصيلَ نظامٍ بعينه، فارجع إلى كتابه في السلسلة.
]

#let cs(..rows) = block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr),
    inset: 5pt,
    align: (x, y) => right + horizon,
    table.header([المهمّة], [ويندوز · PowerShell], [يونِكس (لِينُكس/ماك/BSD)]),
    ..rows
  )
})

#section[التنقّل والملفّات]

#cs(
  [أين أنا], [`Get-Location`], [`pwd`],
  [اعرض المحتويات], [`Get-ChildItem`], [`ls`],
  [انتقل إلى مجلّد], [`cd ~\Docs`], [`cd ~/Docs`],
  [أنشئ مجلّدًا], [`mkdir project`], [`mkdir project`],
  [اقرأ ملفًّا], [`Get-Content f.txt`], [`cat f.txt`],
  [انسخ ملفًّا], [`Copy-Item a b`], [`cp a b`],
  [احذف ملفًّا], [`Remove-Item f`], [`rm f`],
  [طابق بالنجمة], [`Get-ChildItem *.txt`], [`ls *.txt`],
)

#section[النصوص وتدفّق البيانات]

#cs(
  [عدّ الأسطر], [`... | Measure-Object -Line`], [`wc -l`],
  [أوّل الملفّ], [`Get-Content f -Head 10`], [`head f`],
  [ابحث عن كلمة], [`Select-String x f`], [`grep x f`],
  [رتّبْ بلا تكرار], [`... | Sort-Object -Unique`], [`sort -u`],
  [عُدّ التكرار], [`... | Group-Object`], [`sort | uniq -c`],
  [استبدل نصًّا], [`... -replace 'a','b'`], [`sed 's/a/b/g'`],
  [اجمع عمودًا], [`... | Measure-Object -Sum`], [`awk '{s+=$2} END{print s}'`],
)

#note[
  التحرير في المكان `sed -i` يفترق داخل يونِكس: `sed -i 's/a/b/' f` في لِينُكس، و`sed -i '' 's/a/b/' f` في ماك وBSD (لاحقةٌ فارغةٌ إلزاميّة).
]

#section[الصلاحيات والجذر والعمليّات]

#cs(
  [أذونُ ملفّ], [`Get-Acl f`], [`ls -l f`],
  [افتح للجميع], [`icacls f /grant *S-1-1-0:R`], [`chmod a+r f`],
  [أذونٌ بالأرقام], [`icacls` (ACL)], [`chmod 600 f`],
  [غيّر المالك], [`icacls f /setowner u`], [`chown u f`],
  [العمليّات العاملة], [`Get-Process`], [`ps aux`],
  [أنهِ عمليّة], [`Stop-Process -Name x`], [`pkill x`],
  [الأثقل استهلاكًا], [`Get-Process|Sort CPU`], [`top`],
)

#note[
  رفعُ الصلاحيّة: صدفةٌ «كمسؤول» في ويندوز، و`sudo أمر` في لِينُكس وماك، و`doas أمر` في BSD.
]

#section[الحزم والخدمات]

مديرُ الحزم والخدمات يفترق بين الأنظمة الأربعة كلِّها، فإليك المهامَّ الأربعَ لكلٍّ:

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    inset: 4pt,
    align: (x, y) => right + horizon,
    table.header([المهمّة], [ويندوز], [لِينُكس], [ماك], [BSD]),
    [ثبّت حزمة], [`winget install`], [`apt install`], [`brew install`], [`pkg install`],
    [ابحث], [`winget search`], [`apt search`], [`brew search`], [`pkg search`],
    [رقِّ الكلّ], [`winget upgrade`], [`apt upgrade`], [`brew upgrade`], [`pkg upgrade`],
    [شغّل خدمة], [`Start-Service`], [`systemctl start`], [`brew services start`], [`service .. start`],
    [فعّل بالإقلاع], [`Set-Service -Startup`], [`systemctl enable`], [`sudo brew services`], [`sysrc x_enable=YES`],
  )
})

#section[الشبكة]

#cs(
  [اختبر الاتّصال], [`ping host`], [`ping host`],
  [استعلم DNS], [`nslookup host`], [`dig host` (drill في BSD)],
  [نزّل ملفًّا], [`Invoke-WebRequest -OutFile`], [`curl -O` (fetch في BSD)],
  [ادخل خادمًا], [`ssh u@host`], [`ssh u@host`],
  [انسخ إلى خادم], [`scp f u@host:~`], [`scp f u@host:~`],
  [المنافذ المفتوحة], [`Get-NetTCPConnection`], [`ss -tulpn` (sockstat في BSD)],
)

#section[المطوّر والأمن والنظام]

#cs(
  [ابدأ مستودع Git], [`git init`], [`git init`],
  [سجّل لقطة], [`git add . && git commit -m`], [`git add . && git commit -m`],
  [ادفع للبعيد], [`git push origin main`], [`git push origin main`],
  [ابحث في الكود], [`Get-ChildItem -Recurse|sls`], [`grep -r x .` (أو `rg x`)],
  [أين أمرٌ], [`Get-Command git`], [`which git`],
  [عمِّ ملفًّا], [`gpg -c f`], [`gpg -c f`],
  [بصمة SHA-256], [`Get-FileHash f`], [`sha256sum f` (sha256/shasum)],
  [اعرف نظامك], [`Get-ComputerInfo`], [`uname -a`],
  [ضغط أرشيف], [`Compress-Archive`], [`tar czf a.tgz d`],
  [مساحة القرص], [`Get-PSDrive`], [`df -h`],
)

#note[
  Git وgpg وssh وrsync برامجُ مستقلّةٌ عابرةٌ للأنظمة، فأوامرُها متطابقةٌ في الأربعة تمامًا — تعلّمها مرّةً، واعمل بها في كلّ مكان.
]
