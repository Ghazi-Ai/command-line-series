// English title page
#import "/src/lib/theme.typ": COLOR, FONT

#page(header: none, footer: none, numbering: none, {
  set align(center)
  v(1.4fr)
  text(dir: ltr, font: FONT.mono, size: 11pt, fill: COLOR.primary, weight: 600)[ghazi\@linux:\~\$]
  v(2.4fr)
  text(font: FONT.bodyLatin, size: 46pt, weight: 800, fill: COLOR.primaryDeep)[
    From Zero\
    to Root
  ]
  v(20pt, weak: true)
  line(length: 28%, stroke: 1.5pt + COLOR.accent)
  v(16pt, weak: true)
  text(font: FONT.bodyLatin, size: 13.5pt, fill: COLOR.ink, weight: 600)[
    The Complete Guide to the Command Line & Linux
  ]
  v(6pt, weak: true)
  text(font: FONT.bodyLatin, size: 10.5pt, fill: COLOR.muted)[
    From your first command to mastering the system
  ]
  v(2.6fr)
  text(font: FONT.bodyLatin, size: 12.5pt, fill: COLOR.ink, weight: 700)[
    Eng. Ghazi Alsaif
  ]
  v(3pt, weak: true)
  text(font: FONT.bodyLatin, size: 10pt, fill: COLOR.muted)[Abu Haitham]
  v(1.2fr)
  text(font: FONT.bodyLatin, size: 9pt, fill: COLOR.muted)[
    English edition · Early draft
  ]
  v(0.7fr)
})
