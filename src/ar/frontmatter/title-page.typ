// صفحة العنوان — «من الصِّفر إلى الجذر»
#import "/src/lib/theme.typ": COLOR, FONT

#page(header: none, footer: none, numbering: none, {
  set align(center)
  v(1.4fr)
  text(dir: ltr, font: FONT.mono, size: 11pt, fill: COLOR.primary, weight: 600)[ghazi\@linux:\~\$]
  v(2.4fr)
  text(font: FONT.displayAr, size: 44pt, weight: 800, fill: COLOR.primaryDeep)[
    مِن الصِّفر\
    إلى الجَذر
  ]
  v(20pt, weak: true)
  line(length: 28%, stroke: 1.5pt + COLOR.accent)
  v(16pt, weak: true)
  text(font: FONT.bodyAr, size: 13.5pt, fill: COLOR.ink, weight: 600)[
    الدليل الشامل إلى سطر الأوامر ولِينُكس
  ]
  v(6pt, weak: true)
  text(font: FONT.bodyAr, size: 10.5pt, fill: COLOR.muted)[
    من أوّل أمرٍ إلى احتراف النظام
  ]
  v(2.6fr)
  text(font: FONT.bodyAr, size: 12.5pt, fill: COLOR.ink, weight: 700)[
    المهندس غازي السيف
  ]
  v(3pt, weak: true)
  text(font: FONT.bodyAr, size: 10pt, fill: COLOR.muted)[أبو هيثم]
  v(1.2fr)
  text(font: FONT.bodyAr, size: 9pt, fill: COLOR.muted)[
    النسخة العربية · مسودة أولى
  ]
  v(0.7fr)
})
