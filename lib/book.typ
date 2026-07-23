// ═══════════════════════════════════════════════════════════════════════════
//  القالب الرئيس (Master Template) — «من الصِّفر إلى الجذر»
//  يضبط الصفحة والخطوط والعناوين وأغلفة الفصول والأجزاء وتنسيق الأكواد.
//  الاستخدام في ملف الكتاب:  #show: book.with(lang: "ar")
// ═══════════════════════════════════════════════════════════════════════════

#import "theme.typ": COLOR, FONT, SIZE, LEADING, PAR_SPACING, PAGE_MARGIN
#import "i18n.typ": STRINGS
#import "components.typ": doc-lang, doc-prompt, doc-others

// ── العدّادات والحالات ─────────────────────────────────────────────────────
#let chapnum   = counter("z2r-chap")
#let _partord  = state("z2r-partord", "")
#let _apmode   = state("z2r-apmode", false)
#let _apletter = state("z2r-apletter", "")
#let _fmmode   = state("z2r-fmmode", false)  // وضع المقدّمات (بلا ترقيم)

// ── دوال الهيكلة (يستخدمها المؤلف) ─────────────────────────────────────────
// استعمل هذه الدوال دائمًا بدل كتابة =/== يدويًا؛ فهي تضبط الترقيم والحالة.
#let front-title(title, outlined: true) = { _fmmode.update(true); heading(level: 2, outlined: outlined, title) }
#let part(ordinal, title)   = { _partord.update(ordinal); heading(level: 1, title) }
#let chapter(title)         = { _fmmode.update(false); _apmode.update(false); chapnum.step(); heading(level: 2, title) }
#let appendix(letter, title)= { _fmmode.update(false); _apmode.update(true); _apletter.update(letter); heading(level: 2, title) }
#let section(title)         = heading(level: 3, title)
#let subsection(title)      = heading(level: 4, title)

// ── غلاف الجزء (صفحة كاملة) ────────────────────────────────────────────────
#let _part-divider(ordinal, title) = context {
  let l = doc-lang.get()
  set page(header: none, footer: none)
  set align(center + horizon)
  block(width: 100%, {
    if ordinal != "" {
      text(font: FONT.displayAr, size: 13pt, fill: COLOR.accent, weight: 700)[
        #STRINGS.at(l).at("part") #ordinal
      ]
      v(10pt, weak: true)
      line(length: 22%, stroke: 1.2pt + COLOR.accent)
      v(16pt, weak: true)
    }
    text(font: FONT.displayAr, size: 30pt, fill: COLOR.primaryDeep, weight: 800)[#title]
  })
}

// ── غلاف الفصل ─────────────────────────────────────────────────────────────
#let _chapter-opener(eyebrow, title) = block(above: 0pt, below: 1.1em, {
  v(6pt)
  if eyebrow != none {
    text(font: FONT.displayAr, size: 12pt, fill: COLOR.accent, weight: 700)[#eyebrow]
    v(6pt, weak: true)
  }
  text(font: FONT.displayAr, size: SIZE.h1, fill: COLOR.ink, weight: 800)[#title]
  v(7pt, weak: true)
  line(length: 34%, stroke: 1.6pt + COLOR.primary)
})

// ═══════════════════════════════════════════════════════════════════════════
//  القالب
// ═══════════════════════════════════════════════════════════════════════════
#let book(
  lang: "ar",
  title: "",
  prompt: "$",
  others: none,
  body,
) = {
  let is-rtl = lang == "ar"

  doc-lang.update(lang)
  doc-prompt.update(prompt)
  doc-others.update(others)
  set document(title: title)

  // ── الصفحة ──
  set page(
    paper: "a5",
    margin: PAGE_MARGIN,
    fill: COLOR.paper,
    numbering: "١",
    number-align: center,
    footer: context {
      let p = counter(page).get().first()
      set align(center)
      set text(size: SIZE.tiny, fill: COLOR.muted, font: FONT.bodyAr)
      counter(page).display(if is-rtl { "١" } else { "1" })
    },
    header: context {
      // رأس جارٍ: عنوان الفصل الحالي — يُخفى في صفحات بداية الفصل/الجزء.
      let here-loc = here()
      let starts = query(heading)
        .filter(h => (h.level == 1 or h.level == 2) and h.location().page() == here-loc.page())
      if starts.len() > 0 { return }
      let chaps = query(heading.where(level: 2).before(here-loc))
      if chaps.len() == 0 { return }
      set text(size: SIZE.tiny, fill: COLOR.muted, font: FONT.bodyAr)
      let t = chaps.last().body
      grid(columns: (1fr,), align: if is-rtl { right } else { left },
        [#t])
      v(-4pt)
      line(length: 100%, stroke: 0.5pt + COLOR.rule)
    },
  )

  // ── النص ──
  set text(
    lang: lang,
    dir: if is-rtl { rtl } else { ltr },
    font: if is-rtl { (FONT.bodyAr, FONT.bodyLatin) } else { (FONT.bodyLatin,) },
    size: SIZE.body,
    fill: COLOR.ink,
    fallback: true,
  )
  set par(justify: true, leading: LEADING, spacing: PAR_SPACING, first-line-indent: 0pt)
  set list(indent: 6pt, marker: text(fill: COLOR.accent)[▪])
  set enum(indent: 6pt)
  show link: set text(fill: COLOR.info)
  show strong: set text(fill: COLOR.primaryDeep)

  // ── العناوين ──
  set heading(numbering: none)

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    _part-divider(_partord.get(), it.body)
    pagebreak(weak: true)
  }

  show heading.where(level: 2): it => {
    pagebreak(weak: true)
    context {
      let l = doc-lang.get()
      let digit = if l == "ar" { "١" } else { "1" }
      let eyebrow = if _fmmode.get() {
        none
      } else if _apmode.get() {
        [#STRINGS.at(l).at("appendix") #_apletter.get()]
      } else {
        [#STRINGS.at(l).at("chapter") #numbering(digit, chapnum.get().first())]
      }
      _chapter-opener(eyebrow, it.body)
    }
  }

  show heading.where(level: 3): it => block(above: 1.5em, below: 0.92em, {
    set text(font: FONT.bodyAr, size: SIZE.h2, fill: COLOR.primaryDeep, weight: 700)
    set par(leading: 0.75em)
    grid(columns: (auto, 1fr), gutter: 7pt,
      align(horizon)[#box(width: 4pt, height: 0.85em, fill: COLOR.accent, radius: 1pt)],
      it.body)
  })

  show heading.where(level: 4): it => block(above: 1.2em, below: 0.7em, {
    set text(font: FONT.bodyAr, size: SIZE.h3, fill: COLOR.ink, weight: 700)
    set par(leading: 0.7em)
    it.body
  })

  // ── الأكواد ──
  // كتل الكود يسارية LTR داخل إطار بخلفية دافئة وشريط أخضر.
  show raw.where(block: true): it => block(
    width: 100%, fill: COLOR.codeBg, radius: 4pt,
    stroke: (left: 2.4pt + COLOR.primary),
    inset: (x: 11pt, y: 9pt), above: 1em, below: 1em, breakable: true,
    {
      set text(font: FONT.mono, size: SIZE.code, dir: ltr, fill: COLOR.ink)
      set par(justify: false, leading: 0.6em)
      align(left)[#it]
    },
  )
  // الكود المضمّن في السطر.
  // `dir: ltr` ضرورةٌ لا زينة: بدونها يرث الكودُ اتّجاهَ الفقرة العربيّة
  // فينقلب في الطباعة — `cd ..` تُطبع `.. cd`، و`>` تنقلب مرآةً إلى `<`.
  show raw.where(block: false): it => box(
    fill: luma(244), inset: (x: 3.5pt, y: 1pt), radius: 3pt, baseline: 1.5pt,
    text(font: FONT.mono, size: SIZE.code, fill: COLOR.codeInline, dir: ltr)[#it],
  )
  set raw(tab-size: 2)

  // ── الجداول ──
  set table(stroke: (x, y) => (bottom: 0.6pt + COLOR.rule), inset: 7pt)
  show table.cell.where(y: 0): set text(weight: 700, fill: COLOR.primaryDeep)

  body
}

// ── محتويات الكتاب (TOC) ───────────────────────────────────────────────────
#let book-outline() = context {
  let l = doc-lang.get()
  pagebreak(weak: true)
  block(above: 6pt, below: 14pt, {
    text(font: FONT.displayAr, size: SIZE.h1, fill: COLOR.ink, weight: 800)[
      #STRINGS.at(l).at("contents")
    ]
    v(6pt, weak: true)
    line(length: 34%, stroke: 1.6pt + COLOR.primary)
  })
  // أجزاءٌ نبدؤها أعلى صفحةٍ جديدة في الفهرس (تفاديًا لتيتّم عنوانها أسفل الصفحة).
  // الترتيب: ٤ = الصدفة والأتمتة، ٨ = الأمن السيبراني.
  let toc-newpage = (4, 8)
  let pidx = counter("z2r-toc-part")
  // أسطر الأجزاء بارزة وقابلة للنقر (رابط إلى موضع العنوان).
  show outline.entry.where(level: 1): it => {
    pidx.step()
    context {
      let i = pidx.get().first()
      if toc-newpage.contains(i) { pagebreak(weak: true) } else { v(9pt, weak: true) }
    }
    link(it.element.location(), text(
      font: FONT.displayAr, weight: 700, fill: COLOR.primaryDeep, size: 11pt,
    )[#it.element.body])
  }
  outline(title: none, depth: 2, indent: 1.1em)
}
