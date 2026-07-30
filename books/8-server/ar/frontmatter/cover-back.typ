// الغلاف الخلفي — الفن بلا نص، والنبذة تضاف في Typst.
#import "/lib/theme.typ": FONT
#import "/lib/publication.typ": cover-license-line

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  place(top + left, image(
    "/books/8-server/ar/assets/cover-back.png",
    width: 148mm,
    height: 210mm,
  ))

  place(top + center, dy: 29mm, block(width: 80%, {
    set align(center)
    set text(font: FONT.bodyAr, fill: rgb("#26242E"))
    set par(leading: 0.95em, spacing: 1em)

    text(font: FONT.displayAr, size: 15pt, weight: 700, fill: rgb("#145A54"))[
      الخادمُ الذي لا ينام
    ]
    v(7mm)

    text(size: 9.8pt)[
      تستأجر خادمًا في طرف العالم، ثم تضع مفتاحه في يد وكيل وتنتظر
      منه أن يقول لك: انتهى. لكن ماذا تعمل الآلة؟ وأي باب فُتح؟
      وكيف تعرف أن النسخة الاحتياطية ستعيدها حقًا؟
    ]
    v(8mm)

    text(size: 9.8pt)[
      يأخذك هذا الكتاب من أول اتصال إلى خدمة مستقرة: مستخدمون
      وصلاحيات، خدمات وسجلات، تحديثات وجدار ناري، نشر ومراقبة ونسخ
      واستعادة. لا لتستغني عن الوكلاء، بل لتصبح أنت صاحب القرار
      والدليل وطريق الرجوع.
    ]
    v(8mm)

    text(size: 9.8pt, style: "italic", fill: rgb("#176B63"))[
      حين تنام أنت، ينبغي أن تعرف لماذا بقي خادمك مستيقظًا.
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
