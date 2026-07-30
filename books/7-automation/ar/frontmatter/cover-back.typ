// الغلاف الخلفي — الفن الجاهز مع النبذة مطبوعة فوقه
#import "/lib/theme.typ": FONT
#import "/lib/publication.typ": cover-license-line

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  place(top + left, image(
    "/books/7-automation/ar/assets/cover-back.png",
    width: 148mm,
    height: 210mm,
  ))

  place(top + center, dy: 40mm, block(width: 80%, {
    set align(center)
    set text(font: FONT.bodyAr, fill: rgb("#26242E"))
    set par(leading: 0.95em, spacing: 1em)

    text(font: FONT.displayAr, size: 15pt, weight: 700, fill: rgb("#145A54"))[
      مِن الأمر إلى الأتمتة
    ]
    v(7mm)

    text(size: 10pt)[
      الأمر الذي تنفّذه مرة يحل مشكلة. أما الأداة التي تفهمها
      وتختبرها وتستطيع التراجع عنها، فتسترد وقتك كل يوم.
    ]
    v(9mm)

    text(size: 10pt)[
      يأخذك هذا الكتاب من مهمة متكررة إلى سكربت موثوق، ثم إلى أداة
      ذات سجل واختبارات وإعدادات وجدولة. تتعلم متى تنفذ بنفسك، ومتى
      تفوض وكيلًا، وما الدليل الذي تطلبه قبل أن تقول: نجح العمل.
    ]
    v(9mm)

    text(size: 10pt, style: "italic", fill: rgb("#176B63"))[
      لا تجعل الآلة تعمل بدلًا منك فحسب؛ اجعلها تعمل وفق قرارك.
    ]
  }))

  place(bottom + center, dy: -14mm, block(width: 82%, {
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
