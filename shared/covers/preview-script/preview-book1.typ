#import "/home/ghazi/Desktop/zero-to-root/lib/theme.typ": COLOR, FONT

#set page(width: 148mm, height: 210mm, margin: 0pt)
#set text(lang: "ar", dir: rtl)
#set par(justify: false)

// ── الغلاف الأمامي ──
#page(width: 148mm, height: 210mm, margin: 0pt, {
  place(image("front.png", width: 148mm, height: 210mm))
  place(top + center, dy: 20mm, block(width: 100%, {
    set align(center)
    text(font: FONT.displayAr, size: 24pt, weight: 800, fill: rgb("#164A3E"))[
      مِن الصِّفر إلى الجَذر
    ]
    v(5mm)
    text(font: FONT.bodyAr, size: 10pt, weight: 600, fill: rgb("#26242E"))[
      الدليل الشامل إلى سطر الأوامر ولِينُكس
    ]
  }))
  place(bottom + center, dy: -14mm, block(width: 100%, {
    set align(center)
    text(font: FONT.bodyAr, size: 11pt, weight: 700, fill: rgb("#26242E"))[
      المهندس غازي السيف
    ]
    v(2mm)
    text(font: FONT.bodyAr, size: 9pt, fill: rgb("#6E6B78"))[أبو هيثم]
  }))
})

// ── الغلاف الخلفي ──
#page(width: 148mm, height: 210mm, margin: 0pt, {
  place(image("back.png", width: 148mm, height: 210mm))
  place(center + horizon, dy: -6mm, block(width: 82%, {
    set align(center)
    set text(font: FONT.bodyAr, size: 9.5pt, fill: rgb("#26242E"))
    set par(leading: 0.95em, spacing: 1.1em)
    text(weight: 700, size: 12pt, fill: rgb("#164A3E"))[مِن الصِّفر إلى الجَذر]
    v(5mm)
    [شاشةٌ سوداء ومؤشّرٌ يومض… من هنا يبدأ كلّ محترف. هذا الكتاب يأخذ بيدك من الصِّفر المطلق حتى تُتقن سطر الأوامر ولِينُكس وتصير سيّدَ الآلة لا مستخدمَها.]
    v(11mm)
    [رحلةٌ في تسعة أجزاء وسبعةٍ وأربعين فصلًا، بأسلوب: مفهوم ← جرّب بنفسك ← تحدٍّ.]
    v(6mm)
    line(length: 30%, stroke: 0.6pt + rgb("#C0592B"))
    v(6mm)
    text(size: 8.5pt, fill: rgb("#6E6B78"))[
      المهندس غازي السيف (أبو هيثم)
    ]
    v(2mm)
    text(size: 7.5pt, fill: rgb("#6E6B78"))[
      مفتوح المصدر · CC BY-ND 4.0 · github.com/Ghazi-Ai/command-line-series
    ]
  }))
})
