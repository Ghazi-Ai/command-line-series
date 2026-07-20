// صفحة العنوان — كتاب «ماك من الطرفية»
#import "/lib/theme.typ": COLOR, FONT

#page(header: none, footer: none, numbering: none, {
  set align(center)
  v(1.4fr)
  text(dir: ltr, font: FONT.mono, size: 11pt, fill: COLOR.primary, weight: 600)[ghazi\@mac \~ %]
  v(2.4fr)
  text(font: FONT.displayAr, size: 46pt, weight: 800, fill: COLOR.primaryDeep)[
    ماك من الطرفية
  ]
  v(28pt, weak: true)
  line(length: 28%, stroke: 1.5pt + COLOR.accent)
  v(24pt, weak: true)
  text(font: FONT.bodyAr, size: 13.5pt, fill: COLOR.ink, weight: 600)[
    الدليل الشامل إلى سطر الأوامر على macOS
  ]
  v(13pt, weak: true)
  text(font: FONT.bodyAr, size: 10.5pt, fill: COLOR.muted)[
    من أوّل أمرٍ إلى احتراف النظام
  ]
  v(2.6fr)
  text(font: FONT.bodyAr, size: 12.5pt, fill: COLOR.ink, weight: 700)[
    المهندس غازي السيف
  ]
  v(9pt, weak: true)
  text(font: FONT.bodyAr, size: 10pt, fill: COLOR.muted)[أبو هيثم]
  v(1.2fr)
  text(font: FONT.bodyAr, size: 9pt, fill: COLOR.muted)[
    سلسلة سطر الأوامر · الكتاب الثاني · النسخة العربية
  ]
  v(0.7fr)
})
