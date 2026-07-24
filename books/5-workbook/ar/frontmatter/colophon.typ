// صفحة الحقوق والنشر (Colophon)
#import "/lib/theme.typ": COLOR, FONT

#page(header: none, footer: none, numbering: none, {
  set text(font: FONT.bodyAr, size: 9.5pt, fill: COLOR.ink)
  set par(leading: 0.85em, spacing: 0.9em)
  v(1fr)

  text(weight: 700, size: 11pt)[الطرفيّةُ بالممارسة]
  linebreak()
  text(fill: COLOR.muted)[دفترُ تمارينِ سطر الأوامر عبر الأنظمة الأربعة — مهمّةٌ واحدة، أربعةُ ألسنة]

  v(1.4em)
  [© #text(font: FONT.mono)[2026] المهندس غازي السيف (أبو هيثم). جميع الحقوق محفوظة ضمن حدود الرخصة أدناه.]

  v(0.8em)
  text(weight: 700, fill: COLOR.primaryDeep)[الرخصة]
  linebreak()
  [هذا العمل منشورٌ برخصة *المشاع الإبداعي: النَّسْب — بلا اشتقاق، الإصدار الرابع الدولي* (CC BY‑ND 4.0). لك أن تقرأه وتحمّله وتشاركه وتعيد نشره كاملًا وحرفيًّا لأيّ غرضٍ — بما فيه التجاريّ — بشرط نَسْبه لمؤلّفه، ولا يحقّ نشر نسخةٍ معدّلةٍ أو مقتطعةٍ أو مشتقّةٍ منه إلا بإذنٍ خطّيٍّ منه. النصّ الكامل في ملفّ #text(font: FONT.mono)[LICENSE] المرافق، وعلى: #text(font: FONT.mono, size: 8.5pt)[creativecommons.org/licenses/by-nd/4.0]]

  v(1.2em)
  text(weight: 700, fill: COLOR.primaryDeep)[في صحّة الأوامر]
  linebreak()
  [حلولُ التمارين كلُّها أصليّةٌ ومُتحقَّقٌ منها بالتنفيذ الفعليّ حيثما أمكن، مستخرَجةٌ من كتب السلسلة الأربعة المدقَّقة (لِينُكس، ماك، ويندوز، BSD). ومع ذلك تختلف الأنظمةُ بإصداراتها وإعداداتها، فإن اختلف مخرجٌ عندك فذاك طبيعيّ — والمقصودُ الطريقةُ لا حرفيّةُ المخرَج.]

  v(1.2em)
  text(weight: 700, fill: COLOR.primaryDeep)[التواصل والمصدر]
  linebreak()
  grid(columns: (auto, 1fr), row-gutter: 0.4em, column-gutter: 10pt,
    text(fill: COLOR.muted)[المؤلف], [المهندس غازي السيف — أبو هيثم],
    text(fill: COLOR.muted)[التواصل], text(font: FONT.mono, size: 8.5pt)[github.com/Ghazi-Ai/command-line-series/issues],
    text(fill: COLOR.muted)[المستودع], text(font: FONT.mono, size: 8.5pt)[github.com/Ghazi-Ai/command-line-series],
  )

  v(1.2em)
  text(size: 8.5pt, fill: COLOR.muted)[
    صُفَّ هذا الكتاب بأداة #text(font: FONT.mono)[Typst]، بخطّ IBM Plex Sans Arabic للمتن،
    وNoto Kufi Arabic للعناوين، وJetBrains Mono للأوامر اللاتينية.
  ]
  v(0.8fr)
})
