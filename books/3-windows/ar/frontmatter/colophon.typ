// صفحة الحقوق — «مِن الصِّفر إلى المسؤول» (ويندوز)
#import "/lib/theme.typ": COLOR, FONT

#page(header: none, footer: none, numbering: none, {
  set text(font: FONT.bodyAr, size: 9.5pt, fill: COLOR.ink)
  set par(leading: 0.85em, spacing: 0.9em)
  v(1fr)

  text(weight: 700, size: 11pt)[مِن الصِّفر إلى المسؤول]
  linebreak()
  text(fill: COLOR.muted)[الدليل الشامل إلى سطر الأوامر على ويندوز — من سلسلة سطر الأوامر (الكتاب الثالث)]

  v(1.4em)
  [© #text(font: FONT.mono)[2026] المهندس غازي السيف (أبو هيثم). جميع الحقوق محفوظة ضمن حدود الرخصة أدناه.]

  v(0.8em)
  text(weight: 700, fill: COLOR.primaryDeep)[الرخصة]
  linebreak()
  [منشورٌ برخصة *المشاع الإبداعي: النَّسْب — بلا اشتقاق، الإصدار الرابع الدولي* (CC BY‑ND 4.0). لك أن تقرأه وتشاركه وتعيد نشره كاملًا وحرفيًّا مع نَسْبه لمؤلّفه، ولا يحقّ نشر نسخةٍ معدّلة إلا بإذنٍ خطّيّ منه. النصّ الكامل في ملفّ #text(font: FONT.mono)[LICENSE].]

  v(1.2em)
  text(weight: 700, fill: COLOR.primaryDeep)[التواصل والمصدر]
  linebreak()
  grid(columns: (auto, 1fr), row-gutter: 0.4em, column-gutter: 10pt,
    text(fill: COLOR.muted)[المؤلف], [المهندس غازي السيف — أبو هيثم],
    text(fill: COLOR.muted)[التواصل], text(font: FONT.mono, size: 8.5pt)[github.com/Ghazi-Ai/command-line-series/issues],
    text(fill: COLOR.muted)[المستودع], text(font: FONT.mono, size: 8.5pt)[github.com/Ghazi-Ai/command-line-series],
  )

  v(1.2em)
  text(size: 8.5pt, fill: COLOR.muted)[
    صُفَّ بأداة #text(font: FONT.mono)[Typst]. المصادر المعتمدة في ملحق «المصادر والمراجع».
  ]
  v(0.8fr)
})
