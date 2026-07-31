#import "/lib/theme.typ": COLOR, FONT
#import "/lib/publication.typ": title-footer

#page(header: none, footer: none, numbering: none, {
  set align(center)
  v(1.4fr)
  text(font: FONT.bodyAr, size: 11pt, fill: COLOR.primary, weight: 600)[
    لاحظ · سمِّ الطبقة · اختبر · اعزل · أصلح · أثبت
  ]
  v(2.2fr)
  text(font: FONT.displayAr, size: 44pt, weight: 800, fill: COLOR.primaryDeep)[
    الشبكةُ\
    من الطرفية
  ]
  v(26pt, weak: true)
  line(length: 28%, stroke: 1.5pt + COLOR.accent)
  v(22pt, weak: true)
  text(font: FONT.bodyAr, size: 13.2pt, fill: COLOR.ink, weight: 600)[
    افهم الطريق بين جهازك والعالم
  ]
  v(13pt, weak: true)
  text(font: FONT.bodyAr, size: 10.5pt, fill: COLOR.muted)[
    وشخّصه خطوة خطوة
  ]
  v(2.6fr)
  text(font: FONT.bodyAr, size: 12.5pt, fill: COLOR.ink, weight: 700)[
    المهندس غازي السيف
  ]
  v(9pt, weak: true)
  text(font: FONT.bodyAr, size: 10pt, fill: COLOR.muted)[أبو هيثم]
  v(1.2fr)
  text(font: FONT.bodyAr, size: 9pt, fill: COLOR.muted)[
    #title-footer[الكتاب التاسع]
  ]
  v(0.7fr)
})
