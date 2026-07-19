// صفحة الحقوق والنشر (Colophon)
#import "/src/lib/theme.typ": COLOR, FONT

#page(header: none, footer: none, numbering: none, {
  set text(font: FONT.bodyAr, size: 9.5pt, fill: COLOR.ink)
  set par(leading: 0.85em, spacing: 0.9em)
  v(1fr)

  text(weight: 700, size: 11pt)[مِن الصِّفر إلى الجَذر]
  linebreak()
  text(fill: COLOR.muted)[الدليل الشامل إلى سطر الأوامر ولِينُكس]

  v(1.4em)
  [© #text(font: FONT.mono)[2026] المهندس غازي السيف (أبو هيثم). جميع الحقوق محفوظة ضمن حدود الرخصة أدناه.]

  v(0.8em)
  text(weight: 700, fill: COLOR.primaryDeep)[الرخصة]
  linebreak()
  [هذا العمل منشورٌ برخصة *المشاع الإبداعي: النَّسْب — بلا اشتقاق، الإصدار الرابع الدولي* #linebreak() (CC BY‑ND 4.0).]

  v(0.5em)
  [يحقُّ لك بموجبها: قراءة الكتاب وتحميله ومشاركته وإعادة توزيعه ونشره — كاملًا وحرفيًا، لأي غرضٍ بما في ذلك التجاري — بشرط نَسْبه إلى مؤلّفه. ولا يحقُّ نشر نسخةٍ معدّلة أو مقتطعة أو مشتقّة منه إلا بإذنٍ خطّيٍّ من المؤلف.]

  v(0.5em)
  [النصّ الكامل للرخصة في ملف #text(font: FONT.mono)[LICENSE] المرافق، وعلى: #text(font: FONT.mono, size: 8.5pt)[creativecommons.org/licenses/by-nd/4.0]]

  v(1.2em)
  text(weight: 700, fill: COLOR.primaryDeep)[التواصل والمصدر]
  linebreak()
  grid(columns: (auto, 1fr), row-gutter: 0.4em, column-gutter: 10pt,
    text(fill: COLOR.muted)[المؤلف], [المهندس غازي السيف — أبو هيثم],
    text(fill: COLOR.muted)[البريد], text(font: FONT.mono, size: 8.5pt)[eng.ghazi\@icloud.com],
    text(fill: COLOR.muted)[المستودع], text(font: FONT.mono, size: 8.5pt)[github.com/Ghazi-Ai/zero-to-root],
  )

  v(1.2em)
  text(size: 8.5pt, fill: COLOR.muted)[
    صُفَّ هذا الكتاب بأداة #text(font: FONT.mono)[Typst]، بخطّ IBM Plex Sans Arabic للمتن،
    وNoto Kufi Arabic للعناوين، وJetBrains Mono للأكواد.
  ]
  v(0.8fr)
})
