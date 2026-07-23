#import "/lib/book.typ": appendix, section, subsection
#import "/lib/components.typ": note, tip, warn, distro
#import "/lib/theme.typ": SIZE

#appendix("أ", "جدول مقارنة ماك ولِينُكس وBSD")

ماك ولِينُكس وBSD ثلاثةُ إخوةٍ من أبٍ واحد هو يونِكس، فإن جلستَ أمام أيٍّ منها وجدتَ الصدفة نفسها والأوامر الأساسيّة نفسها: `cd` و`ls` و`grep` و`ssh`. لكنّ الإخوة يفترقون في التفاصيل الدقيقة؛ فأداةُ تثبيت البرامج تختلف، وطريقةُ إدارة الخدمات تختلف، بل إنّ أمرًا مألوفًا كـ `sed` قد يرفض عَلَمًا يعمل هنا ويأباه هناك. سببُ هذا الافتراق نسبٌ مزدوج: ماك وBSD يرثان أدواتهما من فرع BSD العريق، بينما لِينُكس يستعمل أدوات مشروع GNU؛ فأمرٌ واحدٌ بالاسم قد يكون برنامجين مختلفين في السلوك.

هذا الملحق بطاقةٌ مرجعيّةٌ تضع المهمّة الواحدة في صفٍّ، وتحتها الأمرُ المكافئ في كلّ نظام؛ ابحث عمّا تريد فعله في العمود الأيمن، ثم اقرأ الأمر تحت نظامك. حيثما ترى `PKG` فاستبدلها باسم البرنامج، و`NAME` باسم الخدمة، و`FILE` بالملفّ.

#note[
  عمودُ «ماك» يعني macOS، وأدواته البصمة الخاصّة (`brew`, `launchctl`, `pbcopy`, `open`) مع أساسٍ BSD مشترك. عمودُ «BSD» يشير إلى FreeBSD أساسًا (الأشهر خادميًّا)، ونشير إلى فروق OpenBSD عند الحاجة. عمودُ «لِينُكس» يفترض دبيان/أوبونتو ومعها أدوات GNU؛ المرجع الكامل للِينُكس هو الكتاب الأوّل من السلسلة.
]

#section[تثبيت الحزم وإدارتها]

لا يملك ماك مديرَ حزمٍ رسميًّا للبرامج الطرفيّة، فالمعيار العمليّ هو Homebrew (الأمر `brew`) وله ملحقٌ خاصٌّ في هذا الكتاب. أمّا BSD فله مدير حزمٍ أصيلٌ مدمج: `pkg` على FreeBSD، و`pkg_add` على OpenBSD.

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [ماك\ `brew`],
    [لِينُكس\ `apt`],
    [BSD\ `pkg`],

    [تحديث الفهرس],
    [`brew update`],
    [`apt update`],
    [`pkg update`],

    [ترقية كلّ البرامج],
    [`brew upgrade`],
    [`apt upgrade`],
    [`pkg upgrade`],

    [البحث عن حزمة],
    [`brew search PKG`],
    [`apt search PKG`],
    [`pkg search PKG`],

    [تثبيت حزمة],
    [`brew install PKG`],
    [`apt install PKG`],
    [`pkg install PKG`],

    [إزالة حزمة],
    [`brew uninstall PKG`],
    [`apt remove PKG`],
    [`pkg delete PKG`],

    [عرض المثبَّت],
    [`brew list`],
    [`apt list --installed`],
    [`pkg info`],

    [معلومات حزمة],
    [`brew info PKG`],
    [`apt show PKG`],
    [`pkg info PKG`],

    [إزالة اليتامى],
    [`brew autoremove`],
    [`apt autoremove`],
    [`pkg autoremove`],
  )
})

#distro[
  على OpenBSD مديرُ الحزم مختلفٌ في الأسماء: التثبيت `pkg_add PKG`، والإزالة `pkg_delete PKG`، والبحث `pkg_info -Q PKG`، والترقية `pkg_add -u`. وعلى فيدورا في عمود لِينُكس بدّل `apt` بـ `dnf`.
]

#section[إدارة الخدمات]

هنا يفترق الإخوة أكثر ما يفترقون؛ فلكلّ نظامٍ نظامُ إقلاعٍ وإدارة خدماتٍ مختلف تمامًا: ماك يستعمل launchd عبر `launchctl`، ولِينُكس الحديث يستعمل systemd عبر `systemctl`، وBSD يستعمل نظام rc.d عبر `service` وملفّ `/etc/rc.conf`.

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [ماك\ `launchd`],
    [لِينُكس\ `systemd`],
    [BSD\ `rc.d`],

    [تشغيل خدمة],
    [`launchctl start NAME`],
    [`systemctl start NAME`],
    [`service NAME start`],

    [إيقاف خدمة],
    [`launchctl stop NAME`],
    [`systemctl stop NAME`],
    [`service NAME stop`],

    [إعادة التشغيل],
    [`launchctl kickstart -k NAME`],
    [`systemctl restart NAME`],
    [`service NAME restart`],

    [تفعيل عند الإقلاع],
    [`launchctl enable NAME`],
    [`systemctl enable NAME`],
    [`sysrc NAME_enable=YES`],

    [تعطيل عند الإقلاع],
    [`launchctl disable NAME`],
    [`systemctl disable NAME`],
    [`sysrc NAME_enable=NO`],

    [حالة خدمة],
    [`launchctl print NAME`],
    [`systemctl status NAME`],
    [`service NAME status`],

    [سرد الخدمات],
    [`launchctl list`],
    [`systemctl list-units`],
    [`service -e`],
  )
})

#note[
  على ماك تُدار خدمات Homebrew بأمرٍ أبسط: `brew services start NAME` و`brew services list`؛ وهو غلافٌ مريحٌ فوق launchd للبرامج التي ثبّتّها بـ `brew`.
]

#distro[
  على OpenBSD الأداةُ `rcctl` تجمع كلّ ذلك: `rcctl start NAME` للتشغيل، و`rcctl enable NAME` للتفعيل عند الإقلاع، و`rcctl ls started` لسرد العاملة.
]

#warn[
  أسماء الخدمات لا تتطابق بين الأنظمة: خادم الويب Apache خدمتُه `httpd` على FreeBSD و`apache2` على دبيان و`org.apache.httpd` عبر launchd على ماك. تحقّق من الاسم الفعليّ قبل التشغيل.
]

#section[الشبكة]

الفرقُ الجوهريّ أنّ لِينُكس هجر أدوات BSD القديمة (`ifconfig`, `route`) إلى حزمة `iproute2` وأمرها الموحّد `ip`، بينما ماك وBSD ما زالا على `ifconfig` الكلاسيكيّ. ولماك زيادةً أداةٌ طرفيّةٌ خاصّةٌ اسمها `networksetup` تضبط من سطر الأوامر إعدادات الشبكة نفسها التي تضبطها لوحة الإعدادات الرسوميّة.

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [ماك],
    [لِينُكس\ `iproute2`],
    [BSD],

    [عرض الواجهات والعناوين],
    [`ifconfig`],
    [`ip addr`],
    [`ifconfig`],

    [عنوان واجهةٍ بعينها],
    [`ipconfig getifaddr en0`],
    [`ip addr show dev eth0`],
    [`ifconfig em0`],

    [جدول التوجيه],
    [`netstat -rn`],
    [`ip route`],
    [`netstat -rn`],

    [إضافة مسارٍ افتراضيّ],
    [`route add default GW`],
    [`ip route add default via GW`],
    [`route add default GW`],

    [تفعيل/تعطيل واجهة],
    [`ifconfig en0 up`],
    [`ip link set eth0 up`],
    [`ifconfig em0 up`],

    [المنافذ المفتوحة],
    [`lsof -i -P`],
    [`ss -tulpn`],
    [`sockstat -l`],

    [جدول ARP],
    [`arp -a`],
    [`ip neigh`],
    [`arp -a`],

    [استعلام DNS],
    [`dig NAME`],
    [`dig NAME`],
    [`dig NAME`],
  )
})

#note[
  أسماء الواجهات تختلف باختلاف النظام والعتاد: على ماك تكون `en0` (إيثرنت/واي‌فاي)، وعلى لِينُكس `eth0` أو أسماء ثابتة كـ `enp3s0`، وعلى FreeBSD اسمُ المُشغِّل نفسه مثل `em0` أو `re0`. استعرض واجهاتك أوّلًا قبل استعمال أيّ اسمٍ حرفيًّا.
]

#tip[
  الأمر `networksetup` خاصّ بماك ويقدّم ما لا تقدّمه الأدوات الكلاسيكيّة، مثل `networksetup -listallnetworkservices` لعرض خدمات الشبكة، و`networksetup -getdnsservers Wi-Fi` لقراءة خوادم DNS المضبوطة.
]

#section[الحافظة (Clipboard)]

لماك ميزةٌ لطيفة: أمران مدمجان `pbcopy` و`pbpaste` ينسخان من الطرفية ويلصقان إليها مباشرةً. لِينُكس وBSD يفتقران إلى مكافئٍ مدمج، فيعتمدان على أداةٍ خارجيّة تختلف باختلاف نظام العرض: `xclip` أو `xsel` تحت X11، و`wl-copy`/`wl-paste` تحت Wayland.

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [ماك],
    [لِينُكس (X11)],
    [BSD (X11)],

    [نسخُ ناتجٍ إلى الحافظة],
    [`... | pbcopy`],
    [`... | xclip -sel clip`],
    [`... | xclip -sel clip`],

    [لصقُ الحافظة إلى الطرفية],
    [`pbpaste`],
    [`xclip -sel clip -o`],
    [`xclip -sel clip -o`],

    [نسخ محتوى ملفّ],
    [`pbcopy < FILE`],
    [`xclip -sel clip < FILE`],
    [`xclip -sel clip < FILE`],
  )
})

#note[
  تحت Wayland على لِينُكس بدّل الأداة: `wl-copy` للنسخ و`wl-paste` للّصق، وكلاهما من حزمة `wl-clipboard`. وأداة `xsel` بديلٌ شائعٌ عن `xclip` بصيغة `xsel -b` للحافظة.
]

#section[فتح الملفّات والمجلّدات]

كلُّ نظامٍ يوفّر أمرًا يفتح ملفًّا أو مجلّدًا أو رابطًا بالتطبيق الافتراضيّ له تمامًا كالنقر المزدوج. على ماك الأمرُ `open` مدمجٌ وقويّ، وعلى لِينُكس وBSD المعيارُ هو `xdg-open` من حزمة `xdg-utils` التابعة لمواصفة freedesktop.

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [ماك],
    [لِينُكس],
    [BSD],

    [فتح ملفٍّ بتطبيقه الافتراضيّ],
    [`open FILE`],
    [`xdg-open FILE`],
    [`xdg-open FILE`],

    [فتح المجلّد الحاليّ],
    [`open .`],
    [`xdg-open .`],
    [`xdg-open .`],

    [فتح رابطٍ في المتصفّح],
    [`open URL`],
    [`xdg-open URL`],
    [`xdg-open URL`],

    [فتح بتطبيقٍ محدَّد],
    [`open -a AppName FILE`],
    [`gtk-launch AppName FILE`],
    [`—`],
  )
})

#note[
  الأمر `open` على ماك أغنى من نظرائه: `open -a "TextEdit" FILE` يفتح بتطبيقٍ باسمه، و`open -R FILE` يُظهر الملفّ محدَّدًا في Finder، و`open -e FILE` يفتحه في محرّر النصوص الافتراضيّ. لا مكافئ مباشر لهذه على `xdg-open`.
]

#section[الفروق الخفيّة: أوامرٌ متطابقةُ الاسم مختلفةُ السلوك]

أخطرُ ما في الانتقال بين الأنظمة ليس الأوامرَ المفقودة، بل الأوامر الموجودة باسمٍ واحدٍ وسلوكٍ مختلف. فماك وBSD يستعملان النسخة BSD من الأداة، ولِينُكس يستعمل نسخة GNU؛ وهذه أشهر ثلاثة مطبّاتٍ تُوقع المنتقلين.

#subsection[sed: التحرير في المكان يختلف جوهريًّا]

أشهرُ فخٍّ على الإطلاق هو `sed -i` (التعديل داخل الملفّ نفسه). نسخةُ GNU تقبل اللاحقة ملتصقةً بالعَلَم أو تقبله وحده بلا نسخةٍ احتياطيّة، أمّا نسخةُ BSD (ماك) فتُلزمك بمعامل اللاحقة دائمًا، ولو فارغًا `''`، وإلّا فسّرت الاسم التالي على أنّه لاحقة.

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [ماك / BSD],
    [لِينُكس (GNU)],

    [تعديلٌ في المكان بلا نسخة],
    [`sed -i '' 's/a/b/' FILE`],
    [`sed -i 's/a/b/' FILE`],

    [تعديلٌ مع نسخةٍ احتياطيّة],
    [`sed -i '.bak' 's/a/b/' FILE`],
    [`sed -i'.bak' 's/a/b/' FILE`],

    [التعابير المنتظمة الممتدّة],
    [`sed -E 's/(a)+/x/' FILE`],
    [`sed -E 's/(a)+/x/' FILE`],
  )
})

#warn[
  الأمر `sed -i 's/a/b/' FILE` (بلا `''`) يعمل على لِينُكس ويُفسِد الأمر على ماك: يظنّ `sed` أنّ نصّ الاستبدال هو لاحقةُ النسخة الاحتياطيّة، ثم يشكو من نقص المعاملات. على ماك اكتب `sed -i ''` دائمًا. لكتابة سكربتٍ محمولٍ بين النظامين، تجنّب `-i` تمامًا واكتب إلى ملفٍّ مؤقّتٍ ثم استبدل.
]

#note[
  للتوسّع (`\+`, `\?`, `\|`) نسخةُ GNU تفهمها بالتهريب في النمط الأساسيّ، وBSD لا تفهمها إلّا بعَلَم `-E`. العَلَمُ `-E` مدعومٌ في النظامين اليوم فاعتَدْه؛ أمّا `-r` القديم فحصريٌّ لـ GNU.
]

#subsection[ls: الألوان وحجومٌ بشريّة]

الفرقُ الأبرز في `ls` هو تفعيل الألوان: نسخةُ BSD (ماك) تستعمل العَلَم `-G` وتقرأ متغيّر البيئة `CLICOLOR`، ونسخةُ GNU تستعمل `--color=auto` وتقرأ `LS_COLORS`.

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [ماك / BSD],
    [لِينُكس (GNU)],

    [تلوين الخرج],
    [`ls -G`],
    [`ls --color=auto`],

    [متغيّر تفعيل الألوان],
    [`CLICOLOR=1`],
    [`LS_COLORS=...`],

    [أحجامٌ بشريّة],
    [`ls -lh`],
    [`ls -lh`],

    [الفرز حسب وقت التعديل],
    [`ls -lt`],
    [`ls -lt`],

    [عرضٌ طويلٌ لكلّ شيء],
    [`ls -la`],
    [`ls -la`],
  )
})

#tip[
  الأعلام الأساسيّة (`-l`, `-a`, `-h`, `-t`, `-R`, `-S`) متطابقةٌ في النظامين، فمعرفتك بها منقولةٌ كما هي. الاختلاف محصورٌ في التلوين وبعض الأعلام الطرفيّة كـ `-D` (تنسيق التاريخ) على BSD مقابل `--time-style` على GNU.
]

#subsection[date: الحساب والتنسيق يختلفان كليًّا]

أمرُ `date` من أشدّ الأوامر تباعدًا بين النسختين، خاصّةً في حساب تاريخٍ نسبيّ («قبل يومين») أو تحويل ختم الوقت (epoch). نسخةُ GNU تستعمل `-d` مع وصفٍ نصّيّ، ونسخةُ BSD (ماك) تستعمل `-v` للإزاحة و`-r` لختم الوقت و`-j -f` للتحليل.

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [ماك / BSD],
    [لِينُكس (GNU)],

    [التاريخ الآن بتنسيق],
    [`date +%Y-%m-%d`],
    [`date +%Y-%m-%d`],

    [قبل يومين من الآن],
    [`date -v -2d`],
    [`date -d '2 days ago'`],

    [بعد شهر],
    [`date -v +1m`],
    [`date -d '1 month'`],

    [تحويل ختم وقتٍ إلى تاريخ],
    [`date -r 1700000000`],
    [`date -d @1700000000`],

    [تحليل تاريخٍ إلى ختم وقت],
    [`date -j -f '%Y-%m-%d' 2020-01-01 +%s`],
    [`date -d 2020-01-01 +%s`],
  )
})

#warn[
  السكربت الذي يحسب تواريخ بـ `date -d '...'` سيفشل على ماك فورًا لأنّ نسخة BSD لا تعرف العَلَم `-d` بهذا المعنى. إن أردت سكربتًا محمولًا فثبّت أدوات GNU على ماك (`brew install coreutils`) واستعمل `gdate`، أو افحص النظام بـ `uname` واختر الصياغة المناسبة.
]

#note[
  رموزُ التنسيق نفسها (`%Y`, `%m`, `%d`, `%H`, `%M`, `%S`) متطابقةٌ في النظامين لأنّها من معيار C، فمخرجاتُ العرض متوافقة؛ الاختلافُ كلُّه في أعلام الحساب والإدخال لا في التنسيق.
]

#section[خلاصةٌ عمليّة]

القاعدةُ الذهبيّة للتنقّل بين الإخوة الثلاثة: ماك وBSD توأمان في الأدوات الأساسيّة (كلاهما BSD)، ولِينُكس هو المختلف (GNU). فإن أتقنتَ أمرًا على ماك فهو غالبًا يعمل كما هو على FreeBSD، والعكس صحيح؛ والحذرُ كلُّه عند العبور إلى لِينُكس أو منه. وإذا أردتَ سكربتًا يعمل في كلّ مكان، فإمّا أن تلتزم بالمقاطع المشتركة في معيار POSIX، وإمّا أن تثبّت أدوات GNU على ماك عبر `brew install coreutils gnu-sed` وتستعمل النسخ المسبوقة بحرف `g` مثل `gsed` و`gdate`، فتوحّد السلوك على منصّاتك كلّها.
