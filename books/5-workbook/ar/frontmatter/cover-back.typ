// الغلاف الخلفيّ — الفنّ الجاهز مع النبذة مطبوعةً فوقه
#import "/lib/theme.typ": FONT

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  place(top + left, image("/books/5-workbook/ar/assets/cover-back.png", width: 148mm, height: 210mm))

  place(top + center, dy: 38mm, block(width: 80%, {
    set align(center)
    set text(font: FONT.bodyAr, fill: rgb("#26242E"))
    set par(leading: 0.9em, spacing: 0.9em)

    text(font: FONT.displayAr, size: 15pt, weight: 700, fill: rgb("#382863"))[الطرفيّةُ بالممارسة]
    v(6mm)

    text(size: 10pt)[المعرفةُ تُنسى، والمهارةُ تبقى. هذا دفترُ تمارينٍ عمليٌّ لا يُقرأ بل يُعمَل: مهمّةٌ واحدةٌ في كلِّ تمرين، وحلُّها بأربعةِ ألسنة — ويندوز، ولِينُكس، وماك، وBSD — جنبًا إلى جنب.]
    v(6mm)

    text(size: 10pt)[ترى الاختلافَ بعينك: كيف يقولُ كلُّ نظامٍ الفكرةَ نفسَها بطريقته، فتفهمُ الجوهرَ المشترَكَ لا الحفظَ الأعمى، وتعبُرُ بين الأنظمةِ بلا حاجز.]
    v(6mm)

    text(size: 10pt)[رفيقُ الكتبِ الأربعةِ الأولى — طبِّقْ ما تعلّمتَه حتى يصيرَ طبعًا في أصابعك.]
    v(7mm)

    text(size: 10pt, style: "italic", fill: rgb("#4A3678"))[مهمّةٌ واحدة، أربعةُ ألسنة.]
  }))

  place(bottom + center, dy: -14mm, block(width: 82%, {
    set align(center)
    text(font: FONT.bodyAr, size: 9.5pt, weight: 700, fill: rgb("#26242E"))[المهندس غازي السيف (أبو هيثم)]
    v(2.5mm)
    text(font: FONT.bodyAr, size: 7.5pt, fill: rgb("#4A4857"))[مفتوحٌ · CC BY‑ND 4.0 · github.com/Ghazi-Ai/command-line-series]
  }))
})
