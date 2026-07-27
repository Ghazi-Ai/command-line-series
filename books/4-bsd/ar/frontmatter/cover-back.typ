// الغلاف الخلفيّ — الفنّ الجاهز مع النبذة مطبوعةً فوقه
#import "/lib/theme.typ": FONT
#import "/lib/publication.typ": cover-license-line

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  place(top + left, image("/books/4-bsd/ar/assets/cover-back.png", width: 148mm, height: 210mm))

  place(top + center, dy: 38mm, block(width: 80%, {
    set align(center)
    set text(font: FONT.bodyAr, fill: rgb("#26242E"))
    set par(leading: 0.9em, spacing: 0.9em)

    text(font: FONT.displayAr, size: 15pt, weight: 700, fill: rgb("#5E1A13"))[مِن الصِّفر إلى العِفريت]
    v(6mm)

    text(size: 10pt)[عفريتُ BSD ليس شيطانًا، بل حارسُ أعرقِ أنظمةِ يونِكس الحيّة. FreeBSD وOpenBSD وNetBSD تُشغّلُ خوادمَ العالمِ وأشدَّها أمانًا في صمتٍ وإتقان.]
    v(6mm)

    text(size: 10pt)[يأخذُك هذا الكتابُ من الصِّفر إلى إتقانِ BSD: من الأساساتِ إلى ZFS والـjails وpf والمنافذِ (ports) — بفلسفةٍ تختلفُ عن لِينُكس وتستحقُّ أن تُفهَم.]
    v(6mm)

    text(size: 10pt)[إن أتقنتَ لِينُكس ثمّ عبرتَ إلى BSD، فهمتَ يونِكسَ على حقيقته.]
    v(7mm)

    text(size: 10pt, style: "italic", fill: rgb("#7A241B"))[من أوّل أمرٍ إلى احتراف النظام.]
  }))

  place(bottom + center, dy: -14mm, block(width: 82%, {
    set align(center)
    text(font: FONT.bodyAr, size: 9.5pt, weight: 700, fill: rgb("#26242E"))[المهندس غازي السيف (أبو هيثم)]
    v(2.5mm)
    text(font: FONT.bodyAr, size: 7.2pt, fill: rgb("#4A4857"))[#cover-license-line]
  }))
})
