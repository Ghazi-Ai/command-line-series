#import "/lib/book.typ": appendix, section, subsection
#import "/lib/components.typ": note, tip, warn, distro
#import "/lib/theme.typ": SIZE

#appendix("أ", "جدول مقارنة BSD ولِينُكس")

BSD ولِينُكس أخوان من رحمِ يونِكس، فإن جلستَ أمام أيٍّ منهما وجدتَ الصدفةَ نفسها والأوامرَ الأساسيّة نفسها: `cd` و`ls` و`grep` و`ssh`. لكنّهما يفترقان في التفاصيل الدقيقة؛ فأداةُ تثبيت البرامج تختلف، وطريقةُ إدارة الخدمات تختلف، بل إنّ أمرًا مألوفًا كـ`sed` قد يقبل عَلَمًا هنا ويأباه هناك. وسببُ الافتراق نسبٌ مزدوج: BSD نظامٌ متكاملٌ يُبنى نواةً وأدواتٍ من مصدرٍ واحد، بينما لِينُكس نواةٌ وحدها تُلبَس أدواتِ مشروع GNU؛ فأمرٌ واحدٌ بالاسم قد يكون برنامجين مختلفين في السلوك.

هذا الملحق بطاقةٌ مرجعيّةٌ تضع المهمّة الواحدة في صفٍّ، وتحتها الأمرُ المكافئ في كلّ نظام؛ ابحث عمّا تريد فعله في العمود الأيمن، ثم اقرأ الأمر تحت نظامك. حيثما ترى `PKG` فاستبدلها باسم البرنامج، و`NAME` باسم الخدمة، و`FILE` بالملفّ.

#note[
  عمودُ «BSD» يشير إلى FreeBSD أساسًا (الأشهر خادميًّا)، ونشير إلى فروق OpenBSD وNetBSD عند الحاجة. عمودُ «لِينُكس» يفترض دبيان/أوبونتو ومعها أدوات GNU؛ والمرجعُ الكاملُ للِينُكس هو الكتاب الأوّل من هذه السلسلة. وماك أخٌ ثالثٌ يشبه BSD في أدواته الأساسيّة لاشتراكهما في أصل بِركلي.
]

#section[تثبيت الحزم وإدارتها]

لِينُكس وBSD كلاهما له مدير حزمٍ أصيلٌ مدمجٌ في النظام (بخلاف ماك). على FreeBSD الأمرُ `pkg`، وعلى دبيان `apt`؛ والفلسفةُ واحدةٌ وإن اختلفت الكلمات.

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [BSD\ `pkg`],
    [لِينُكس\ `apt`],

    [تحديث الفهرس], [`pkg update`], [`apt update`],
    [ترقية كلّ البرامج], [`pkg upgrade`], [`apt upgrade`],
    [البحث عن حزمة], [`pkg search PKG`], [`apt search PKG`],
    [تثبيت حزمة], [`pkg install PKG`], [`apt install PKG`],
    [إزالة حزمة], [`pkg delete PKG`], [`apt remove PKG`],
    [عرض المثبَّت], [`pkg info`], [`apt list --installed`],
    [معلومات حزمة], [`pkg info PKG`], [`apt show PKG`],
    [أيّ حزمةٍ تملك ملفًّا], [`pkg which FILE`], [`dpkg -S FILE`],
    [إزالة اليتامى], [`pkg autoremove`], [`apt autoremove`],
  )
})

#distro[
  على OpenBSD مديرُ الحزم مختلفٌ في الأسماء: التثبيت `pkg_add PKG`، والإزالة `pkg_delete PKG`، والبحث `pkg_info -Q PKG`، والترقية `pkg_add -u`. وعلى فيدورا في عمود لِينُكس بدّل `apt` بـ`dnf`.
]

#section[إدارة الخدمات والإقلاع]

هنا يفترق الأخوان أكثرَ ما يفترقان؛ فلِينُكس الحديثُ يستعمل systemd عبر `systemctl`، وBSD يستعمل نظام rc.d العريق عبر `service` وملفِّ `/etc/rc.conf` (يُحرَّر بأمانٍ بالأداة `sysrc`).

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [BSD\ `rc.d`],
    [لِينُكس\ `systemd`],

    [تشغيل خدمة], [`service NAME start`], [`systemctl start NAME`],
    [إيقاف خدمة], [`service NAME stop`], [`systemctl stop NAME`],
    [إعادة التشغيل], [`service NAME restart`], [`systemctl restart NAME`],
    [تفعيل عند الإقلاع], [`sysrc NAME_enable=YES`], [`systemctl enable NAME`],
    [تعطيل عند الإقلاع], [`sysrc NAME_enable=NO`], [`systemctl disable NAME`],
    [حالة خدمة], [`service NAME status`], [`systemctl status NAME`],
    [سرد الخدمات المفعّلة], [`service -e`], [`systemctl list-units`],
    [سجلّ النظام], [`less /var/log/messages`], [`journalctl`],
  )
})

#distro[
  على OpenBSD الأداةُ `rcctl` تجمع كلّ ذلك في مكانٍ واحد: `rcctl start NAME` للتشغيل، و`rcctl enable NAME` للتفعيل عند الإقلاع، و`rcctl ls started` لسرد العاملة.
]

#warn[
  أسماء الخدمات لا تتطابق بين النظامين: خادم الويب Apache خدمتُه `apache24` على FreeBSD و`apache2` على دبيان. وسجلُّ النظام في BSD ملفّاتٌ نصّيّةٌ في `/var/log` تقرؤها بـ`less` و`grep`، بينما جمعه systemd في سجلٍّ ثنائيٍّ لا يُقرأ إلّا بـ`journalctl`.
]

#section[الشبكة]

الفرقُ الجوهريّ أنّ لِينُكس هجر أدوات BSD العريقة (`ifconfig`, `route`, `netstat`) إلى حزمة `iproute2` وأمرها الموحّد `ip`، بينما بقيَ BSD على الكلاسيكيّات التي وُلدت في بِركلي أصلًا.

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [BSD],
    [لِينُكس\ `iproute2`],

    [عرض الواجهات والعناوين], [`ifconfig`], [`ip addr`],
    [واجهةٌ بعينها], [`ifconfig em0`], [`ip addr show dev eth0`],
    [جدول التوجيه], [`netstat -rn`], [`ip route`],
    [مسارٌ افتراضيّ], [`route add default GW`], [`ip route add default via GW`],
    [تفعيل/تعطيل واجهة], [`ifconfig em0 up`], [`ip link set eth0 up`],
    [المنافذ المفتوحة], [`sockstat -l`], [`ss -tulpn`],
    [جدول ARP], [`arp -a`], [`ip neigh`],
    [استعلام DNS], [`drill NAME`], [`dig NAME`],
  )
})

#note[
  أسماء الواجهات تختلف: على FreeBSD اسمُ المُشغِّل نفسِه (`em0`, `re0`, `igb0`)، وعلى لِينُكس `eth0` أو أسماءٌ ثابتةٌ كـ`enp3s0`. استعرض واجهاتك بـ`ifconfig` أوّلًا قبل استعمال أيّ اسمٍ حرفيًّا. والأداةُ `drill` (من ldns) في نظام FreeBSD الأساس؛ ولو أردتَ `dig` فهو في حزمة `bind-tools`.
]

#section[الأقراص ونظام الملفّات]

يملك BSD نظامَي ملفّاتٍ أصيلين: UFS العريق، وZFS القويّ؛ ويُقسِّم الأقراصَ بأداةٍ موحّدةٍ اسمها `gpart`. لِينُكس يستعمل عائلة `ext`/`xfs` وأدواتٍ متفرّقةً للتقسيم.

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [BSD],
    [لِينُكس],

    [سرد الأقراص], [`geom disk list`], [`lsblk`],
    [جدول التقسيم], [`gpart show`], [`fdisk -l`],
    [تقسيم قرص], [`gpart add ...`], [`parted` / `fdisk`],
    [إنشاء نظام ملفّات], [`newfs /dev/ada0p2`], [`mkfs.ext4 /dev/sda2`],
    [التركيب (mount)], [`mount /dev/ada0p2 /mnt`], [`mount /dev/sda2 /mnt`],
    [الفكّ (umount)], [`umount /mnt`], [`umount /mnt`],
    [مساحةٌ حرّة], [`df -h`], [`df -h`],
    [فحص نظام ملفّات], [`fsck /dev/ada0p2`], [`fsck /dev/sda2`],
  )
})

#tip[
  ZFS ميزةُ BSD الكبرى ولا مقابلَ له مدمجًا في نواة لِينُكس (لأسباب رخصة). أوامرُه الأساسيّة أصيلةٌ في FreeBSD: `zpool status` لحالة التجمّع، و`zfs list` للمجلّدات، و`zfs snapshot pool/data@now` للقطة. فصَّلها الفصلُ الثاني والثلاثون.
]

#section[الجدار الناريّ]

جدارُ BSD الناريُّ الأصيلُ هو `pf` (وُلد في OpenBSD وانتشر)، يُدار بملفٍّ واحدٍ واضحٍ `/etc/pf.conf` والأداة `pfctl`. لِينُكس يستعمل `nftables` (خلَفَ `iptables`).

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [BSD\ `pf`],
    [لِينُكس\ `nftables`],

    [ملفّ القواعد], [`/etc/pf.conf`], [`/etc/nftables.conf`],
    [تحميل القواعد], [`pfctl -f /etc/pf.conf`], [`nft -f /etc/nftables.conf`],
    [تفعيل الجدار], [`pfctl -e`], [`systemctl start nftables`],
    [عرض القواعد], [`pfctl -sr`], [`nft list ruleset`],
    [عرض الحالات], [`pfctl -ss`], [`conntrack -L`],
    [إحصاءات], [`pfctl -si`], [`nft list counters`],
  )
})

#note[
  فلسفةُ `pf` أنّ كلَّ القواعد في ملفٍّ واحدٍ يُقرأ من أعلى لأسفل وتغلب الأخيرة، فتراجعه كنصٍّ واحدٍ متماسك. أمّا `iptables` القديم فقوائمُ أوامرَ متتابعةٌ يصعب تتبّعها — وهذا من أجمل ما يميّز BSD. فصَّل `pf` الفصلُ الحادي والثلاثون.
]

#section[الفروق الخفيّة: أوامرٌ متطابقةُ الاسم مختلفةُ السلوك]

أخطرُ ما في العبور بين النظامين ليس الأوامرَ المفقودة، بل الأوامرَ الموجودة باسمٍ واحدٍ وسلوكٍ مختلف. فـBSD يستعمل نسختَه الأصليّة من الأداة، ولِينُكس يستعمل نسخة GNU؛ وهذه أشهر المطبّات.

#subsection[sed: التحرير في المكان يختلف جوهريًّا]

أشهرُ فخٍّ هو `sed -i` (التعديل داخل الملفّ). نسخةُ BSD تُلزمك بمعامل اللاحقة دائمًا ولو فارغًا `''`، ونسخةُ GNU تقبله ملتصقًا أو تعمل بلا نسخةٍ احتياطيّة.

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [BSD],
    [لِينُكس (GNU)],

    [تعديلٌ في المكان بلا نسخة], [`sed -i '' 's/a/b/' FILE`], [`sed -i 's/a/b/' FILE`],
    [تعديلٌ مع نسخةٍ احتياطيّة], [`sed -i '.bak' 's/a/b/' FILE`], [`sed -i'.bak' 's/a/b/' FILE`],
    [التعابير الممتدّة], [`sed -E 's/(a)+/x/' FILE`], [`sed -E 's/(a)+/x/' FILE`],
  )
})

#warn[
  الأمر `sed -i 's/a/b/' FILE` (بلا `''`) يعمل على لِينُكس ويُفسِد على BSD: يظنّ `sed` أنّ نصّ الاستبدال لاحقةُ النسخة الاحتياطيّة. على BSD اكتب `sed -i ''` دائمًا. ولسكربتٍ محمولٍ بين النظامين تجنّب `-i` تمامًا واكتب إلى ملفٍّ مؤقّتٍ ثم استبدل.
]

#subsection[ls وdate: الألوان والحساب]

`ls` يلوّن الخرجَ بـ`-G` على BSD (ويقرأ `CLICOLOR`)، وبـ`--color=auto` على GNU. و`date` من أشدّ الأوامر تباعدًا في حساب تاريخٍ نسبيّ.

#block(breakable: true, {
  set text(size: SIZE.small)
  table(
    columns: (auto, 1fr, 1fr),
    inset: 5pt,
    [المهمّة],
    [BSD],
    [لِينُكس (GNU)],

    [تلوين خرج ls], [`ls -G`], [`ls --color=auto`],
    [قبل يومين من الآن], [`date -v -2d`], [`date -d '2 days ago'`],
    [تحويل ختم وقتٍ إلى تاريخ], [`date -r 1700000000`], [`date -d @1700000000`],
    [عمليّاتٌ بتنسيقٍ مخصّص], [`ps -axww -o pid,comm`], [`ps -e -o pid,comm`],
  )
})

#note[
  رموزُ تنسيق `date` نفسها (`%Y`, `%m`, `%d`, `%H`) متطابقةٌ لأنّها من معيار C؛ الاختلافُ في أعلام الحساب لا في العرض. ولو أردتَ سلوكَ GNU على BSD فثبّت `pkg install coreutils gsed` واستعمل النسخ المسبوقة بحرف `g` مثل `gdate` و`gsed`.
]

#section[خلاصةٌ عمليّة]

القاعدةُ الذهبيّة: BSD نظامٌ *متكاملٌ مصمت* — نواةٌ وأدواتٌ ووثائقُ من مصدرٍ واحدٍ تتناغم؛ ولِينُكس *تجميعٌ* — نواةٌ حرّةٌ تُلبَس أدوات GNU وتُغلَّف في توزيعاتٍ شتّى. من هذا الأصل تنبع كلُّ الفروق: إدارةُ الخدمات، والشبكة، والحزم، وحتى أعلامُ `sed`. فإن أتقنتَ أمرًا على FreeBSD فهو غالبًا يعمل كما هو على ماك (لاشتراكهما في بِركلي)، والحذرُ كلُّه عند العبور إلى لِينُكس أو منه. ولسكربتٍ يعمل في كلّ مكان: التزمِ المقاطعَ المشتركةَ في معيار POSIX، أو ثبّت أدوات GNU على BSD ووحّد السلوك.
