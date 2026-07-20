#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""مولّد هيكل الكتاب الثاني «ماك». يُنشئ الفصول والملاحق و_contents وOUTLINE.
شغّله من جذر المستودع:  python3 tools/gen_book2_macos.py"""
import pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
AR = ROOT / "books" / "2-macos" / "ar"

PARTS = [
    ("الأول", "أساسيات الطرفية على ماك", "p1-basics", [
        (1, "ch01-what-is-terminal-mac", "ما الطرفية على ماك؟",
         "‏Terminal.app وصدفة zsh، وأنّ ماك نظام يونِكس (Darwin) في جوهره."),
        (2, "ch02-navigation", "التنقّل في نظام ملفات ماك",
         "‏pwd وcd وls، وبنية ماك: ‎/Users‎ و‎/Applications‎ و‎/System‎."),
        (3, "ch03-viewing-files", "عرض الملفات وقراءتها",
         "‏cat وless وhead وtail، وعرض ماك السريع qlmanage."),
        (4, "ch04-manipulating-files", "الإنشاء والنسخ والنقل والحذف",
         "‏touch وmkdir وcp وmv وrm، والمهملات عبر trash."),
        (5, "ch05-getting-help", "أن تساعد نفسك",
         "‏man وtldr و‎--help‎ على ماك."),
    ]),
    ("الثاني", "صدفة zsh والبيئة", "p2-shell", [
        (6, "ch06-zsh", "zsh: الصدفة الافتراضية",
         "لماذا zsh، والفرق عن bash، وإطار oh-my-zsh."),
        (7, "ch07-environment", "البيئة وتخصيص zsh",
         "متغيّرات البيئة وPATH وملفّات ‎.zshrc‎ و‎.zprofile‎."),
        (8, "ch08-scripting", "أساسيات كتابة السكربتات",
         "‏shebang والمتغيّرات والاقتباس على zsh/bash."),
        (9, "ch09-control-flow", "التحكّم بالتدفّق والدوال",
         "‏if وcase والحلقات والدوال وقيم الخروج."),
    ]),
    ("الثالث", "ما يميّز ماك", "p3-macos", [
        (10, "ch10-bsd-vs-gnu", "أدوات BSD مقابل GNU",
         "الفروق الجوهريّة: ‎sed -i ''‎ وls -G وdate وstat وrealpath — الفصل المحوريّ."),
        (11, "ch11-homebrew", "Homebrew: مدير الحزم",
         "‏brew install/search/services وcasks وتثبيت أدوات GNU."),
        (12, "ch12-mac-native", "أدوات ماك الأصيلة",
         "‏open وpbcopy/pbpaste وmdfind وsay وcaffeinate وscreencapture."),
        (13, "ch13-processes-launchd", "النظام والعمليات وlaunchd",
         "‏ps وtop وlaunchctl/launchd والخدمات على ماك."),
        (14, "ch14-disks-system", "الأقراص وإعدادات النظام",
         "‏diskutil وdf وsoftwareupdate وdefaults وحماية SIP."),
    ]),
    ("الرابع", "النصوص والشبكات والتطوير", "p4-dev", [
        (15, "ch15-text", "معالجة النصوص على ماك",
         "‏grep وsed وawk وفروق BSD عن GNU عمليًّا."),
        (16, "ch16-networking", "الشبكات على ماك",
         "‏ifconfig وping وnetworksetup وscutil وcurl وssh."),
        (17, "ch17-git-dev", "Git وأدوات التطوير",
         "‏Xcode Command Line Tools وgit والمترجمات."),
        (18, "ch18-terminal-env", "الطرفية بيئةَ عملٍ متكاملة",
         "‏tmux وdotfiles وiTerm2."),
    ]),
    ("الخامس", "الجسر إلى عوالم يونِكس", "p5-bridge", [
        (19, "ch19-linux-bsd-bridge", "لِينُكس وBSD من منظور مستخدم ماك",
         "الفصل الجسريّ: الانتقال إلى لِينُكس وBSD، الفروق، SSH لخادم لِينُكس، والأدوات المشتركة."),
    ]),
]

APPENDICES = [
    ("أ", "appA-mac-linux-bsd", "جدول مقارنة ماك ولِينُكس وBSD",
     "الأمر المكافئ لكلّ مهمّة عبر الأنظمة الثلاثة جنبًا إلى جنب."),
    ("ب", "appB-homebrew", "مرجع Homebrew السريع",
     "أكثر أوامر brew استعمالًا مرتّبةً حسب المهمّة."),
    ("ج", "appC-glossary", "مسرد المصطلحات",
     "عربيّ ↔ إنجليزيّ لمصطلحات ماك ويونِكس الواردة."),
    ("د", "appD-sources", "المصادر والمراجع",
     "المراجع الموثوقة المعتمدة للتحقّق (وثائق Apple، man، POSIX)."),
    ("هـ", "appE-resources", "مصادر للاستزادة",
     "مواقع وكتبٌ لمواصلة إتقان ماك من الطرفية."),
]

CH_STUB = '''#import "/lib/book.typ": chapter, section
#import "/lib/components.typ": objectives, note

#chapter[{title}]

{desc}

#note[هذا الفصل قيدُ الكتابة في كتاب «ماك» من سلسلة سطر الأوامر.]
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
w2 = AR / "_contents.typ"
w2.write_text("\n".join(lines), encoding="utf-8")

# OUTLINE
md = ["# منهج الكتاب الثاني — «ماك»", "",
      "سطر الأوامر على macOS من الصِّفر إلى الإتقان. المتطلّب الوحيد: القراءة والكتابة.", "", "---", ""]
total = 0
for _o, ptitle, pdir, chs in PARTS:
    md.append(f"## الجزء {_o}: {ptitle}")
    md.append("")
    for num, slug, title, desc in chs:
        total += 1
        md.append(f"- **الفصل {num} — {title}** — {desc}")
    md.append("")
md.append("## الملاحق")
md.append("")
for letter, slug, title, desc in APPENDICES:
    md.append(f"- **الملحق {letter} — {title}** — {desc}")
md.append("")
(ROOT / "books" / "2-macos").mkdir(parents=True, exist_ok=True)
(ROOT / "books" / "2-macos" / "OUTLINE.md").write_text("\n".join(md), encoding="utf-8")

print(f"created {created} stub files; chapters={total}, appendices={len(APPENDICES)}")
