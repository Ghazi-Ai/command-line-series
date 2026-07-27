// الغلاف الخلفيّ — الفنّ الجاهز مع النبذة مطبوعةً فوقه
#import "/lib/theme.typ": FONT
#import "/lib/publication.typ": cover-license-line

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  place(top + left, image("/books/3-windows/ar/assets/cover-back.png", width: 148mm, height: 210mm))

  place(top + center, dy: 38mm, block(width: 80%, {
    set align(center)
    set text(font: FONT.bodyAr, fill: rgb("#26242E"))
    set par(leading: 0.9em, spacing: 0.9em)

    text(font: FONT.displayAr, size: 15pt, weight: 700, fill: rgb("#5E3E0A"))[مِن الصِّفر إلى المسؤول]
    v(6mm)

    text(size: 10pt)[ويندوزُ أكثرُ من فأرةٍ ونوافذ. تحت سطحه ثلاثُ طرفيّاتٍ قويّة: CMD العتيق، وPowerShell الحديث، وWSL الذي يضعُ لِينُكس كاملًا داخل ويندوز.]
    v(6mm)

    text(size: 10pt)[يقودُك هذا الكتابُ من أوّل أمرٍ إلى إدارةِ النظامِ باقتدار: الملفّاتُ والعمليّات، والخدماتُ والشبكة، والأتمتةُ بـPowerShell — حتى تصيرَ مسؤولَ جهازك حقًّا.]
    v(6mm)

    text(size: 10pt)[بالعربيّةِ الواضحة، وأمثلةٍ تُجرَّب، ومقارناتٍ تربطُ ويندوزَ بعالم يونِكس.]
    v(7mm)

    text(size: 10pt, style: "italic", fill: rgb("#7A5410"))[CMD وPowerShell وWSL — من أوّل أمرٍ إلى احتراف النظام.]
  }))

  place(bottom + center, dy: -14mm, block(width: 82%, {
    set align(center)
    text(font: FONT.bodyAr, size: 9.5pt, weight: 700, fill: rgb("#26242E"))[المهندس غازي السيف (أبو هيثم)]
    v(2.5mm)
    text(font: FONT.bodyAr, size: 7.2pt, fill: rgb("#4A4857"))[#cover-license-line]
  }))
})
