// الفصل الخامس والثلاثون: الطرفية بيئةَ عملٍ: Windows Terminal وPSReadLine
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, danger, distro, try-it, define, challenge, objectives, kbd, session, ethics, deep

#chapter[الطرفية بيئةَ عملٍ: Windows Terminal وPSReadLine]

#objectives((
  [تفهم لماذا Windows Terminal نقلةٌ عن الكونسول القديم، وتضبط تبويباته وألواحه وملفّات تعريفه ومظهره ولوحة أوامره.],
  [تقرأ ملفّ الإعداد `settings.json` وتعدّله بثقة، وتعرف بنيته واختصاراته.],
  [تبني بيئة PowerShell دائمةً في `$PROFILE`: على مستوياته، بمحثٍّ مخصّصٍ ودوالَّ وخيارات.],
  [تعمّق تحكّمك بـPSReadLine: الأنماط، والألوان، والإكمال التنبّئيّ ومصدره، واختصاراتٍ تصنعها بنفسك.],
  [تركّب أدواتٍ حديثةً — oh-my-posh وzoxide وfzf وTerminal-Icons — وتحفظ إعداداتك كلَّها في مستودع Git.],
))

الحِرفيُّ الماهر لا يُعرَف بعُدّته وحدها، بل بترتيب عُدّته. اجلس إلى منضدة نجّارٍ متمرّس تجدْ كلَّ إزميلٍ في محجره، والمنشارَ حيث تصل إليه اليد دون أن تبحث العين. أمّا المبتدئ فيعمل على منضدةٍ مستعارةٍ يفتّش فيها عن كلّ أداة، فيضيع في التفتيش نصفَ وقته. الطرفيّة التي تعلّمتَ فيها حتى الآن كانت منضدةً مستعارة: نافذةٌ افتراضيّةٌ لم تمسسها يدك. في هذا الفصل تبني منضدتك أنت — تختار نافذتها، وترتّب أدواتها، وتصوغ محثَّها، وتضيف إليها العُدّة الحديثة — ثمّ تحفظ ترتيبها كلَّه في دفترٍ تستعيده على أيّ جهازٍ في دقائق. غايتنا أن تنتقل الطرفيّة من *نافذةٍ عابرة* إلى *بيئة عملٍ* على مقاسك.

#section[Windows Terminal: النافذة التي تؤثّثها]

ميّزنا منذ أوّل الكتاب بين *الصدفة* التي تفهم أوامرك *والطرفيّة* التي تعرضها، وعرفتَ في فصل العربية في Windows Terminal لماذا هجرنا الكونسول القديم (`conhost`) إلى Windows Terminal: نافذةٌ حديثةٌ أطلقتها مايكروسوفت سنة 2019 مفتوحةَ المصدر، تُصيّر النصَّ ببطاقة الرسوم وتفهم يونيكود أصالة. هناك كان همُّنا أن تظهر العربيّة سليمة؛ وهنا همُّنا أبعد: أن تصير هذه النافذة *ورشةً* كاملة.

الكونسول القديم يعطيك نافذةً واحدةً لصدفةٍ واحدة. Windows Terminal يعطيك نافذةً تحتضن *كلَّ* صدفك في تبويباتٍ وألواح، ويحفظ ذوقك كلَّه في ملفِّ إعدادٍ واحد. هذا هو الفرق العمليّ: لا أن الحروف أجمل فحسب، بل إنّ النافذة صارت قابلةً للتأثيث.

#subsection[تبويباتٌ وألواح]

التبويب (Tab) صدفةٌ كاملةٌ في لسانٍ مستقلّ، تفتح منها ما شئت وتتنقّل بينها كألسنة المتصفّح. واللوحة أدقّ منه.

#define("اللوحة (Pane)", [
  تقسيمٌ داخل التبويب الواحد يضع صدفتين أو أكثرَ جنبًا إلى جنبٍ في الشاشة نفسها. فتحرّر ملفًّا في لوحةٍ يسارًا، وتراقب ناتجًا يجري في لوحةٍ يمينًا، دون أن تغادر التبويب. التبويبُ نافذةٌ داخل النافذة، واللوحةُ قسمةٌ داخل التبويب.
])

الاختصارات هي مفتاح السرعة، وهذه أهمُّها في Windows Terminal:

```text
Ctrl+Shift+T       تبويب جديد
Ctrl+Tab           تنقّل بين التبويبات
Ctrl+Shift+W       أغلق التبويب أو اللوحة الحاليّة
Alt+Shift+D        اقسم اللوحة الحاليّة تلقائيًّا
Alt+Shift+-        اقسم أفقيًّا (أعلى/أسفل)
Alt+Shift+=        اقسم رأسيًّا (يمين/يسار)
Alt+الأسهم         انقل التركيز بين اللوحات
Ctrl+Shift+رقم     افتح تبويبًا بملفّ التعريف رقم كذا
```

#subsection[ملفّات التعريف: صدفةٌ لكلّ ممرّ]

في Windows Terminal لكلّ صدفةٍ *ملفُّ تعريف* مستقلّ: مدخلٌ يصف كيف تُفتَح ومظهرَها.

#define("ملفّ التعريف في Windows Terminal (Profile)", [
  إعدادٌ يصف صدفةً بعينها كما تفتحها النافذة: أمرَ تشغيلها، ومجلّدَ بدئها، وأيقونتها، ومخطّط ألوانها. للنافذة قائمةٌ منسدلةٌ (سهمٌ بجانب زرّ التبويب) تعرض ملفّات تعريفك كلَّها لتختار منها.
])

عند أوّل تشغيل يكتشف Windows Terminal ما لديك من صدف ويصنع لكلٍّ ملفَّ تعريف: *موجّه الأوامر* (CMD)، *وWindows PowerShell 5.1*، *وPowerShell 7* (`pwsh`) إن ثبّتَّه، *وWSL* لكلّ توزيعة لِينُكس ركّبتها، بل *Azure Cloud Shell* للعمل السحابيّ. تختار أيَّها هو *الافتراضيّ* (الذي يفتح مع النافذة)، وتفتح البقيّة من القائمة المنسدلة أو باختصارها.

#note[
  لا تخلط بين اسمين متشابهين يجتمعان في هذا الفصل: *ملفّ التعريف في Windows Terminal* (Profile) مدخلٌ في `settings.json` يصف كيف *تفتح النافذةُ* صدفةً؛ *وملفّ تعريف PowerShell* (`$PROFILE`) الذي عرفتَه في فصل الطلاقة في الطرفية سكربتٌ *تقرؤه الصدفةُ* عند بدئها. الأوّل شأنُ النافذة، والثاني شأنُ الصدفة، وسنبني الثاني بعد قليل.
]

#subsection[المظهر ولوحة الأوامر]

الجمال هنا ليس ترفًا؛ العينُ التي تريح تعمل أطول. يمنحك Windows Terminal ثلاث طبقاتٍ للمظهر: *مخطّطات الألوان* (Color Schemes) الجاهزة مثل «Campbell» و«One Half Dark» و«Solarized»، *والخطّ* (يأتي بخطّ «Cascadia Code» المصمَّم للطرفيّة، وستحتاج نسخته «Nerd Font» ذاتَ الرموز حين نصل إلى المحثّ الغنيّ)، *والشفافيّة* عبر خاصّيّتَي `opacity` و`useAcrylic` اللتين تجعلان خلفيّة النافذة تشِفُّ عمّا تحتها.

ولإدارة كلّ هذا دون حفظ أسماء الأوامر، هناك *لوحة الأوامر* (Command Palette): اضغط #kbd("Ctrl+Shift+P") فتنسدل قائمةٌ ببحثٍ ضبابيٍّ (fuzzy) على كلّ فعلٍ تعرفه النافذة — تقسيم لوحة، تبديل مخطّط، فتح إعدادات — تكتب حرفين فيقفز إليك مرادك. هي نظير «قوائم الأوامر» في المحرّرات الحديثة، ومنجاةٌ لمن لا يحفظ الاختصارات.

#subsection[settings.json: الإعداد نصًّا]

كلُّ ما سبق يسكن في ملفٍّ واحدٍ بصيغة JSON. افتح إعدادات النافذة الرسوميّة بـ#kbd("Ctrl+,")، أو افتح الملفَّ النصّيّ مباشرةً بـ#kbd("Ctrl+Shift+,"). بنيته طبقاتٌ معدودة:

```json
{
    "defaultProfile": "{574e775e-4f2a-5b96-ac1e-a2962a402336}",
    "profiles": {
        "defaults": {
            "font": { "face": "Cascadia Code", "size": 12 },
            "opacity": 90,
            "useAcrylic": true
        },
        "list": [
            {
                "name": "PowerShell",
                "commandline": "pwsh.exe",
                "colorScheme": "One Half Dark",
                "startingDirectory": "%USERPROFILE%"
            }
        ]
    },
    "schemes": [],
    "actions": [
        { "command": { "action": "splitPane", "split": "auto" }, "keys": "alt+shift+d" }
    ]
}
```

اقرأها من أعلى: `defaultProfile` يحمل مُعرِّف ملفّ التعريف الذي يفتح مع النافذة. وتحت `profiles` قسمان: `defaults` تسري إعداداته على *كلّ* ملفّات التعريف (فتضبط الخطَّ مرّةً للجميع)، و`list` مصفوفةُ ملفّاتك واحدًا واحدًا. و`schemes` مخطّطات الألوان، و`actions` ارتباطات المفاتيح بالأفعال. تعديلُ الملفّ يأخذ مفعوله فورَ الحفظ.

#tip[
  حرّر `settings.json` بمحرّرٍ يفهم JSON مثل «VS Code»، فيلوّن الأقواس ويحذّرك من فاصلةٍ ناقصة. أكثرُ الأعطال شيوعًا فاصلةٌ زائدةٌ بعد آخر عنصرٍ في قائمة، أو قوسٌ لم يُغلَق — وهي أخطاء الصياغة نفسها التي رأيتَها في بيانات JSON عبر الشبكة.
]

#try-it[
  افتح Windows Terminal واقسم تبويبك بـ#kbd("Alt+Shift+D") فتصير لوحتين، ثمّ افتح تبويبًا ثانيًا بملفِّ تعريفٍ مختلفٍ من القائمة المنسدلة. جرّب #kbd("Ctrl+Shift+P") وابحث عن «split». أخيرًا افتح `settings.json` بـ#kbd("Ctrl+Shift+,")، وغيّر `opacity` إلى `80`، واحفظ: هل شفَّت النافذة فورًا؟
]

#distro[
  Windows Terminal حصريٌّ لويندوز. نظيره على ماك محاكياتٌ كـTerminal الرسميّ أو iTerm2، وعلى لِينُكس GNOME Terminal وKonsole أو الحديثة السريعة Alacritty وkitty. أمّا تقسيم اللوحات الذي يحيا بعد إغلاق النافذة ويعبر اتّصال SSH فتقدّمه هناك أداةٌ مستقلّةٌ اسمها tmux (مضاعِف الطرفيّة)؛ ولوحات Windows Terminal — كلوحات iTerm2 — محليّةٌ تموت بإغلاق التبويب. الفكرة واحدة، وإن اختلفت الأدوات.
]

#section[`$PROFILE`: بيئتك الدائمة على مستويات]

عرفتَ في فصل الطلاقة في الطرفية أنّ `$PROFILE` سكربتٌ يقرؤه PowerShell عند بدء كلّ جلسة، فتضع فيه أسماءك المستعارة ودوالَّك ليبقين بعد الإغلاق. الآن نبني عليه بيئةً ناضجة، ونكشف سرًّا لم يُذكر هناك: `$PROFILE` ليس ملفًّا واحدًا، بل *أربعة* على مستويين.

المستوى الأوّل *من يخصّه*: ملفٌّ لك وحدك في مجلّد مستنداتك، وملفٌّ لكلّ المستخدمين في مجلّد النظام (يحتاج تعديلُه صلاحيّة مسؤول). والمستوى الثاني *أيُّ مضيفٍ يقرؤه*: فـPowerShell قد يعمل داخل مضيفاتٍ شتّى — نافذة الطرفيّة، أو محرّر «VS Code»، أو بيئة ISE القديمة — ولك أن تخصّص ملفًّا لكلّ مضيفٍ أو ملفًّا يعمّها كلَّها. تسرد الأربعة بخصائص المتغيّر:

#session("$PROFILE | Format-List * -Force", prompt: "PS C:\\>", output: "AllUsersAllHosts       : C:\\Program Files\\PowerShell\\7\\profile.ps1
AllUsersCurrentHost    : C:\\Program Files\\PowerShell\\7\\Microsoft.PowerShell_profile.ps1
CurrentUserAllHosts    : C:\\Users\\Ahmad\\Documents\\PowerShell\\profile.ps1
CurrentUserCurrentHost : C:\\Users\\Ahmad\\Documents\\PowerShell\\Microsoft.PowerShell_profile.ps1")

حين تكتب `$PROFILE` وحده تحصل على `CurrentUserCurrentHost`: ملفُّك أنت في مضيفك الحاليّ، وهو الذي تريد تسعةً وتسعين في المئة من الوقت. ضع فيه ما يخصّك أنت في النافذة. وإن أردتَ ضبطًا يسري في «VS Code» والنافذة معًا، فاكتبه في `CurrentUserAllHosts` (`$PROFILE.CurrentUserAllHosts`).

ملفٌّ ناضجٌ يجمع عادةً هذه الأصناف: أسماءً مستعارةً ودوالَّ اختصار، وخيارات PSReadLine التي سنعمّقها، ومحثًّا مخصّصًا، وسطورَ تشغيلٍ لأدواتك الحديثة:

```powershell
# ~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
Set-Alias g git                                  # اسم مستعار سريع
function gs { git status @args }                 # دالّة اختصار
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Import-Module Terminal-Icons                      # عُدّة حديثة (بعد قليل)
oh-my-posh init pwsh | Invoke-Expression          # محثّ غنيّ (بعد قليل)
```

#warn[
  كلُّ سطرٍ في `$PROFILE` يُنفَّذ عند *كلّ* فتح نافذة، فإثقالُه يُبطئ بدءك. إن لاحظتَ تأخّرًا، قِس زمن البدء بـ`Measure-Command { pwsh -NoProfile -Command "" }` مقابلَه بلا `-NoProfile`، واحذف ما لا تحتاج. الأناقة أن يبقى ملفُّك خفيفًا سريعًا.
]

#try-it[
  اطبع مساراتك الأربعة بـ`$PROFILE | Format-List * -Force`، وميّز `CurrentUserCurrentHost`. افتحه بـ`notepad $PROFILE` (أنشئه إن سألك)، وأضِف سطرًا واحدًا: `Set-Alias np notepad`. أغلق النافذة وافتح جديدةً وجرّب `np`: هل بقي اسمُك المستعار؟
]

#section[المحثّ المخصّص: دالّة prompt وoh-my-posh]

المحثّ (`PS C:\>`) ليس ثابتًا مقدّسًا، بل ناتجُ دالّةٍ اسمها `prompt` يستدعيها PowerShell قبل كلّ سطرٍ تكتبه. غيّرها، يتغيّر محثُّك. انظر إلى تعريفها الافتراضيّ:

#session("(Get-Command prompt).Definition", prompt: "PS C:\\>", output: "\"PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) \";")

هي سلسلةٌ نصّيّةٌ تُرجِعها الدالّة: الحرفان `PS`، ثمّ موقعك الحاليّ، ثمّ محرف `>`. أعِد تعريفها بما تشاء، فتصير المخرجات محثَّك:

```powershell
function prompt {
    $leaf = Split-Path -Leaf (Get-Location)   # اسم المجلّد الحاليّ فقط
    $t = (Get-Date).ToString("HH:mm")         # الوقت
    "[$t] $leaf> "
}
```

فيصير محثُّك سطرًا يعرض الوقتَ واسمَ المجلّد وحده بدل المسار الطويل:

```text
[09:41] Projects>
```

هذه البداية. لكنّ صياغة محثٍّ يعرض فرعَ Git وحالته ولونًا للنجاح والفشل تطول وتتعب. لهذا وُجدت أداةٌ تصنعه لك.

#subsection[oh-my-posh: محثٌّ غنيٌّ بلا عناء]

#define("oh-my-posh", [
  محرّكُ محثٍّ عابرُ المنصّات يصوغ لك محثًّا غنيًّا بالمعلومات — فرعُ Git، وبيئةُ بايثون، ورمزُ النجاح أو الفشل، والوقت — من «سماتٍ» جاهزةٍ تختار منها. يعمل على PowerShell وBash وZsh، على ويندوز وماك ولِينُكس.
])

تثبّته بمدير الحزم winget الذي عرفتَه في فصل مديري الحزم، ثمّ تشغّله من `$PROFILE`:

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget   # في موجّه أوامرٍ عاديّ
```

ثمّ أضِف إلى `$PROFILE` سطرَ التهيئة، الذي يولّد إعداد المحثّ ويمرّره إلى `Invoke-Expression` لينفّذه في جلستك:

```powershell
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" |
    Invoke-Expression
```

تستعرض السماتِ الجاهزةَ بـ`Get-PoshThemes`، وتبدّل `--config` إلى ما يعجبك. شرطٌ واحدٌ للجمال الكامل: اضبط خطَّ Windows Terminal على نسخة «Nerd Font» (كـ«CaskaydiaCove Nerd Font»)، وإلّا ظهرت الرموزُ مربّعاتٍ فارغة — فالرموز الغنيّة تحتاج خطًّا يحملها.

#distro[
  على ماك ولِينُكس مع صدفة zsh، أشهرُ نظير oh-my-posh إطارُ «oh-my-zsh» مع سمةٍ غنيّةٍ كـ«powerlevel10k». وثمّة أداةٌ عابرةٌ ثالثةٌ اسمها «starship» تعمل على الصدفات كلّها بملفّ إعدادٍ واحد. الفكرة نفسها في الأنظمة الثلاثة: محثٌّ يخبرك بحالة مشروعك دون أن تسأل.
]

#try-it[
  ثبّت oh-my-posh بـwinget، وأضِف سطرَ `init` إلى `$PROFILE`، واضبط خطَّ النافذة على «Nerd Font». افتح نافذةً جديدةً وادخل مستودعَ Git: هل ظهر اسمُ الفرع في المحثّ؟ استعرض السمات بـ`Get-PoshThemes` واختر واحدةً تعجبك.
]

#section[PSReadLine بعمق]

لمستَ PSReadLine في فصل الطلاقة في الطرفية: عرفتَ أنّها تلوّن أوامرك، وتبحث في تاريخك بـ#kbd("Ctrl+R")، وتقترح عليك بالإكمال التنبّئيّ. ذلك كان استعمالَها الجاهز؛ وهنا نفتح صندوق ضبطها. كلُّ خياراتها تُقرأ بأمرٍ واحد:

#session("Get-PSReadLineOption | Select-Object EditMode, PredictionSource, PredictionViewStyle, HistoryNoDuplicates", prompt: "PS C:\\>", output: "EditMode            : Windows
PredictionSource    : HistoryAndPlugin
PredictionViewStyle : InlineView
HistoryNoDuplicates : True")

#subsection[الأنماط: Windows وEmacs وVi]

نمطُ التحرير (EditMode) يقرّر ماذا يفعل كلُّ مفتاح. تقبل ثلاثةً بأعيانها:

#session("[System.Enum]::GetNames([Microsoft.PowerShell.EditMode])", prompt: "PS C:\\>", output: "Windows
Emacs
Vi")

الافتراض على ويندوز `Windows` (وعلى ماك ولِينُكس `Emacs`). نمطُ `Vi` يمنحك وضعَي المحرّر الأسطوريّ: وضعُ إدراجٍ للكتابة، ووضعُ أوامرَ للتنقّل بحروف `h j k l`. من ألِف Vim يجده في متناول يده. بدّل النمط بسطر:

```powershell
Set-PSReadLineOption -EditMode Vi
```

#warn[
  اختصارات التحرير تتبع النمط. في نمط `Windows` مثلًا #kbd("Ctrl+A") يحدّد السطر كلَّه (SelectAll)، بينما في نمط `Emacs` يقفز إلى أوّل السطر (BeginningOfLine) — وهو سلوك صدفات يونِكس الذي رأيتَه في فصل الطلاقة. فإن اختلف مفتاحٌ عمّا تتوقّع، فسبب الاختلاف نمطُك.
]

#subsection[الألوان: لوّن أوامرك كما تحبّ]

PSReadLine تلوّن ما تكتبه وأنت تكتبه: أمرًا، ومعطًى، وسلسلةً، وتعليقًا، وخطأً. كلُّ عنصرٍ له لونٌ تغيّره بـ`Set-PSReadLineOption -Colors`، وتمرّر جدولًا يربط اسمَ العنصر بلونه (اسمًا أو رمز ANSI):

```powershell
Set-PSReadLineOption -Colors @{
    Command   = "Yellow"      # الأوامر
    Parameter = "DarkGray"    # المعطيات
    String    = "Cyan"        # السلاسل النصّيّة
    Comment   = "Green"       # التعليقات
    Error     = "Red"         # الأخطاء
}
```

ضع ما يريحك في `$PROFILE` ليدوم. اللون هنا وظيفةٌ لا زينة: العينُ تميّز الأمرَ من معطاه من خطئه قبل أن يعمل العقل، فتلتقط الغلط قبل #kbd("Enter").

#subsection[الإكمال التنبّئيّ ومصدره]

الاقتراحُ الباهت الذي يظهر بعد مؤشّرك — الذي عرفتَه هناك — يأتي من *مصدر* تختاره. المصادر أربعة:

#session("[System.Enum]::GetNames([Microsoft.PowerShell.PredictionSource])", prompt: "PS C:\\>", output: "None
History
Plugin
HistoryAndPlugin")

`History` يقترح من تاريخ أوامرك أنت. و`Plugin` يقترح من *إضافاتٍ ذكيّة* — وحداتٌ تركّبها تفهم سياقك، كوحدة «CompletionPredictor» أو «Az.Tools.Predictor» لأوامر أزور. و`HistoryAndPlugin` يجمع بينهما، وهو الافتراض في PowerShell 7 الحديث. للاقتراح شكلان تبدّل بينهما بـ#kbd("F2"): سطريٌّ (`InlineView`) بعد المؤشّر، وقائميٌّ (`ListView`) يعرض عدّة اقتراحاتٍ تحتك تختار منها بالأسهم:

```powershell
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
```

#note[
  هذا فرقٌ جوهريٌّ بين الصدفتين: PowerShell 7 (`pwsh`) يأتي بـPSReadLine حديثةٍ مصدرُها الافتراضيّ `HistoryAndPlugin`. أمّا Windows PowerShell 5.1 المدمج (`powershell.exe`) فبنسخةٍ أقدمَ مصدرُها `None`، فلا اقتراحَ حتى تشغّله بنفسك، وقد تحتاج تحديثَها بـ`Install-Module PSReadLine`. لتجربةٍ كاملةٍ، اعمل في PowerShell 7.
]

#subsection[اختصاراتٌ تصنعها بنفسك]

لكلّ مفتاحٍ *وظيفةٌ* مربوطةٌ به، تسردها كلَّها بـ`Get-PSReadLineKeyHandler`. هذه عيّنةٌ في نمط ويندوز:

#session("Get-PSReadLineKeyHandler -Bound | Select-Object Key, Function", prompt: "PS C:\\>", output: "Key            Function
---            --------
Tab            TabCompleteNext
Shift+Tab      TabCompletePrevious
Ctrl+r         ReverseSearchHistory
Ctrl+Backspace BackwardKillWord
Alt+d          KillWord
F2             SwitchPredictionView")

تربط أنت مفتاحًا بوظيفةٍ جاهزةٍ بـ`Set-PSReadLineKeyHandler`، أو — وهذا الأقوى — بكتلة أوامرَ تكتبها. لنربط #kbd("Ctrl+J") بإدراج تاريخ اليوم:

```powershell
Set-PSReadLineKeyHandler -Chord "Ctrl+j" -BriefDescription InsertDate `
  -Description "أدرج تاريخ اليوم" -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert((Get-Date -Format "yyyy-MM-dd"))
}
```

يؤكّد الربطَ سؤالُ PSReadLine عنه:

#session("Get-PSReadLineKeyHandler -Bound | Where-Object Key -eq 'Ctrl+j'", prompt: "PS C:\\>", output: "Key      Function    Description
---      --------    -----------
Ctrl+j   InsertDate  أدرج تاريخ اليوم")

من الآن تُدرج ضغطةٌ واحدةٌ تاريخَ اليوم في سطرك. ضع ربطك في `$PROFILE` ليصير جزءًا من ورشتك الدائمة.

#try-it[
  في PowerShell 7 بدّل نمطك بـ`Set-PSReadLineOption -EditMode Emacs` وجرّب #kbd("Ctrl+A"): إلى أين قفز المؤشّر؟ ثمّ حوّل الاقتراح قائميًّا بـ`Set-PSReadLineOption -PredictionViewStyle ListView` وابدأ كتابة أمرٍ نفّذتَه قبلُ. أخيرًا اربط #kbd("Ctrl+J") بإدراج التاريخ كما في المثال، واضغطه في سطرٍ فارغ.
]

#section[أدواتٌ حديثة تُكمّل الورشة]

بعد النافذة والمحثّ، بقيت عُدّةٌ صغيرةٌ عابرةُ المنصّات ترفع إنتاجيّتك رفعًا محسوسًا. كلُّها تُثبَّت بـwinget أو بمعرض PowerShell، وتُشغَّل من `$PROFILE`.

*التنقّل الذكيّ — zoxide*: بدل أن تكتب مساراتٍ طويلةً في `cd`، يتعلّم `zoxide` المجلّداتِ التي تزورها، فتقفز إليها باسمٍ جزئيّ. تكتب `z proj` فيذهب بك إلى مشروعك أيًّا كان مكانه:

```powershell
winget install ajeetdsouza.zoxide
# ثمّ في $PROFILE:
Invoke-Expression (& { (zoxide init powershell | Out-String) })
```

*البحث الضبابيّ — fzf*: أداةٌ تبحث ضبابيًّا في أيّ قائمة — ملفّاتك، تاريخك — فتجد مرادك بحروفٍ متفرّقة. توصلها بـPowerShell بوحدة «PSFzf» التي تخطف #kbd("Ctrl+R") لبحثٍ أجملَ في التاريخ، و#kbd("Ctrl+T") لانتقاء ملفّ:

```powershell
winget install junegunn.fzf
Install-Module PSFzf -Scope CurrentUser
# ثمّ في $PROFILE:
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
```

*أيقوناتٌ للملفّات — Terminal-Icons*: وحدةٌ تضيف رمزًا مميّزًا لكلّ نوع ملفٍّ في ناتج `Get-ChildItem`، فتقرأ مجلّدك بلمحة بصر (وتحتاج «Nerd Font» أيضًا):

```powershell
Install-Module Terminal-Icons -Scope CurrentUser
# ثمّ في $PROFILE:
Import-Module Terminal-Icons
```

#distro[
  هذه العُدّة يونِكسيّةُ المولد وتعمل على الأنظمة كلّها. `fzf` هي هي على ماك ولِينُكس (تثبّتها بـHomebrew أو `apt`)، و`zoxide` نظيرٌ حديثٌ لأداتَي `z` و`autojump` العريقتين في bash وzsh، و«Terminal-Icons» نظيرُ ملحقاتِ الأيقونات في oh-my-zsh. تكتب الأوامرَ نفسها، ويتبدّل سطرُ التهيئة بحسب صدفتك.
]

#try-it[
  ثبّت `zoxide` وأضِف سطرَ تهيئته إلى `$PROFILE`. افتح نافذةً جديدةً، وزُر مجلّدين أو ثلاثةً بـ`cd`، ثمّ اقفز إلى أحدها باسمٍ جزئيّ: `z` متبوعةً بأوّل حروفه. هل تعرّف على وجهتك؟
]

#section[ملفّات النقطة على ويندوز بـGit]

انظر إلى ما صنعتَ: `settings.json` للنافذة، و`$PROFILE` للصدفة، و`.gitconfig` لهُويّتك في Git. هذه *ملفّات النقطة*، وهي بصمة بيئتك كلّها.

#define("ملفّات النقطة (Dotfiles)", [
  ملفّات الإعداد التي تحمل شخصيّة بيئتك: صدفتَك، ومحرّرك، وأدواتك. الاسمُ اصطلاحٌ يونِكسيٌّ لأنّ أسماءها تبدأ هناك بنقطة `.` فتُخفى. على ويندوز لا تبدأ كلُّها بنقطةٍ ولا تسكن مكانًا واحدًا، لكنّ الفكرة نفسها: مجموعةٌ من الملفّات إن حفظتَها استعدتَ بيئتك بأكملها.
])

المشكلة أنّها موزّعةٌ في جهازك: `$PROFILE` في `Documents\PowerShell`، و`settings.json` عميقًا في `AppData`. فإذا أعدتَ تثبيت النظام ضاعت، وبدأتَ من الصفر. الحلُّ الأنيق أن تجمعها في مستودع Git واحد — تذكّر من فصل Git من الطرفية أنّ المستودع مجلّدٌ يتتبّع تاريخ تغييراته — ثمّ ترفعه إلى منصّةٍ كـGitHub، فيصير ضبطك محفوظًا مؤرَّخًا قابلًا للاستعادة.

الطريقة: انقل ملفّاتك الحقيقيّة إلى مجلّدٍ واحدٍ (`~\dotfiles`) يتتبّعه Git، واترك في أماكنها الأصليّة *وصلاتٍ رمزيّة* تشير إليها، فيرى كلُّ برنامجٍ ملفَّه في مكانه بينما الأصلُ محفوظٌ في مستودعك.

#define("الوصلة الرمزيّة (Symbolic link)", [
  ملفٌّ صغيرٌ لا يحوي بياناتٍ بل *عنوانَ* ملفٍّ آخر، فيتصرّف كاختصارٍ شفّاف: حين يفتحه برنامجٌ يفتح في الحقيقة الملفَّ الذي يشير إليه. تُنشئها على ويندوز بالأمر `New-Item -ItemType SymbolicLink`.
])

```powershell
mkdir ~\dotfiles
Move-Item $PROFILE ~\dotfiles\Microsoft.PowerShell_profile.ps1
New-Item -ItemType SymbolicLink -Path $PROFILE `
    -Target ~\dotfiles\Microsoft.PowerShell_profile.ps1
cd ~\dotfiles; git init; git add .; git commit -m "أول إعداداتي"
```

#warn[
  إنشاء الوصلات الرمزيّة على ويندوز يتطلّب صلاحيّة، فإمّا تشغّل PowerShell «كمسؤول»، وإمّا — والأيسر للمطوّر — تفعّل *وضع المطوّر* (Developer Mode) من إعدادات ويندوز، فيسمح بها دون رفع صلاحيّة كلَّ مرّة.
]

#danger[
  الرايةُ `-Force` مع `New-Item` تدهس أيَّ ملفٍّ في مكان الوصلة *بلا تحذير*. لا تربط وصلةً فوق ملفّ إعدادٍ حقيقيٍّ قبل أن تنقله أو تنسخ منه احتياطيًّا، وإلّا فقدتَ ضبطك الأصليّ. وبالأولى: لا تجرّب حذفًا جارفًا قربَ مجلّد منزلك.
]

على جهازٍ جديدٍ تصير الاستعادة خطوتين: استنسِخ المستودع، ثمّ أعِد الوصلات. ويكتب الناس عادةً سكربتًا صغيرًا (`setup.ps1`) يعيد كلَّ الوصلات دفعةً واحدة، فتُستعاد بيئتك كاملةً بأمرٍ واحد.

#deep[
  ثمّة أسلوبٌ أرقى يستغني عن الوصلات: مستودعٌ «عارٍ» (bare) شجرةُ عمله مجلّدُ المنزل مباشرة، تخاطبه باسمٍ مستعارٍ بدل `git`. يبقي ملفّاتك في أماكنها دون نقلٍ ولا وصلات، لكنّه يتطلّب حذرًا في تحديد ما يُتتبَّع. ابدأ بالوصلات، وانتقل إليه حين تكبر مجموعتك.
]

#try-it[
  أنشئ `~\dotfiles`، وانقل إليه `$PROFILE` واربطه بوصلةٍ كما في المثال (فعّل وضع المطوّر أوّلًا). تأكّد أنّ الوصلة تعمل بـ`Get-Item $PROFILE | Select-Object LinkType, Target`. ثمّ `git init` وأودِع أوّل لقطة، وأضِف إليها لاحقًا نسخةً من `settings.json`.
]

#section[خلاصة الفصل]

حوّلتَ الطرفيّة في هذا الفصل من نافذةٍ مستعارةٍ إلى ورشةٍ على مقاسك. رأيتَ كيف يرتقي *Windows Terminal* بالنافذة نفسها: تبويباتٌ وألواحُ وملفّاتُ تعريفٍ لكلّ صدفة، ومظهرٌ ولوحةُ أوامر، وكلُّ ذلك محفوظٌ نصًّا في `settings.json`. وبنيتَ بيئةً دائمةً في `$PROFILE` على مستوياته الأربعة، وصغتَ *محثًّا مخصّصًا* بدالّة `prompt` ثمّ بـoh-my-posh الغنيّ. وعمّقتَ *PSReadLine* وراء ما لمستَه: أنماطُها (Windows وEmacs وVi)، وألوانُها، ومصدرُ إكمالها التنبّئيّ (History وPlugin)، واختصاراتٌ تصنعها بـ`Set-PSReadLineKeyHandler`. وأضفتَ عُدّةً حديثةً — zoxide وfzf وTerminal-Icons — ثمّ جمعتَ *ملفّات النقطة* كلَّها في مستودع Git تستعيده على أيّ جهازٍ في دقائق عبر الوصلات الرمزيّة. صرتَ تصنع لنفسك ورشةً تنتقل معك أينما ذهبت.

بهذا نطوي مسار المطوّر، ونفتح جزء الأمن بما يسبق كلَّ أمرٍ تكتبه. في الفصل التالي — مبادئ الأمن وأخلاقياته وقانونه — نتعلّم كيف تفكّر في الخطر وتقيسه: مثلّثُ السرّيّة والسلامة والتوافر، ونمذجةُ تهديدك، وتقليصُ مساحة هجومك، وأين يقف الحدُّ الأخلاقيُّ والقانونيُّ الذي لا يُتخطّى — فلا تختبر إلّا ما تملك أو أُذن لك فيه كتابةً.

#challenge[
  ابنِ ورشتك الدائمة بيديك. (1) في Windows Terminal، افتح `settings.json`، واضبط خطًّا من نوع «Nerd Font» في `defaults`، واجعل `opacity` تسعين، ثمّ اقسم تبويبًا إلى ثلاث لوحاتٍ بـ#kbd("Alt+Shift+D") و#kbd("Alt+Shift+-"). (2) في `$PROFILE` لمستوى `CurrentUserCurrentHost`، اجمع أربعة أشياء: اسمًا مستعارًا، ودالّةً، وسطرَ `Set-PSReadLineOption -PredictionViewStyle ListView`، وارتباطَ #kbd("Ctrl+J") بإدراج التاريخ؛ ثمّ افتح نافذةً جديدةً وتحقّق أنّها كلَّها اشتغلت. (3) أنشئ مستودع dotfiles، وانقل إليه `$PROFILE` واربطه بوصلةٍ رمزيّة، وأودِع أوّل لقطة، وصف بجملةٍ كيف ستستعيده على جهازٍ جديد.
]
