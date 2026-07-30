// غلاف تطويري مرسوم داخل Typst؛ الفن النهائي يحتاج اعتمادًا مستقلًا.
#import "/lib/theme.typ": FONT

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, fill: rgb("#102D35"), {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  place(top + left, dx: 0mm, dy: 0mm, rect(width: 148mm, height: 54mm, fill: rgb("#163E48")))
  place(top + right, dx: -16mm, dy: 70mm, circle(radius: 24mm, stroke: 1.2pt + rgb("#4FB89D")))
  place(top + right, dx: -27mm, dy: 81mm, circle(radius: 13mm, stroke: 1pt + rgb("#E7B95A")))
  place(bottom + left, dx: 15mm, dy: -42mm, rect(width: 58mm, height: 2mm, fill: rgb("#4FB89D"), radius: 1mm))

  place(top + center, dy: 20mm, block(width: 100%, {
    set align(center)
    text(font: FONT.displayAr, size: 32pt, weight: 800, fill: white)[
      مِن الأمر \
      إلى الأتمتة
    ]
    v(6mm)
    text(font: FONT.bodyAr, size: 12pt, weight: 600, fill: rgb("#D6EEE8"))[
      كيف تحوّل أوامر الطرفية إلى أدوات تعمل من أجلك
    ]
  }))

  place(left + horizon, dx: 17mm, dy: 23mm, block(width: 82mm, {
    set text(font: FONT.mono, size: 9pt, fill: rgb("#B6D8D0"), dir: ltr)
    [\$ plan → run → verify → recover]
  }))

  place(bottom + center, dy: -16mm, block(width: 100%, {
    set align(center)
    text(font: FONT.bodyAr, size: 12pt, weight: 700, fill: white)[المهندس غازي السيف]
    v(2.5mm)
    text(font: FONT.bodyAr, size: 9.5pt, fill: rgb("#B6D8D0"))[أبو هيثم]
  }))
})
