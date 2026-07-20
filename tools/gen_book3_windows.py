#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""مولّد هيكل الكتاب الثالث «ويندوز». شغّله من جذر المستودع:
python3 tools/gen_book3_windows.py"""
import pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
AR = ROOT / "books" / "3-windows" / "ar"

PARTS = [
    ("الأول", "أساسيات سطر أوامر ويندوز", "p1-basics", [
        (1, "ch01-what-is-cmdline", "ما سطر الأوامر في ويندوز؟",
         "‏CMD وPowerShell وWindows Terminal، وكيف تفتح كلًّا، وأوّل أمر."),
        (2, "ch02-navigation", "التنقّل في نظام ملفات ويندوز",
         "‏cd وdir والأقراص ‎C:\\‎ والمسارات بالشرطة العكسية."),
        (3, "ch03-viewing-files", "عرض الملفات وقراءتها",
         "‏type وmore وfindstr للبحث داخل الملفات."),
        (4, "ch04-manipulating-files", "الإنشاء والنسخ والنقل والحذف",
         "‏mkdir وcopy وmove وdel وrmdir وren."),
        (5, "ch05-getting-help", "المساعدة الذاتية",
         "‏help و‎/?‎ وGet-Help: كيف تجد الجواب بنفسك."),
    ]),
    ("الثاني", "CMD والباتش", "p2-cmd", [
        (6, "ch06-env-path", "متغيّرات البيئة والمسار PATH",
         "‏set و‎%VAR%‎ وsetx وعرض ‎%PATH%‎."),
        (7, "ch07-batch-basics", "أساسيات سكربتات الباتش",
         "ملفّات ‎.bat‎ وecho و‎@echo off‎ وrem والمتغيّرات."),
        (8, "ch08-batch-control", "التحكّم بالتدفّق في الباتش",
         "‏if وfor وgoto والعلامات labels وcall."),
        (9, "ch09-cmd-system", "أوامر النظام في CMD",
         "‏ipconfig وtasklist وtaskkill وsfc وchkdsk وsysteminfo."),
    ]),
    ("الثالث", "PowerShell: القوّة الحديثة", "p3-powershell", [
        (10, "ch10-ps-philosophy", "فلسفة PowerShell: الكائنات لا النصوص",
         "‏cmdlets وصيغة فعل-اسم Verb-Noun وأنبوب الكائنات."),
        (11, "ch11-ps-discovery", "الاستكشاف في PowerShell",
         "‏Get-Command وGet-Help وGet-Member: كيف تكتشف كلّ شيء."),
        (12, "ch12-ps-files", "التنقّل والملفات في PowerShell",
         "‏Get-ChildItem وSet-Location وGet-Content والمزوّدات providers."),
        (13, "ch13-ps-variables", "المتغيّرات والأنواع والكائنات",
         "المتغيّرات ‎$‎ والأنواع والكائنات وخصائصها."),
        (14, "ch14-ps-pipeline", "الأنابيب والترشيح",
         "‏Where-Object وSelect-Object وSort-Object وForEach-Object."),
        (15, "ch15-ps-output", "التنسيق والإخراج",
         "‏Format-Table وOut-File وConvertTo-Json/Csv."),
        (16, "ch16-ps-scripting", "كتابة سكربتات PowerShell",
         "ملفّات ‎.ps1‎ والدوال والمعطيات وسياسة التنفيذ."),
        (17, "ch17-ps-control", "التحكّم بالتدفّق ومعالجة الأخطاء",
         "‏if وswitch والحلقات وtry/catch."),
        (18, "ch18-ps-admin", "إدارة النظام بـPowerShell",
         "‏Get-Process/Service وسجلّ الأحداث والريجستري وwinget."),
        (19, "ch19-ps-network", "الشبكات والوصول عن بُعد",
         "‏Test-Connection وInvoke-WebRequest وInvoke-Command."),
    ]),
    ("الرابع", "WSL: لِينُكس داخل ويندوز", "p4-wsl", [
        (20, "ch20-wsl-intro", "ما WSL ولماذا",
         "‏WSL2 وتثبيت التوزيعات والأمر wsl."),
        (21, "ch21-wsl-bridge", "الجسر بين العالمين",
         "الوصول للملفّات عبر النظامين، والتشغيل المتبادل."),
        (22, "ch22-which-shell", "متى تستعمل ماذا: CMD وPowerShell وWSL",
         "دليل الاختيار بين الصدفات الثلاث."),
    ]),
]

APPENDICES = [
    ("أ", "appA-cmd-ps-bash", "جدول مقارنة CMD وPowerShell وBash",
     "الأمر المكافئ لكلّ مهمّة عبر الصدفات الثلاث جنبًا إلى جنب."),
    ("ب", "appB-ps-cmdlets", "مرجع cmdlets السريع",
     "أكثر أوامر PowerShell استعمالًا حسب المهمّة."),
    ("ج", "appC-glossary", "مسرد المصطلحات",
     "عربيّ ↔ إنجليزيّ لمصطلحات ويندوز وPowerShell."),
    ("د", "appD-sources", "المصادر والمراجع",
     "المراجع المعتمدة (Microsoft Learn، وثائق PowerShell)."),
    ("هـ", "appE-resources", "مصادر للاستزادة",
     "مواقع وكتبٌ لمواصلة إتقان ويندوز من الطرفية."),
]

CH_STUB = '''#import "/lib/book.typ": chapter, section
#import "/lib/components.typ": objectives, note

#chapter[{title}]

{desc}

#note[هذا الفصل قيدُ الكتابة في كتاب «ويندوز» من سلسلة سطر الأوامر.]
'''

APP_STUB = '''#import "/lib/book.typ": appendix, section
#import "/lib/components.typ": note

#appendix("{letter}", "{title}")

{desc}

#note[هذا الملحق قيدُ الإعداد.]
'''

def esc(s):
    for ch in ['\\', '`', '*', '_', '#', '$', '<', '>', '@', '~']:
        s = s.replace(ch, '\\' + ch)
    return s

def w(path, text):
    path.parent.mkdir(parents=True, exist_ok=True)
    if path.exists():
        return False
    path.write_text(text, encoding="utf-8")
    return True

created = 0
for _o, _pt, pdir, chs in PARTS:
    for num, slug, title, desc in chs:
        if w(AR / "chapters" / pdir / f"{slug}.typ", CH_STUB.format(title=esc(title), desc=esc(desc))):
            created += 1
for letter, slug, title, desc in APPENDICES:
    if w(AR / "appendices" / f"{slug}.typ", APP_STUB.format(letter=letter, title=title, desc=esc(desc))):
        created += 1

lines = ['#import "/lib/book.typ": part, appendix', '']
for _o, ptitle, pdir, chs in PARTS:
    lines.append(f'#part("{_o}", "{ptitle}")')
    for num, slug, title, desc in chs:
        lines.append(f'#include "chapters/{pdir}/{slug}.typ"')
    lines.append('')
lines.append('#part("", "الملاحق")')
for letter, slug, title, desc in APPENDICES:
    lines.append(f'#include "appendices/{slug}.typ"')
lines.append('')
(AR / "_contents.typ").write_text("\n".join(lines), encoding="utf-8")

md = ["# منهج الكتاب الثالث — «ويندوز»", "",
      "سطر الأوامر على ويندوز (CMD وPowerShell وWSL) من الصِّفر. المتطلّب: القراءة والكتابة.", "", "---", ""]
total = 0
for _o, ptitle, pdir, chs in PARTS:
    md.append(f"## الجزء {_o}: {ptitle}"); md.append("")
    for num, slug, title, desc in chs:
        total += 1
        md.append(f"- **الفصل {num} — {title}** — {desc}")
    md.append("")
md.append("## الملاحق"); md.append("")
for letter, slug, title, desc in APPENDICES:
    md.append(f"- **الملحق {letter} — {title}** — {desc}")
md.append("")
(ROOT / "books" / "3-windows").mkdir(parents=True, exist_ok=True)
(ROOT / "books" / "3-windows" / "OUTLINE.md").write_text("\n".join(md), encoding="utf-8")

print(f"created {created} stub files; chapters={total}, appendices={len(APPENDICES)}")
