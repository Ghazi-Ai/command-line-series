// الغلاف الأمامي — الفن بلا نص، والعنوان يضاف في Typst.
#import "/lib/theme.typ": FONT

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  place(top + left, image(
    "/books/9-network/ar/assets/cover-front.png",
    width: 148mm,
    height: 210mm,
  ))

  place(top + center, dy: 15mm, block(width: 100%, {
    set align(center)
    text(font: FONT.displayAr, size: 30pt, weight: 800, fill: rgb("#145A54"))[
      الشبكةُ \
      من الطرفية
    ]
    v(5mm)
    text(font: FONT.bodyAr, size: 11.2pt, weight: 600, fill: rgb("#176B63"))[
      افهم الطريق بين جهازك والعالم وشخّصه خطوة خطوة
    ]
  }))

  place(bottom + center, dy: -16mm, block(width: 100%, {
    set align(center)
    text(font: FONT.bodyAr, size: 12pt, weight: 700, fill: rgb("#26242E"))[
      المهندس غازي السيف
    ]
    v(2.5mm)
    text(font: FONT.bodyAr, size: 9.5pt, fill: rgb("#4A4857"))[أبو هيثم]
  }))
})
