// ═══ الجزء الثامن · الأمن ═══
#import "/lib/book.typ": part, chapter
#import "/books/5-workbook/ar/lib-workbook.typ": win, linux, mac, bsd, ex, goal, doit, diff, ex-challenge

#part("الثامن", "الأمن")

الأمنُ ليس أمرًا تكتبه مرّةً، بل عادةٌ تلازمك: أن تضبط الأذونَ بدقّة، وتعمّي ما يجب سترُه، وتقلّل سطحَ هجومك، وتقرأ سجلّاتك لتعرف ما جرى. في هذا الجزء تتعلّم أدواتِ الحماية في الأنظمة الأربعة — وفيه تلمع خصوصيّاتُ BSD (كأعلام `chflags`) التي جعلته خيارَ من يجعل الأمنَ أوّلَ همّه.

// ───────────────────────── الفصل 28 ─────────────────────────
#chapter("الصلاحيات المتقدّمة")

#ex("28.1", "أذونٌ بالأرقام", "متوسّط")
#goal[أن تضبط أذونَ ملفٍّ بدقّة، وتتحقّق ممّن بقي له حقُّ الوصول.]
#doit[اقطع الأذونَ الموروثةَ عن `secret.txt`، وامنح حسابَك القراءةَ والكتابة، ثمّ راجع قائمة ACL.]
#win(`icacls secret.txt /inheritance:r /grant:r "$($env:USERNAME):(R,W)"`)
#linux(`chmod 600 secret.txt`)
#mac(`chmod 600 secret.txt`)
#bsd(`chmod 600 secret.txt`)
#diff[اليونِكس يختصر الأذونَ في ثلاثة أرقامٍ ثمانيّة: `600` تعني «للمالك قراءةٌ وكتابة (6=4+2)، وللمجموعة والآخرين لا شيء (0+0)». أمّا ويندوز فقوائمُ ACL قد تضمّ إدخالاتٍ صريحةً سابقةً لا يزيلها تعطيلُ الوراثة؛ لذلك نفّذ `icacls secret.txt` بعد الأمر، وراجع كلَّ إدخال بدل افتراض أنّ الحساب الحالي صار الوحيد.]

#ex("28.2", "احمِ ملفًّا من التعديل", "متقدّم")
#goal[أن تتعرّف آليّاتِ الحماية من التعديل وحدودَها في كلّ نظام.]
#doit[فعّل أقربَ حمايةٍ أصيلةٍ من التعديل على `important.txt`، ثمّ حدّد مَن يستطيع إلغاءها.]
#win(`attrib +r important.txt`)
#linux(`sudo chattr +i important.txt`)
#mac(`sudo chflags uchg important.txt`)
#bsd(`doas chflags schg important.txt`)
#diff[هذه الآليّات غير متكافئة أمنيًّا. في ويندوز `attrib +r` سمةُ قراءة فقط يستطيع صاحبُ الصلاحيّة إزالتها. وفي ماك `uchg` يستطيع المالكُ أو الجذر رفعَه. وفي لِينُكس يستطيع الجذر إزالة `immutable`. أمّا `schg` في BSD فلا يعجز الجذر عن إزالته إلا عند `securelevel` مناسب؛ وفي الوضع العادي يستطيع الجذر تنفيذ `chflags noschg`.]

// ───────────────────────── الفصل 29 ─────────────────────────
#chapter("التعمية")

#ex("29.1", "عمِّ ملفًّا بكلمة مرور", "متوسّط")
#goal[أن تشفّر ملفًّا فلا يقرؤه إلا من يملك كلمةَ المرور.]
#doit[عمِّ ملفّ `secret.txt` بكلمة مرور.]
#win(`gpg -c secret.txt`)
#linux(`gpg -c secret.txt`)
#mac(`gpg -c secret.txt`)
#bsd(`gpg -c secret.txt`)
#diff[`gpg -c` (تعميةٌ متماثلة) يشفّر ملفًّا بكلمة مرورٍ في الأنظمة الأربعة، لأنّ GPG برنامجٌ مستقلٌّ يُثبَّت. ينتج `secret.txt.gpg` مشفّرًا؛ ولفكّه: `gpg secret.txt.gpg`. ولكلّ نظامٍ أيضًا تعميةُ *قرصٍ* كاملةٍ باسمها الخاصّ: BitLocker في ويندوز، وFileVault في ماك، وGELI في BSD، وLUKS في لِينُكس.]

#ex("29.2", "احسبْ بصمةَ ملفّ", "متوسّط")
#goal[أن تتحقّق من سلامة ملفٍّ نزّلته بمطابقة بصمته.]
#doit[احسبْ بصمةَ SHA-256 لملفّ `data.zip`.]
#win(`Get-FileHash data.zip`)
#linux(`sha256sum data.zip`)
#mac(`shasum -a 256 data.zip`)
#bsd(`sha256 data.zip`)
#diff[البصمةُ (hash) رقمٌ فريدٌ يتغيّر إن تبدّل بايتٌ واحدٌ في الملفّ، فتتحقّق به من سلامة تنزيلٍ أو من تطابق نسختين. الأداةُ تختلف اسمًا: `sha256sum` في لِينُكس، و`shasum -a 256` في ماك، و`sha256` الأصيلُ في BSD، و`Get-FileHash` في ويندوز. لكنّ المعيارَ واحدٌ (SHA-256)، فالبصمةُ الناتجةُ *متطابقةٌ* في الأربعة لنفس الملفّ — وذاك سرُّ فائدتها.]

// ───────────────────────── الفصل 30 ─────────────────────────
#chapter("تقوية النظام")

#ex("30.1", "ما المنافذُ المفتوحة؟", "متوسّط")
#goal[أن تعرف سطحَ هجومك: أيُّ المنافذ يستمع عليها نظامك.]
#doit[اعرض المنافذَ التي يستمع عليها نظامك الآن.]
#win(`Get-NetTCPConnection -State Listen`)
#linux(`sudo ss -tulpn`)
#mac(`sudo lsof -i -P | grep LISTEN`)
#bsd(`sockstat -l`)
#diff[«سطحُ الهجوم» هو المنافذُ المفتوحةُ للعالم؛ كلُّ منفذٍ بابٌ محتمَل. لِينُكس أداتُه `ss -tulpn` (خلَفَ `netstat`)، وماك `lsof -i`، وBSD أداتُه الأنيقةُ الأصيلةُ `sockstat -l`، وويندوز `Get-NetTCPConnection`. قاعدةُ التقوية الذهبيّة: أغلقْ كلَّ منفذٍ لا تحتاجه.]

#ex("30.2", "رقّعْ نظامك", "أساسيّ")
#goal[أن تسدّ الثغراتِ المعلَنةَ بتثبيت آخر التحديثات.]
#doit[افتح أو شغّل آليّة تحديث النظام، ثمّ ثبّت آخرَ ترقيعاته المتاحة.]
#win(`Start-Process "ms-settings:windowsupdate"`)
#linux(`sudo apt update && sudo apt upgrade`)
#mac(`sudo softwareupdate -ia`)
#bsd(`doas freebsd-update fetch install`)
#diff[أبسطُ تقويةٍ وأهمُّها: حدّثْ دائمًا. يفتح أمر ويندوز صفحة Windows Update الرسمية؛ افحص التحديثات وثبّتها منها، أمّا `winget upgrade --all` فيرقّي التطبيقات لا نظام ويندوز. لِينُكس يستعمل `apt upgrade`، وماك `softwareupdate -ia`. وعلى تثبيت FreeBSD التقليدي يحدّث `freebsd-update` النظامَ الأساس؛ أمّا مستخدم pkgbase التجريبي في FreeBSD 15 فيحدّث حزم النظام بـ`pkg upgrade`.]

// ───────────────────────── الفصل 31 ─────────────────────────
#chapter("السجلّات")

#ex("31.1", "اقرأ سجلَّ النظام", "متوسّط")
#goal[أن تقرأ ما سجّله نظامك من أحداثٍ لتعرف ما جرى.]
#doit[اعرض آخرَ أحداث النظام في السجلّ.]
#win(`Get-WinEvent -LogName System -MaxEvents 20`)
#linux(`journalctl -n 20`)
#mac(`log show --last 5m`)
#bsd(`tail /var/log/messages`)
#diff[أين يعيش السجلّ؟ تختلف الفلسفات: لِينُكس (systemd) يجمعه في سجلٍّ *ثنائيٍّ* يُقرأ بـ`journalctl`، وماك في سجلٍّ موحّدٍ يُقرأ بـ`log show`. أمّا BSD فيبقي سجلّاتٍ نصّيّةً في `/var/log` تقرؤها بـ`tail` و`grep`، وويندوز له سجلُّ أحداثٍ بنيويٌّ يُقرأ في PowerShell 7 بـ`Get-WinEvent`.]
#ex-challenge[صِدِ الأخطاءَ فقط: `journalctl -p err` في لِينُكس، و`grep -i error /var/log/messages` في BSD، و`Get-WinEvent -FilterHashtable @{LogName='System'; Level=2}` في ويندوز.]
