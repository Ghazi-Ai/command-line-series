// ═══════════════════════════════════════════════════════════════════════════
//  المكوّنات (Components) — الصناديق التعليمية والعناصر الدقيقة
//  كل صندوق يقرأ لغة الكتاب من الحالة العامّة فيختار تسميته واتجاه شريطه تلقائيًا.
// ═══════════════════════════════════════════════════════════════════════════

#import "theme.typ": COLOR, FONT, SIZE
#import "i18n.typ": STRINGS

// لغة الكتاب الحالية (يضبطها قالب book). الصناديق تقرؤها لتعرف تسمياتها.
#let doc-lang = state("z2r-lang", "ar")

// ── الصندوق العام ─────────────────────────────────────────────────────────
// شريط لونيّ جانبيّ (يمين في العربية، يسار في الإنجليزية) + عنوان + متن.
#let callout(key, fg, bg, body, strong: false) = context {
  let l = doc-lang.get()
  let label = STRINGS.at(l).at(key)
  let bar = if l == "ar" { (right: (if strong { 3pt } else { 2.2pt }) + fg) }
            else { (left: (if strong { 3pt } else { 2.2pt }) + fg) }
  block(
    width: 100%,
    fill: bg,
    inset: (x: 12pt, y: 10pt),
    radius: 4pt,
    stroke: bar,
    breakable: true,
    above: 1.1em, below: 1.1em,
    [
      #text(font: FONT.bodyAr, weight: 700, fill: fg, size: SIZE.small)[#label]
      #v(4pt, weak: true)
      #set text(size: SIZE.small, fill: COLOR.ink)
      #set par(leading: 1.0em)
      #body
    ],
  )
}

// ── الصناديق الجاهزة ──────────────────────────────────────────────────────
#let note(body)   = callout("note",    COLOR.info,   COLOR.infoTint,   body)
#let tip(body)    = callout("tip",     COLOR.primary,COLOR.primaryTint,body)
#let warn(body)   = callout("warning", COLOR.warn,   COLOR.warnTint,   body)
#let danger(body) = callout("danger",  COLOR.danger, COLOR.dangerTint, body)
#let distro(body) = callout("distro",  COLOR.info,   COLOR.infoTint,   body)
#let ethics(body) = callout("ethics",  COLOR.danger, COLOR.dangerTint, body, strong: true)
#let deep(body)   = callout("deep",    COLOR.muted,  luma(244),        body)

// «جرّب بنفسك» — الصندوق العمليّ الأبرز (طوبيّ، شريط أعرض).
#let try-it(body) = callout("try", COLOR.accent, COLOR.accentTint, body, strong: true)

// ── تعريف مصطلح ───────────────────────────────────────────────────────────
#let define(term, body) = context {
  let l = doc-lang.get()
  block(
    width: 100%, fill: COLOR.primaryTint, radius: 4pt,
    inset: (x: 12pt, y: 10pt), above: 1.1em, below: 1.1em, breakable: true,
    [
      #text(font: FONT.bodyAr, weight: 700, fill: COLOR.primaryDeep, size: SIZE.small)[
        #STRINGS.at(l).at("define") · #term
      ]
      #v(4pt, weak: true)
      #set text(size: SIZE.small, fill: COLOR.ink)
      #set par(leading: 1.0em)
      #body
    ],
  )
}

// ── تحدّي الفصل ───────────────────────────────────────────────────────────
// بطاقة كاملة الإطار بشريط عنوان — العنصر الختاميّ لكل فصل.
#let challenge(body) = context {
  let l = doc-lang.get()
  block(
    width: 100%, radius: 5pt, clip: true, breakable: true,
    stroke: 1pt + COLOR.primaryDeep, above: 1.4em, below: 1.2em,
    [
      #block(width: 100%, fill: COLOR.primaryDeep, inset: (x: 12pt, y: 7pt),
        text(font: FONT.displayAr, weight: 700, fill: white, size: SIZE.small)[
          #STRINGS.at(l).at("challenge")
        ])
      #block(inset: (x: 12pt, y: 11pt), {
        set text(size: SIZE.small, fill: COLOR.ink)
        set par(leading: 1.0em)
        body
      })
    ],
  )
}

// ── أهداف الفصل ───────────────────────────────────────────────────────────
// صندوق «في هذا الفصل ستتعلّم» تحت عنوان الفصل مباشرة.
#let objectives(items) = context {
  let l = doc-lang.get()
  block(
    width: 100%, fill: luma(247), radius: 4pt,
    inset: (x: 13pt, y: 11pt), above: 0.6em, below: 1.6em, breakable: false,
    [
      #text(font: FONT.bodyAr, weight: 700, fill: COLOR.primaryDeep, size: SIZE.small)[
        #STRINGS.at(l).at("objectives")
      ]
      #v(6pt, weak: true)
      #set text(size: SIZE.small, fill: COLOR.ink)
      #set par(leading: 0.95em)
      #for it in items [
        #box(baseline: -0.5pt, text(fill: COLOR.accent, weight: 700)[◂]) #h(4pt) #it #linebreak()
      ]
    ],
  )
}

// ── مفتاح لوحة المفاتيح (Ctrl+C) ───────────────────────────────────────────
#let kbd(k) = box(
  baseline: 2pt, fill: luma(250), inset: (x: 4pt, y: 1pt), radius: 3pt,
  stroke: 0.6pt + COLOR.rule,
  text(font: FONT.mono, size: 8.5pt, fill: COLOR.ink)[#k],
)

// ── جلسة طرفية: أمر + ناتج ─────────────────────────────────────────────────
// يعرض الأمر بمحثّ $ ثم ناتجه بلون خافت. المحتوى دائمًا يساريّ LTR.
#let session(cmd, output: none) = block(
  width: 100%, fill: COLOR.codeBg, radius: 4pt,
  stroke: (left: 2.2pt + COLOR.primary),
  inset: (x: 11pt, y: 9pt), above: 1em, below: 1em, breakable: true,
  {
    set text(font: FONT.mono, size: SIZE.code, dir: ltr)
    set par(justify: false, leading: 0.65em)
    align(left)[
      #text(fill: COLOR.primary, weight: 700)[\$ ] #text(fill: COLOR.ink)[#cmd] \
      #if output != none {
        text(fill: COLOR.muted)[#output]
      }
    ]
  },
)
