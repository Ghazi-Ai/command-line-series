// الغلاف الأمامي — الفن بلا نص، والعنوان يضاف في Typst.
#import "/lib/theme.typ": FONT
#import "/lib/publication.typ": cover-author-credit

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  place(top + left, image(
    "/books/8-server/ar/assets/cover-front.png",
    width: 148mm,
    height: 210mm,
  ))

  place(top + center, dy: 15mm, block(width: 100%, {
    set align(center)
    text(font: FONT.displayAr, size: 30pt, weight: 800, fill: rgb("#145A54"))[
      الخادمُ الذي \
      لا ينام
    ]
    v(5mm)
    text(font: FONT.bodyAr, size: 11.2pt, weight: 600, fill: rgb("#176B63"))[
      دليلك لإدارة خادم أوبونتو بثقة
    ]
  }))

  place(bottom + center, dy: -7mm, cover-author-credit())
})
