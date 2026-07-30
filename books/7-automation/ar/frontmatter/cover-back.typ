#import "/lib/theme.typ": FONT
#import "/lib/publication.typ": cover-license-line

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, fill: rgb("#EAF4F1"), {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  place(top + left, rect(width: 148mm, height: 28mm, fill: rgb("#163E48")))
  place(bottom + right, dx: -15mm, dy: -34mm, circle(radius: 19mm, stroke: 1.2pt + rgb("#4FB89D")))

  place(top + center, dy: 38mm, block(width: 80%, {
    set align(center)
    set text(font: FONT.bodyAr, fill: rgb("#163038"))
    set par(leading: 0.92em, spacing: 1em)

    text(font: FONT.displayAr, size: 17pt, weight: 700, fill: rgb("#174B51"))[مِن الأمر إلى الأتمتة]
    v(7mm)

    text(size: 10.5pt)[
      الأمر الذي تنفّذه مرةً يحلّ مشكلة. أمّا الأداة التي تفهمها
      وتختبرها وتستطيع التراجع عنها، فتستردّ وقتك كلّ يوم.
    ]
    v(5mm)

    text(size: 10.5pt)[
      يأخذك هذا الكتاب من مهمة متكررة إلى سكربت موثوق، ثم إلى أداة
      ذات سجل واختبارات وإعدادات وجدولة. تتعلم متى تنفذ بنفسك، ومتى
      تفوض وكيلًا، وما الدليل الذي تطلبه قبل أن تقول: نجح العمل.
    ]
    v(6mm)

    text(size: 10.5pt, style: "italic", fill: rgb("#276E69"))[
      لا تجعل الآلة تعمل بدلًا منك فحسب؛ اجعلها تعمل وفق قرارك.
    ]
  }))

  place(bottom + center, dy: -14mm, block(width: 84%, {
    set align(center)
    text(font: FONT.bodyAr, size: 9.5pt, weight: 700, fill: rgb("#163038"))[
      المهندس غازي السيف (أبو هيثم)
    ]
    v(2.5mm)
    text(font: FONT.bodyAr, size: 7.2pt, fill: rgb("#41635F"))[#cover-license-line]
  }))
})

