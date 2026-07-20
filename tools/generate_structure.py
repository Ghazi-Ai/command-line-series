#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
مولّد هيكل الكتاب «من الصِّفر إلى الجذر».
يُنشئ ملفّات الفصول الناقصة (لا يمسّ الموجود)، ويولّد:
  - src/ar/_contents.typ  (تسلسل الأجزاء والفصول والملاحق للبناء)
  - docs/OUTLINE.md       (المنهج الكامل، مصدره هذا الملف)
شغّله من جذر المشروع:  python3 tools/generate_structure.py
"""
import os, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
AR = ROOT / "books" / "1-linux" / "ar"

# البنية: (ترتيب الجزء العربي، عنوان الجزء، مجلّد الجزء، [ (رقم, slug, عنوان, وصف) ... ])
PARTS = [
    ("الأول", "الأساسات", "p1-foundations", [
        (1,  "ch01-what-is-terminal", "ما هي الطرفية؟",
         "النواة والصدفة والطرفية، وأوّل أمرٍ في حياتك، وتشريح الأمر."),
        (2,  "ch02-navigation", "التنقّل في نظام الملفات",
         "‏pwd وcd وls: كيف تعرف أين أنت وتتحرّك بين المجلّدات بثقة."),
        (3,  "ch03-filesystem-tree", "شجرة النظام: أين يسكن كلّ شيء",
         "بنية مجلّدات لِينُكس (FHS)، ومعنى ‎/‎ و‎/home‎ و‎/etc‎ و‎/usr‎."),
        (4,  "ch04-viewing-files", "عرض الملفات وقراءتها",
         "‏cat وless وhead وtail وfile: قراءة المحتوى دون فتح محرّر."),
        (5,  "ch05-manipulating-files", "الإنشاء والنسخ والنقل والحذف",
         "‏touch وmkdir وcp وmv وrm، وكيف تحذف بأمانٍ دون ندم."),
        (6,  "ch06-globbing", "المحارف البدلية وتوسيع الصدفة",
         "النجمة ‎*‎ وعلامة الاستفهام والأقواس: مخاطبة عشرات الملفات دفعةً واحدة."),
        (7,  "ch07-getting-help", "أن تساعد نفسك",
         "‏man وinfo و‎--help‎ وtldr وapropos: كيف تجد الجواب بنفسك دائمًا."),
    ]),
    ("الثاني", "النظام والمستخدمون", "p2-system", [
        (8,  "ch08-users-groups", "المستخدمون والمجموعات",
         "هويّات النظام: من أنت، وإلى أيّ مجموعةٍ تنتمي، ولماذا يهمّ ذلك."),
        (9,  "ch09-permissions", "الصلاحيات والملكية",
         "قراءة/كتابة/تنفيذ، وchmod وchown وumask وقوائم ACL."),
        (10, "ch10-sudo-root", "الجذر وsudo: القوة ومسؤوليتها",
         "متى ترفع صلاحيّاتك، ولماذا لا تعمل جذرًا طوال الوقت."),
        (11, "ch11-processes", "العمليات: نبض النظام",
         "‏ps وtop وhtop والإشارات وkill والمهام الخلفية."),
        (12, "ch12-packages", "الحزم ومديروها",
         "‏apt وdnf وpacman: التثبيت والتحديث والإزالة عبر العائلات — الفصل المرجعيّ للفروق."),
    ]),
    ("الثالث", "النصوص وتدفّق البيانات", "p3-text", [
        (13, "ch13-streams", "التدفّقات وإعادة التوجيه والأنابيب",
         "‏stdin/stdout/stderr و‎>‎ و‎>>‎ و‎|‎: فلسفة يونِكس عمليًّا."),
        (14, "ch14-filters", "أدوات الترشيح والتحويل",
         "‏grep وcut وsort وuniq وwc وtr وtee."),
        (15, "ch15-regex", "التعابير النمطية (Regex)",
         "لغة الأنماط: من الأساسيّة إلى الممتدّة وPCRE."),
        (16, "ch16-sed", "sed: محرّر التدفّق",
         "الاستبدال والحذف والتحويل الآليّ للنصوص."),
        (17, "ch17-awk", "awk: لغة معالجة النصوص",
         "الحقول والأنماط والحسابات على الجداول النصّية."),
        (18, "ch18-editors", "المحرّرات: nano وvim",
         "من التحرير البسيط إلى أساسيات vim التي تنقذك على أيّ خادم."),
    ]),
    ("الرابع", "الصدفة والأتمتة", "p4-shell", [
        (19, "ch19-environment", "البيئة وتخصيص الصدفة",
         "متغيّرات البيئة وPATH وملفّات bashrc وتفصيل صدفتك على مقاسك."),
        (20, "ch20-scripting-basics", "أساسيات كتابة السكربتات",
         "‏shebang والمتغيّرات والاقتباس، وأوّل سكربتٍ تكتبه."),
        (21, "ch21-control-flow", "التحكّم بالتدفّق",
         "‏if وcase والحلقات وأوامر الاختبار."),
        (22, "ch22-functions", "الدوال والوسائط وقيم الخروج",
         "تنظيم السكربتات وإعادة الاستخدام والتواصل بينها."),
        (23, "ch23-real-scripts", "سكربتات للعالم الحقيقي",
         "معالجة الأخطاء وset -euo pipefail وكتابة أدواتٍ موثوقة."),
        (24, "ch24-scheduling", "الجدولة",
         "‏cron وat ومؤقّتات systemd: أتمتة المهام بالوقت."),
    ]),
    ("الخامس", "إدارة النظام", "p5-sysadmin", [
        (25, "ch25-boot-systemd", "الإقلاع وsystemd والخدمات",
         "كيف يستيقظ النظام، وإدارة الخدمات وقراءة journald."),
        (26, "ch26-disks", "الأقراص وأنظمة الملفات",
         "التقسيم وmount وfstab وLVM وأنواع أنظمة الملفات."),
        (27, "ch27-monitoring", "المراقبة والأداء والسجلّات",
         "قياس الموارد وقراءة السجلّات وتشخيص البطء."),
        (28, "ch28-backup", "الأرشفة والنسخ الاحتياطي",
         "‏tar وgzip وrsync وبناء استراتيجيّة نسخٍ آمنة."),
        (29, "ch29-kernel", "النواة والوحدات و‎/proc‎",
         "تحميل الوحدات وضبط sysctl والنظر داخل النظام الحيّ."),
    ]),
    ("السادس", "الشبكات", "p6-networking", [
        (30, "ch30-network-basics", "أساسيات الشبكات في الطرفية",
         "‏ip وping وDNS وss: كيف يرى جهازك الشبكة."),
        (31, "ch31-transfer", "النقل والتنزيل",
         "‏curl وwget وscp وsftp: جلب البيانات وإرسالها."),
        (32, "ch32-ssh", "SSH بعمق",
         "المفاتيح والإعدادات والأنفاق وإعادة توجيه المنافذ."),
        (33, "ch33-firewalls", "الجدران النارية",
         "‏ufw وiptables/nftables: التحكّم بما يدخل ويخرج."),
        (34, "ch34-network-diag", "تشخيص الشبكات",
         "‏tcpdump وtraceroute وتتبّع المشكلات حتى جذرها."),
    ]),
    ("السابع", "مسار المطوّر", "p7-developer", [
        (35, "ch35-git", "Git من الطرفية",
         "التحكّم بالإصدارات: الأساس الذي يقوم عليه العمل الحديث."),
        (36, "ch36-build", "البناء والتشغيل والمترجمات",
         "‏make وأدوات البناء وتشغيل لغات البرمجة من الطرفية."),
        (37, "ch37-containers", "البيئات والحاويات",
         "العزل والبيئات الافتراضية وDocker/Podman من سطر الأوامر."),
        (38, "ch38-tmux-dotfiles", "الطرفية بيئةَ عملٍ متكاملة",
         "‏tmux وإدارة الجلسات وملفّات dotfiles."),
        (39, "ch39-modern-tools", "أدوات حديثة تغيّر حياتك",
         "‏ripgrep وfd وfzf وbat وjq: الجيل الجديد من أدوات الطرفية."),
    ]),
    ("الثامن", "الأمن السيبراني", "p8-security", [
        (40, "ch40-security-ethics", "مبادئ وأخلاقيات وقانون",
         "التصريح والاختبار المسؤول: الأساس الذي يسبق أيّ أداة."),
        (41, "ch41-recon", "الاستطلاع وجمع المعلومات",
         "‏nmap واكتشاف المضيفين والمنافذ في بيئةٍ مصرّحٍ بها."),
        (42, "ch42-traffic", "تحليل حركة الشبكة",
         "التقاط الحزم وقراءتها بأدوات سطر الأوامر."),
        (43, "ch43-crypto", "التعمية وكلمات المرور",
         "‏gpg والتجزئة (hashing) وحفظ الأسرار بأمان."),
        (44, "ch44-hardening", "تقوية النظام",
         "التدقيق وfail2ban وSELinux/AppArmor وتقليل سطح الهجوم."),
        (45, "ch45-forensics", "التحقيق الجنائي وتحليل السجلّات",
         "تتبّع الحوادث وقراءة الأثر بعد وقوعه."),
    ]),
    ("التاسع", "عوالم يونِكس الأخرى: BSD وماك", "p9-unix-worlds", [
        (46, "ch46-bsd", "BSD: العائلة الأخرى",
         "‏FreeBSD وOpenBSD وGhostBSD: pkg وports وrc.d وpf وjails، والفروق عن لِينُكس."),
        (47, "ch47-macos", "ماك: يونِكسٌ على سطح المكتب",
         "‏Darwin وأصل BSD، صدفة zsh، أدوات BSD مقابل GNU، وHomebrew."),
    ]),
]

# الملاحق: (حرف, slug, عنوان, وصف)
APPENDICES = [
    ("أ", "appA-quick-reference", "المرجع السريع للأوامر",
     "بطاقةٌ مرجعيّة لأكثر الأوامر استعمالًا، مرتّبةً حسب المهمّة."),
    ("ب", "appB-package-managers", "جدول مقارنة مديري الحزم",
     "‏apt وdnf وpacman وzypper جنبًا إلى جنب لكلّ مهمّة."),
    ("ج", "appC-shortcuts", "اختصارات لوحة المفاتيح",
     "اختصارات الصدفة (bash/readline) التي تضاعف سرعتك."),
    ("د", "appD-practice-lab", "ابنِ مختبرك الافتراضي",
     "إعداد بيئة تدريبٍ آمنة على جهازٍ افتراضيّ للتجريب بلا خوف."),
    ("هـ", "appE-glossary", "مسرد المصطلحات",
     "عربيّ ↔ إنجليزيّ لكلّ المصطلحات الواردة في الكتاب."),
    ("و", "appF-resources", "مصادر للاستزادة",
     "كتبٌ ومواقع وألعابٌ تعليميّة لمواصلة الرحلة بعد الكتاب."),
]

CH_STUB = '''\
#import "/lib/book.typ": chapter, section
#import "/lib/components.typ": objectives, note

#chapter[{title}]

{desc}

#note[
  هذا الفصل قيدُ الكتابة. يُبنى «مِن الصِّفر إلى الجَذر» على مراحل، وسيُستكمل هذا
  الفصل بالشرح والأمثلة وصناديق «جرِّب بنفسك» والتحدّي الختاميّ في التحديث القادم.
]
'''

APP_STUB = '''\
#import "/lib/book.typ": appendix, section
#import "/lib/components.typ": note

#appendix("{letter}", "{title}")

{desc}

#note[هذا الملحق قيدُ الإعداد.]
'''

def esc(s):
    # تهريب محارف Typst الخاصة كي تظهر كنصٍّ حرفيّ في المتن.
    for ch in ['\\', '`', '*', '_', '#', '$', '<', '>', '@', '~']:
        s = s.replace(ch, '\\' + ch)
    return s

def w(path, text, overwrite=True):
    path.parent.mkdir(parents=True, exist_ok=True)
    if path.exists() and not overwrite:
        return False
    path.write_text(text, encoding="utf-8")
    return True

# 1) ملفّات الفصول (لا نكتب فوق الموجود)
created = 0
for _ord, _ptitle, pdir, chapters in PARTS:
    for num, slug, title, desc in chapters:
        p = AR / "chapters" / pdir / f"{slug}.typ"
        if w(p, CH_STUB.format(title=esc(title), desc=esc(desc)), overwrite=False):
            created += 1

for letter, slug, title, desc in APPENDICES:
    p = AR / "appendices" / f"{slug}.typ"
    if w(p, APP_STUB.format(letter=letter, title=title, desc=esc(desc)), overwrite=False):
        created += 1

# 2) ملفّ المحتوى (_contents.typ)
lines = ['#import "/lib/book.typ": part, appendix', '']
for _ord, ptitle, pdir, chapters in PARTS:
    lines.append(f'#part("{_ord}", "{ptitle}")')
    for num, slug, title, desc in chapters:
        lines.append(f'#include "chapters/{pdir}/{slug}.typ"')
    lines.append('')
lines.append('#part("", "الملاحق")')
for letter, slug, title, desc in APPENDICES:
    lines.append(f'#include "appendices/{slug}.typ"')
lines.append('')
w(AR / "_contents.typ", "\n".join(lines))

# 3) المنهج الكامل (OUTLINE.md)
md = ["# منهج الكتاب — «مِن الصِّفر إلى الجَذر»", "",
      "الدليل الشامل إلى سطر الأوامر ولِينُكس. المتطلّب الوحيد: أن تعرف القراءة والكتابة.",
      "", "> يُبنى الكتاب على مراحل. الفصل الأول مكتمل؛ والبقيّة هياكل جاهزة تُملأ تباعًا.",
      "", "---", ""]
total = 0
for i, (_ord, ptitle, pdir, chapters) in enumerate(PARTS, 1):
    md.append(f"## الجزء {_ord}: {ptitle}")
    md.append("")
    for num, slug, title, desc in chapters:
        total += 1
        md.append(f"- **الفصل {num} — {title}** — {desc}")
    md.append("")
md.append("## الملاحق")
md.append("")
for letter, slug, title, desc in APPENDICES:
    md.append(f"- **الملحق {letter} — {title}** — {desc}")
md.append("")
md.append("---")
md.append("")
md.append(f"**الإجمالي:** {total} فصلًا في {len(PARTS)} أجزاء، و{len(APPENDICES)} ملاحق.")
md.append("")
w(ROOT / "docs" / "OUTLINE.md", "\n".join(md))

print(f"created {created} new stub files")
print(f"total chapters: {total}, parts: {len(PARTS)}, appendices: {len(APPENDICES)}")
