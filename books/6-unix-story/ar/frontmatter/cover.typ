// صفحة الغلاف الأماميّ — الفنّ الجاهز مع العنوان مطبوعًا فوقه
#import "/lib/theme.typ": FONT

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  // الفنّ يملأ الصفحة
  place(top + left, image("/books/6-unix-story/ar/assets/cover-front.png", width: 148mm, height: 210mm))

  // العنوان أعلى الصفحة، فوق الهالة
  place(top + center, dy: 15mm, block(width: 100%, {
    set align(center)
    text(font: FONT.displayAr, size: 30pt, weight: 800, fill: rgb("#363B5E"))[
      رُوحٌ \
      في الآلة
    ]
    v(5mm)
    text(font: FONT.bodyAr, size: 12pt, weight: 600, fill: rgb("#3D4270"))[حكايةُ يونِكس]
  }))

  // المؤلّف أسفل الصفحة
  place(bottom + center, dy: -16mm, block(width: 100%, {
    set align(center)
    text(font: FONT.bodyAr, size: 12pt, weight: 700, fill: rgb("#26242E"))[المهندس غازي السيف]
    v(2.5mm)
    text(font: FONT.bodyAr, size: 9.5pt, fill: rgb("#4A4857"))[أبو هيثم]
  }))
})
