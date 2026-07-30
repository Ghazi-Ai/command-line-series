#import "/lib/book.typ": appendix, section
#import "/lib/components.typ": note

#appendix("د", "المصادر والمراجع")

صيغ متن هذا الكتاب خصيصًا للسلسلة. واستُخدمت المراجع الآتية
للتحقق من سلوك اللغات والأدوات والمفاهيم التقنية، لا لنقل نصوصها.
تاريخ الاطلاع على المصادر الحية: 2026-07-30.

#section[الصدفات والمعايير]

- دليل باش المرجعي الرسمي، مشروع GNU:
  `gnu.org/software/bash/manual/`
- مواصفة يونكس الموحّدة ومعيار POSIX، الإصدار 2024، The Open Group:
  `pubs.opengroup.org/onlinepubs/9799919799/`
- صفحات دليل النظام للأوامر `find` و`test` و`printf` و`mktemp`
  و`mv` على كل بيئة اختبار؛ لأن الخيارات قد تختلف بين GNU وBSD.

#section[باورشِل]

- نظرة باورشِل (`PowerShell`) الرسمية ووصفه صدفةً ولغة أتمتة عابرة للأنظمة:
  `learn.microsoft.com/powershell/scripting/overview`
- موضوع `about_Scripts` لملفات `.ps1` والمعاملات والنطاق والوحدات:
  `learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_scripts`
- موضوع `about_Functions` للدوال والمدخلات والمخرجات والنطاق:
  `learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions`
- توثيق PSScriptAnalyzer الرسمي للفحص الساكن:
  `learn.microsoft.com/powershell/utility-modules/psscriptanalyzer/overview`

#section[بايثون والمشروع المرجعي]

- توثيق بايثون الرسمي لوحدة `argparse` وبناء واجهات سطر الأوامر:
  `docs.python.org/3/library/argparse.html`
- توثيق `pathlib` للمسارات:
  `docs.python.org/3/library/pathlib.html`
- توثيق `json` للترميز والقراءة والكتابة و`ensure_ascii`:
  `docs.python.org/3/library/json.html`
- توثيق `subprocess` وتشغيل البرامج الخارجية:
  `docs.python.org/3/library/subprocess.html`
- توثيق `shutil` لعمليات الملفات عالية المستوى:
  `docs.python.org/3/library/shutil.html`
- توثيق `unittest` للاختبارات:
  `docs.python.org/3/library/unittest.html`

#section[البيانات والفحص]

- دليل `jq` الرسمي لقراءة جيسون وإنشائه:
  `jqlang.org/manual/`
- موقع فاحص الصدفة (`ShellCheck`) الرسمي ودليل قواعده:
  `shellcheck.net`

#section[التحكم بالإصدارات]

- مرجع غِت الرسمي للأوامر والمفاهيم:
  `git-scm.com/docs`
- كتاب «برو غِت» (`Pro Git`) المنشور ضمن موقع المشروع الرسمي:
  `git-scm.com/book`

#section[التشغيل البعيد والجدولة]

- صفحات أوبن إس إس إتش (`OpenSSH`) الرسمية للأمر `ssh` والتحقق من مفاتيح المضيف
  والتنفيذ البعيد:
  `man.openbsd.org/ssh`
- توثيق مؤقتات systemd الرسمي:
  `freedesktop.org/software/systemd/man/systemd.timer.html`
- توثيق مايكروسوفت لمجدول المهام وباورشِل، بحسب إصدار ويندوز
  المستعمل وقت الاختبار.
- صفحات دليل `crontab` و`launchd` المحلية في البيئة المستعملة؛
  فالكتاب يشرح عقد الجدولة ولا يثبت تعريفًا واحدًا لكل نظام.

#section[الأسرار والأتمتة الخارجية]

- مرجع غِت هَب (`GitHub`) الرسمي للاستخدام الآمن للأتمتة: أقل صلاحية، ومنع
  تسريب الأسرار، ومخاطر إدخال النص غير الموثوق في الشيفرة:
  `docs.github.com/actions/reference/security/secure-use`

#note[
  أرقام إصدارات اللغات والأدوات ومصفوفة الأنظمة لا تُعتمد نهائيًا
  إلا بعد تشغيل اختبارات الكتاب عليها. الروابط الرسمية الحية قد
  تغير مساراتها؛ لذلك تُراجع مرة أخرى عند إعداد الإصدار المنشور.
]
