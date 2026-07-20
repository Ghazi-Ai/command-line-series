#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""مولّد هيكل الكتاب الرابع «BSD». شغّله من جذر المستودع:
python3 tools/gen_book4_bsd.py"""
import pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
AR = ROOT / "books" / "4-bsd" / "ar"

PARTS = [
    ("الأول", "عالم BSD والأساسيات", "p1-intro", [
        (1, "ch01-what-is-bsd", "ما BSD؟",
         "العائلة (FreeBSD وOpenBSD وNetBSD وDragonFly)، والفلسفة، والفرق عن لِينُكس: نظامٌ متكاملٌ لا نواةٌ وتوزيعات."),
        (2, "ch02-shell-basics", "الطرفية والصدفة على BSD",
         "الصدفات sh وtcsh، وأوّل أمر، وتشريح الأمر، والفروق عن صدفات لِينُكس."),
        (3, "ch03-navigation", "التنقّل ونظام الملفات",
         "‏pwd وcd وls، وبنية FreeBSD (‏hier)، ومكانة ‎/usr/local‎."),
        (4, "ch04-files", "عرض الملفات وإدارتها",
         "‏cat وless وcp وmv وrm بنكهة BSD، والحذف الآمن."),
        (5, "ch05-getting-help", "أن تساعد نفسك",
         "‏man وأقسامه على BSD، وصفحات الدليل الغنيّة، وغياب info."),
    ]),
    ("الثاني", "النظام وما يميّز BSD", "p2-system", [
        (6, "ch06-users-permissions", "المستخدمون والصلاحيات",
         "‏adduser وpw ومجموعة wheel، وdoas مقابل sudo، والصلاحيات."),
        (7, "ch07-pkg", "الحزم الثنائيّة: pkg",
         "مدير حزم FreeBSD: التثبيت والبحث والتحديث والإزالة."),
        (8, "ch08-ports", "شجرة المنافذ ports",
         "البناء من المصدر عبر ‎/usr/ports‎ و‎make install‎، ومتى تختارها على pkg."),
        (9, "ch09-rc-services", "الخدمات ونظام rc",
         "‏/etc/rc.conf وservice وrc.d — بديل systemd في عالم BSD."),
        (10, "ch10-install-disks", "الإقلاع والتثبيت والأقراص",
         "‏bsdinstall وgpart وأنظمة الملفات UFS وZFS و‎/etc/fstab‎."),
    ]),
    ("الثالث", "قوّة BSD", "p3-power", [
        (11, "ch11-zfs", "ZFS: نظام الملفات الجبّار",
         "‏zpool وzfs واللقطات snapshots — درّة FreeBSD."),
        (12, "ch12-jails", "jails: العزل الأصيل",
         "إنشاء jail وإدارتها، والفرق عن الحاويات في لِينُكس."),
        (13, "ch13-pf", "الجدار الناريّ pf",
         "‏/etc/pf.conf وقواعده الأنيقة — إرث OpenBSD."),
        (14, "ch14-networking", "الشبكات على BSD",
         "‏ifconfig وإعداد الشبكة في rc.conf، والفروق عن ip في لِينُكس."),
        (15, "ch15-monitoring", "المراقبة والأداء",
         "‏top وps وsysctl وdmesg وقراءة حال النظام."),
    ]),
    ("الرابع", "النصوص والتطوير والأمن", "p4-dev", [
        (16, "ch16-text", "معالجة النصوص",
         "‏grep وsed وawk بنكهة BSD، والفروق عن GNU."),
        (17, "ch17-scripting", "كتابة السكربتات على BSD",
         "سكربتات sh، وسطر الصدارة، والفروق العمليّة."),
        (18, "ch18-security", "الأمن وتقوية النظام",
         "فلسفة أمان OpenBSD، وdoas، ومفاهيم pledge/unveil، والتحديثات."),
    ]),
    ("الخامس", "الجسر إلى لِينُكس", "p5-bridge", [
        (19, "ch19-linux-bridge", "لِينُكس من منظور مستخدم BSD",
         "الفصل الجسريّ: rc مقابل systemd، pkg مقابل apt، BSD مقابل GNU، والاتّصال بخوادم لِينُكس والانتقال بينها."),
    ]),
]

APPENDICES = [
    ("أ", "appA-bsd-linux", "جدول مقارنة BSD ولِينُكس",
     "الأمر المكافئ لكلّ مهمّة عبر FreeBSD ولِينُكس جنبًا إلى جنب."),
    ("ب", "appB-pkg-ports", "مرجع pkg وports السريع",
     "أكثر أوامر pkg وports استعمالًا حسب المهمّة."),
    ("ج", "appC-glossary", "مسرد المصطلحات",
     "عربيّ ↔ إنجليزيّ لمصطلحات BSD الواردة."),
    ("د", "appD-sources", "المصادر والمراجع",
     "المراجع المعتمدة (FreeBSD Handbook، OpenBSD FAQ، man)."),
    ("هـ", "appE-resources", "مصادر للاستزادة",
     "مواقع وكتبٌ لمواصلة إتقان BSD."),
]

CH_STUB = '''#import "/lib/book.typ": chapter, section
#import "/lib/components.typ": objectives, note

#chapter[{title}]

{desc}

#note[هذا الفصل قيدُ الكتابة في كتاب «BSD» من سلسلة سطر الأوامر.]
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

md = ["# منهج الكتاب الرابع — «BSD»", "",
      "سطر الأوامر على أنظمة BSD (FreeBSD وOpenBSD) من الصِّفر. المتطلّب: القراءة والكتابة.", "", "---", ""]
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
(ROOT / "books" / "4-bsd").mkdir(parents=True, exist_ok=True)
(ROOT / "books" / "4-bsd" / "OUTLINE.md").write_text("\n".join(md), encoding="utf-8")

print(f"created {created} stub files; chapters={total}, appendices={len(APPENDICES)}")
