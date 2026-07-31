// الغلاف الخلفي — الفن بلا نص، والنبذة تضاف في Typst.
#import "/lib/theme.typ": FONT
#import "/lib/publication.typ": cover-license-line

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  place(top + left, image(
    "/books/9-network/ar/assets/cover-back.png",
    width: 148mm,
    height: 210mm,
  ))

  place(top + center, dy: 31mm, block(width: 80%, {
    set align(center)
    set text(font: FONT.bodyAr, fill: rgb("#26242E"))
    set par(leading: 0.95em, spacing: 1em)

    text(font: FONT.displayAr, size: 15pt, weight: 700, fill: rgb("#145A54"))[
      الشبكةُ من الطرفية
    ]
    v(7mm)

    text(size: 9.8pt)[
      حين تتوقف خدمة، لا يخبرك المتصفح أين ضاعت الطريق. هل غاب
      الاسم؟ أم اختل العنوان؟ أم لم تصل الحزمة؟ أم وصلت إلى باب
      لا يستمع خلفه أحد؟
    ]
    v(8mm)

    text(size: 9.8pt)[
      يحول هذا الكتاب الشبكة من سحابة غامضة إلى سلسلة أسئلة
      قابلة للاختبار: واجهة وعنوان، جار وبوابة، اسم وطريق، منفذ
      ومحادثة واتصال مشفر. تبدأ بالقراءة، وتعزل الطبقة، وتغيّر أقل
      قدر، ثم تثبت أن الخدمة عادت.
    ]
    v(8mm)

    text(size: 9.8pt, style: "italic", fill: rgb("#176B63"))[
      لا تطارد الحزمة في الظلام؛ أشعل مصباحًا عند كل قفزة.
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
