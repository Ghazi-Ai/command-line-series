#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
مولّد EPUB لسلسلة سطر الأوامر — بلا أدوات خارجية (Python خالص + zipfile).
يحوّل ملفّات Typst (.typ) لكتابٍ إلى EPUB3 عربيٍّ RTL يُقرأ على الجوّال.

الاستعمال:
    python3 tools/make_epub.py books/6-unix-story/ar build/unix-story.epub

مصمَّمٌ للكتب الأدبيّة (نثر + عناوين + note). لا يعالج كتل الكود والجداول
(كتب الأوامر) — تلك تبقى PDF.
"""
import sys, os, re, html, zipfile, datetime, hashlib

def esc(s):
    return html.escape(s, quote=False)

def inline(s):
    # حماية الكود المضمّن أوّلًا
    s = esc(s)
    s = re.sub(r'`([^`]+)`', r'<code>\1</code>', s)
    s = re.sub(r'\*([^*]+)\*', r'<em>\1</em>', s)
    return s

def typ_to_html(text):
    """يحوّل نصّ ملفّ .typ إلى فقرات XHTML."""
    # أزل الاستيرادات والتعليقات السطريّة
    lines = [l for l in text.split('\n')
             if not l.lstrip().startswith('#import')
             and not l.lstrip().startswith('//')]
    text = '\n'.join(lines)

    # استخرِج العناوين والصناديق ككتلٍ مستقلّة عبر علاماتٍ مؤقّتة
    blocks = []  # (kind, content)

    # نمطٌ يلتقط الدوالّ ذات المحتوى
    # #chapter[..] #section[..] #subsection[..]  (محتوى بين [ ])
    # #front-title("..")  #appendix("ح","..")
    # #note[..] (قد يمتدّ أسطرًا)
    pos = 0
    pat = re.compile(
        r'#chapter\[(?P<ch>[^\]]*)\]'
        r'|#section\[(?P<sec>[^\]]*)\]'
        r'|#subsection\[(?P<sub>[^\]]*)\]'
        r'|#front-title\("(?P<ft>[^"]*)"[^)]*\)'
        r'|#appendix\("[^"]*",\s*"(?P<ap>[^"]*)"\)'
        r'|#note\[(?P<note>.*?)\](?=\s*(?:\n\s*\n|\n?$|#))',
        re.S)
    for m in pat.finditer(text):
        if m.start() > pos:
            blocks.append(('prose', text[pos:m.start()]))
        if m.group('ch') is not None:
            blocks.append(('h1', m.group('ch')))
        elif m.group('sec') is not None:
            blocks.append(('h2', m.group('sec')))
        elif m.group('sub') is not None:
            blocks.append(('h3', m.group('sub')))
        elif m.group('ft') is not None:
            blocks.append(('h1', m.group('ft')))
        elif m.group('ap') is not None:
            blocks.append(('h1', m.group('ap')))
        elif m.group('note') is not None:
            blocks.append(('note', m.group('note')))
        pos = m.end()
    if pos < len(text):
        blocks.append(('prose', text[pos:]))

    out = []
    for kind, content in blocks:
        content = content.strip()
        if not content:
            continue
        if kind == 'h1':
            out.append(f'<h1>{inline(content)}</h1>')
        elif kind == 'h2':
            out.append(f'<h2>{inline(content)}</h2>')
        elif kind == 'h3':
            out.append(f'<h3>{inline(content)}</h3>')
        elif kind == 'note':
            # الفقرات داخل الصندوق
            paras = [p.strip() for p in re.split(r'\n\s*\n', content) if p.strip()]
            inner = ''.join(f'<p>{inline(p)}</p>' for p in paras)
            out.append(f'<aside class="note">{inner}</aside>')
        else:  # prose
            for para in re.split(r'\n\s*\n', content):
                para = para.strip()
                if not para:
                    continue
                # قائمة؟ أسطر تبدأ بـ-
                pl = [l.strip() for l in para.split('\n')]
                if all(l.startswith('- ') for l in pl if l):
                    items = ''.join(f'<li>{inline(l[2:])}</li>' for l in pl if l)
                    out.append(f'<ul>{items}</ul>')
                else:
                    para = ' '.join(pl)
                    out.append(f'<p>{inline(para)}</p>')
    return '\n'.join(out)

def read_contents(book_dir):
    """يقرأ _contents.typ فيعيد قائمة (part_title | None, file_path)."""
    items = []
    c = open(os.path.join(book_dir, '_contents.typ')).read()
    for line in c.split('\n'):
        mp = re.search(r'#part\("[^"]*",\s*"([^"]+)"\)', line)
        if mp:
            items.append(('part', mp.group(1)))
        mi = re.search(r'#include "([^"]+)"', line)
        if mi:
            items.append(('file', os.path.join(book_dir, mi.group(1))))
    return items

def xhtml_page(title, body):
    return ('<?xml version="1.0" encoding="utf-8"?>\n'
        '<!DOCTYPE html>\n'
        '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ar" lang="ar" dir="rtl">\n'
        f'<head><meta charset="utf-8"/><title>{esc(title)}</title>'
        '<link rel="stylesheet" type="text/css" href="style.css"/></head>\n'
        f'<body dir="rtl">\n{body}\n</body>\n</html>\n')

CSS = """@namespace epub "http://www.idpf.org/2007/ops";
html { direction: rtl; }
body { direction: rtl; text-align: right; font-family: serif;
       line-height: 1.9; margin: 1.2em; }
h1 { font-size: 1.7em; color: #164A3E; text-align: center;
     margin: 1.6em 0 0.9em; line-height: 1.4; }
h2 { font-size: 1.3em; color: #1F6F5C; margin: 1.4em 0 0.6em;
     border-right: 3px solid #C0592B; padding-right: 0.5em; }
h3 { font-size: 1.1em; color: #26242E; margin: 1.1em 0 0.5em; }
p  { margin: 0 0 0.9em; text-align: justify; }
aside.note { background: #F2F6F4; border-right: 3px solid #1F6F5C;
     padding: 0.7em 1em; margin: 1.1em 0; border-radius: 4px;
     font-size: 0.95em; color: #33313B; }
aside.note p { margin: 0.3em 0; }
em { font-weight: 700; font-style: normal; color: #164A3E; }
code { font-family: monospace; direction: ltr; unicode-bidi: embed;
       background: #F4F4F2; padding: 0 0.2em; border-radius: 3px; }
ul { margin: 0 0 0.9em; padding-right: 1.4em; }
li { margin: 0.3em 0; }
.cover { text-align: center; margin: 0; padding: 0; }
.cover img { max-width: 100%; height: auto; }
"""

def main():
    book_dir = sys.argv[1].rstrip('/')
    out_path = sys.argv[2]
    title = "رُوحٌ في الآلة — حكايةُ يونِكس"
    author = "المهندس غازي السيف"
    lang = "ar"

    items = read_contents(book_dir)
    # المقدّمات: preface (والغلاف صورة)
    front = []
    pref = os.path.join(book_dir, 'frontmatter/preface.typ')
    if os.path.exists(pref):
        front.append(('توطئة', pref))

    # اجمع صفحات المحتوى
    pages = []  # (id, nav_title, xhtml_filename, html_body, in_toc)
    idx = 0

    # الغلاف صورة
    cover_img = os.path.join(book_dir, 'assets/cover-front.png')
    has_cover = os.path.exists(cover_img)

    # التوطئة
    for nav, path in front:
        idx += 1
        body = typ_to_html(open(path).read())
        pages.append((f'p{idx}', nav, f'p{idx}.xhtml', body, True))

    # الأجزاء والفصول
    cur_part = None
    for kind, val in items:
        if kind == 'part':
            cur_part = val
            idx += 1
            body = f'<div style="text-align:center;margin-top:35%"><h1>{esc(val)}</h1></div>'
            pages.append((f'p{idx}', val, f'p{idx}.xhtml', body, True))
        else:
            if not os.path.exists(val):
                continue
            idx += 1
            raw = open(val).read()
            # تخطَّ الجذاذات غير المكتملة
            body = typ_to_html(raw)
            # عنوان الفصل للفهرس
            mt = re.search(r'#chapter\[([^\]]+)\]|#appendix\("[^"]*",\s*"([^"]+)"\)', raw)
            nav = (mt.group(1) or mt.group(2)) if mt else f'فصل {idx}'
            pages.append((f'p{idx}', nav, f'p{idx}.xhtml', body, True))

    # معرّفٌ ثابتٌ من محتوى العنوان
    uid = 'urn:uuid:' + hashlib.md5((title+author).encode()).hexdigest()
    today = datetime.date.today().isoformat()

    # ابنِ EPUB
    os.makedirs(os.path.dirname(out_path) or '.', exist_ok=True)
    z = zipfile.ZipFile(out_path, 'w', zipfile.ZIP_DEFLATED)
    # mimetype أوّلًا، بلا ضغط
    z.writestr('mimetype', 'application/epub+zip', compress_type=zipfile.ZIP_STORED)
    z.writestr('META-INF/container.xml',
        '<?xml version="1.0" encoding="UTF-8"?>\n'
        '<container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">\n'
        '<rootfiles><rootfile full-path="OEBPS/content.opf" '
        'media-type="application/oebps-package+xml"/></rootfiles></container>')
    z.writestr('OEBPS/style.css', CSS)

    manifest = ['<item id="css" href="style.css" media-type="text/css"/>',
                '<item id="nav" href="nav.xhtml" media-type="application/xhtml+xml" properties="nav"/>']
    spine = []

    # الغلاف
    if has_cover:
        z.write(cover_img, 'OEBPS/images/cover.png')
        manifest.append('<item id="coverimg" href="images/cover.png" media-type="image/png" properties="cover-image"/>')
        cover_html = '<div class="cover"><img src="images/cover.png" alt="الغلاف"/></div>'
        z.writestr('OEBPS/cover.xhtml', xhtml_page(title, cover_html))
        manifest.append('<item id="cover" href="cover.xhtml" media-type="application/xhtml+xml"/>')
        spine.append('<itemref idref="cover"/>')

    # صفحات المحتوى
    navpoints = []
    for pid, nav, fname, body, in_toc in pages:
        z.writestr('OEBPS/' + fname, xhtml_page(nav, body))
        manifest.append(f'<item id="{pid}" href="{fname}" media-type="application/xhtml+xml"/>')
        spine.append(f'<itemref idref="{pid}"/>')
        if in_toc:
            navpoints.append((nav, fname))

    # nav.xhtml (EPUB3)
    nav_items = ''.join(f'<li><a href="{f}">{esc(t)}</a></li>' for t, f in navpoints)
    z.writestr('OEBPS/nav.xhtml', xhtml_page('الفهرس',
        f'<nav epub:type="toc" xmlns:epub="http://www.idpf.org/2007/ops" id="toc">'
        f'<h1>الفهرس</h1><ol>{nav_items}</ol></nav>'))

    # content.opf
    meta_cover = '<meta name="cover" content="coverimg"/>' if has_cover else ''
    opf = ('<?xml version="1.0" encoding="utf-8"?>\n'
        '<package xmlns="http://www.idpf.org/2007/opf" version="3.0" '
        'unique-identifier="bookid" xml:lang="ar">\n'
        '<metadata xmlns:dc="http://purl.org/dc/elements/1.1/">\n'
        f'<dc:identifier id="bookid">{uid}</dc:identifier>\n'
        f'<dc:title>{esc(title)}</dc:title>\n'
        f'<dc:creator>{esc(author)}</dc:creator>\n'
        f'<dc:language>{lang}</dc:language>\n'
        f'<dc:date>{today}</dc:date>\n'
        '<dc:rights>CC BY-ND 4.0</dc:rights>\n'
        f'<meta property="dcterms:modified">{today}T00:00:00Z</meta>\n'
        f'{meta_cover}\n</metadata>\n'
        f'<manifest>{"".join(manifest)}</manifest>\n'
        f'<spine page-progression-direction="rtl">{"".join(spine)}</spine>\n'
        '</package>')
    z.writestr('OEBPS/content.opf', opf)
    z.close()
    print(f'✔ {out_path}  ({len(pages)} صفحة، {os.path.getsize(out_path)//1024} كيلوبايت)')

if __name__ == '__main__':
    main()
