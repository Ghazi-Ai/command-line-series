#import "/lib/theme.typ": COLOR, FONT
#import "/lib/publication.typ": title-footer

#page(header: none, footer: none, numbering: none, {
  set align(center)
  v(1.1fr)
  text(font: FONT.bodyAr, size: 11pt, fill: COLOR.primary, weight: 600)[
    افهم · صمّم · نفّذ · اختبر · استعد · وثّق · سلّم
  ]
  v(1.8fr)
  text(font: FONT.displayAr, size: 48pt, weight: 800, fill: COLOR.primaryDeep, dir: ltr)[10+]
  v(8pt, weak: true)
  text(font: FONT.displayAr, size: 37pt, weight: 800, fill: COLOR.primaryDeep)[
    مشاريع كبرى\
    من الطرفية
  ]
  v(24pt, weak: true)
  line(length: 28%, stroke: 1.5pt + COLOR.accent)
  v(20pt, weak: true)
  text(font: FONT.bodyAr, size: 12.8pt, fill: COLOR.ink, weight: 600)[
    من أول ملف منظم إلى خادمٍ محمي ومختبر أمن أخلاقي
  ]
  v(2.2fr)
  text(font: FONT.bodyAr, size: 12.5pt, fill: COLOR.ink, weight: 700)[
    المهندس غازي السيف
  ]
  v(9pt, weak: true)
  text(font: FONT.bodyAr, size: 10pt, fill: COLOR.muted)[أبو هيثم]
  v(1.1fr)
  text(font: FONT.bodyAr, size: 9pt, fill: COLOR.muted)[
    #title-footer[الكتاب العاشر]
  ]
  v(0.6fr)
})
