// الهوية المعروضة في README.
// التوليد:
// typst compile --font-path ../../fonts --ppi 240 series-identity.typ series-identity.png

#set page(
  width: 160mm,
  height: 105mm,
  margin: 0mm,
  fill: none,
)

#let green = rgb("#0f4d3c")
#let cream = rgb("#fff8dc")
#let orange = rgb("#c85c2c")

#place(
  center + top,
  dy: 6mm,
  image("series-mark.png", height: 57mm),
)

#place(
  center + top,
  dy: 65mm,
  text(
    font: "Noto Kufi Arabic",
    size: 25pt,
    weight: "bold",
    fill: green,
    stroke: 0.55pt + cream,
    lang: "ar",
    dir: rtl,
  )[سلسلة سطر الأوامر],
)

#place(
  center + top,
  dy: 94mm,
  line(length: 116mm, stroke: 1.2pt + orange),
)
