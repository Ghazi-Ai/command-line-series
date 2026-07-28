// صفحة العنوان — «رُوحٌ في الآلة»
#import "/lib/theme.typ": COLOR, FONT
#import "/lib/publication.typ": title-footer

#page(header: none, footer: none, numbering: none, {
  set align(center)
  v(1.4fr)
  text(dir: ltr, font: FONT.mono, size: 11pt, fill: COLOR.primary, weight: 600)[1969 → ∞]
  v(2.4fr)
  text(font: FONT.displayAr, size: 44pt, weight: 800, fill: COLOR.primaryDeep)[
    رُوحٌ\
    في الآلة
  ]
  v(28pt, weak: true)
  line(length: 28%, stroke: 1.5pt + COLOR.accent)
  v(24pt, weak: true)
  text(font: FONT.bodyAr, size: 13.5pt, fill: COLOR.ink, weight: 600)[
    حكايةُ يونِكس
  ]
  v(13pt, weak: true)
  text(font: FONT.bodyAr, size: 10.5pt, fill: COLOR.muted)[
    الفكرةُ التي تحكم العالم من الظلّ
  ]
  v(2.6fr)
  text(font: FONT.bodyAr, size: 12.5pt, fill: COLOR.ink, weight: 700)[
    المهندس غازي السيف
  ]
  v(9pt, weak: true)
  text(font: FONT.bodyAr, size: 10pt, fill: COLOR.muted)[أبو هيثم]
  v(1.2fr)
  text(font: FONT.bodyAr, size: 9pt, fill: COLOR.muted)[
    #title-footer[الكتاب السادس]
  ]
  v(0.7fr)
})
