// ═══════════════════════════════════════════════════════════════════════════
//  صناديق كتاب «الطرفية بالممارسة» (الكتاب الخامس)
//  ترتيب الأنظمة المعتمَد: ويندوز ← لِينُكس ← ماك ← BSD
// ═══════════════════════════════════════════════════════════════════════════
#import "/lib/theme.typ": COLOR, FONT

// ── تعريف الأنظمة الأربعة (الاسم، اللون من غلاف الكتاب، المحثّ) ──
#let SYS = (
  win:   (name: "ويندوز · PowerShell", color: rgb("#B07A1E"), prompt: "PS>"),
  linux: (name: "لِينُكس",             color: rgb("#C0592B"), prompt: "$"),
  mac:   (name: "ماك",                color: rgb("#4E7E9E"), prompt: "%"),
  bsd:   (name: "BSD",                color: rgb("#A5342B"), prompt: "$"),
)

// ── بطاقةُ حلٍّ لنظامٍ واحد ──
#let _sol(sys, cmd, output) = block(
  width: 100%, fill: sys.color.lighten(90%), radius: 4pt,
  stroke: (right: 3pt + sys.color), inset: (x: 9pt, y: 6pt), below: 5pt, breakable: false,
  {
    text(font: FONT.displayAr, size: 8.5pt, weight: 700, fill: sys.color)[#sys.name]
    v(2pt, weak: true)
    block(fill: white, radius: 3pt, inset: (x: 7pt, y: 5pt), width: 100%, {
      set text(font: FONT.mono, size: 8.5pt, fill: COLOR.ink, dir: ltr)
      set par(justify: false, leading: 0.55em)
      align(left)[#text(fill: sys.color, weight: 700)[#sys.prompt]#h(5pt)#cmd]
      if output != none {
        v(2.5pt, weak: true)
        align(left)[#text(fill: COLOR.muted)[#output]]
      }
    })
  }
)
#let win(cmd, output: none)   = _sol(SYS.win, cmd, output)
#let linux(cmd, output: none) = _sol(SYS.linux, cmd, output)
#let mac(cmd, output: none)   = _sol(SYS.mac, cmd, output)
#let bsd(cmd, output: none)   = _sol(SYS.bsd, cmd, output)

// ── عنوان التمرين (الرقم، العنوان، المستوى) ──
#let ex(num, title, level) = block(
  width: 100%, fill: COLOR.primary.lighten(85%), radius: 5pt,
  inset: (x: 11pt, y: 9pt), above: 13pt, below: 8pt, breakable: false,
  grid(columns: (1fr, auto), align: (right + horizon, left + horizon), column-gutter: 8pt,
    text(font: FONT.displayAr, size: 12pt, weight: 800, fill: COLOR.primaryDeep)[تمرين #num — #title],
    box(fill: rgb("#B8860B").lighten(72%), radius: 3pt, inset: (x: 6pt, y: 3pt),
      text(font: FONT.bodyAr, size: 7pt, weight: 700, fill: rgb("#6E5109"))[#level]),
  )
)

// ── الهدف والمهمّة ──
#let goal(body) = par(text(weight: 700, fill: COLOR.primaryDeep)[الهدف: ] + body)
#let doit(body) = par(text(weight: 700, fill: COLOR.primaryDeep)[المهمّة: ] + body)

// ── صندوق «لاحظِ الفرق» ──
#let diff(body) = block(
  width: 100%, fill: rgb("#FBF3E8"), radius: 4pt,
  stroke: (right: 3pt + rgb("#B07A1E")), inset: (x: 10pt, y: 7pt), above: 6pt, below: 9pt, breakable: false,
  {
    text(font: FONT.displayAr, size: 8.5pt, weight: 700, fill: rgb("#8A5A12"))[لاحظِ الفرق]
    v(2pt, weak: true)
    body
  }
)

// ── صندوق «تحدٍّ» (اختياريّ) ──
#let ex-challenge(body) = block(
  width: 100%, fill: COLOR.accent.lighten(90%), radius: 4pt,
  stroke: (right: 3pt + COLOR.accent), inset: (x: 10pt, y: 7pt), above: 6pt, below: 9pt, breakable: false,
  {
    text(font: FONT.displayAr, size: 8.5pt, weight: 700, fill: COLOR.accent)[تحدٍّ]
    v(2pt, weak: true)
    body
  }
)
