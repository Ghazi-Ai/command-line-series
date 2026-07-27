// الغلاف الخلفيّ — الفنّ الجاهز مع النبذة مطبوعةً فوقه
#import "/lib/theme.typ": FONT
#import "/lib/publication.typ": cover-license-line

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  place(top + left, image("/books/6-unix-story/ar/assets/cover-back.png", width: 148mm, height: 210mm))

  place(top + center, dy: 40mm, block(width: 80%, {
    set align(center)
    set text(font: FONT.bodyAr, fill: rgb("#26242E"))
    set par(leading: 0.95em, spacing: 1.0em)

    text(font: FONT.displayAr, size: 15pt, weight: 700, fill: rgb("#363B5E"))[رُوحٌ في الآلة]
    v(7mm)

    text(size: 10pt)[في صيفِ 1969، جلس رجلٌ وحيدٌ ليلعبَ لعبةً عن الفضاء، فبنى — دون أن يدري — النظامَ الذي سيحكم العالم.]
    v(9mm)

    text(size: 10pt)[هذه حكايةُ يونِكس: الرُّوحِ الخفيّةِ في كلِّ هاتفٍ وخادمٍ وطائرة، والفكرةِ الصغيرةِ التي انتصرت بالبساطة حين انهار ما هو أضخمُ منها. رحلةٌ في نصفِ قرنٍ غيّر التاريخ — من مختبرٍ منسيٍّ إلى الذكاءِ الاصطناعيِّ الذي تحادثه اليوم.]
    v(9mm)

    text(size: 10pt, style: "italic", fill: rgb("#3D4270"))[لا تحتاج أن تكون مبرمجًا لتقرأها. تحتاج فقط شيئًا من الفضول.]
  }))

  place(bottom + center, dy: -14mm, block(width: 82%, {
    set align(center)
    text(font: FONT.bodyAr, size: 9.5pt, weight: 700, fill: rgb("#26242E"))[المهندس غازي السيف (أبو هيثم)]
    v(2.5mm)
    text(font: FONT.bodyAr, size: 7.2pt, fill: rgb("#4A4857"))[#cover-license-line]
  }))
})
