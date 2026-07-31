// الغلاف الخلفي — الفن بلا نص، والنبذة تضاف في Typst.
#import "/lib/theme.typ": FONT
#import "/lib/publication.typ": cover-license-line

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  place(top + left, image(
    "/books/10-projects/ar/assets/cover-back.png",
    width: 148mm,
    height: 210mm,
  ))

  place(top + center, dy: 25mm, block(width: 80%, {
    set align(center)
    set text(font: FONT.bodyAr, fill: rgb("#26242E"))
    set par(leading: 0.95em, spacing: 0.95em)

    text(font: FONT.displayAr, size: 15pt, weight: 700, fill: rgb("#145A54"))[
      10+ مشاريع كبرى من الطرفية
    ]
    v(6mm)

    text(size: 9.5pt)[
      المعرفة لا تصبح مهارة حين تحفظ الأمر، بل حين تبني به شيئًا
      يعمل، وتكسره بأمان، ثم تعيده وتسلّمه لغيرك.
    ]
    v(6mm)

    text(size: 9.5pt)[
      تبدأ المشروعات من جهازك وملفاتك، وتعبر النسخ الاحتياطي
      والأتمتة وبناء الخدمات، ثم تصل إلى إدارة خادم وشبكة ومراقبتهما،
      واختبار دفاعاتهما داخل مختبر أخلاقي مأذون.
    ]
    v(6mm)

    text(size: 9.5pt, style: "italic", fill: rgb("#176B63"))[
      لا نعطيك الأبواب كلها؛ نعطيك المفتاح وطريقة صنع مفتاحك التالي.
    ]
  }))

  place(bottom + center, dy: -13mm, block(width: 82%, {
    set align(center)
    text(font: FONT.bodyAr, size: 9.5pt, weight: 700, fill: rgb("#26242E"))[
      المهندس غازي السيف (أبو هيثم)
    ]
    v(2.5mm)
    text(font: FONT.bodyAr, size: 7.2pt, fill: rgb("#4A4857"))[
      #cover-license-line
    ]
  }))
})
