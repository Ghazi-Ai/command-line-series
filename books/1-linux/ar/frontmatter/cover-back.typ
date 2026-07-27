// الغلاف الخلفيّ — الفنّ الجاهز مع النبذة مطبوعةً فوقه
#import "/lib/theme.typ": FONT
#import "/lib/publication.typ": cover-license-line

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  place(top + left, image("/books/1-linux/ar/assets/cover-back.png", width: 148mm, height: 210mm))

  place(top + center, dy: 38mm, block(width: 80%, {
    set align(center)
    set text(font: FONT.bodyAr, fill: rgb("#26242E"))
    set par(leading: 0.9em, spacing: 0.9em)

    text(font: FONT.displayAr, size: 15pt, weight: 700, fill: rgb("#6E2C12"))[مِن الصِّفر إلى الجَذر]
    v(6mm)

    text(size: 10pt)[سطرُ الأوامر ليس شاشةً سوداءَ مخيفة، بل أقصرُ طريقٍ بينك وبين الآلة. هذا الكتابُ يأخذُ بيدك من أوّل أمرٍ تكتبه إلى أن تصيرَ جذرَ نظامك — سيّدَه لا ضيفَه.]
    v(6mm)

    text(size: 10pt)[تسعةُ أجزاءٍ تبني مهارتَك لبِنةً لبِنة: التنقّلُ والملفّات، والمستخدمون والأذون، والنصوصُ وتدفّقُها، والصدفةُ والأتمتة، والشبكاتُ والأمن — بعربيّةٍ واضحةٍ وأمثلةٍ تُجرَّب.]
    v(6mm)

    text(size: 10pt)[لا تحفظْ بل افهمْ؛ فكلُّ مهارةٍ هنا تنتقلُ معك إلى أيِّ نظام لِينُكس بقيّةَ عمرك.]
    v(7mm)

    text(size: 10pt, style: "italic", fill: rgb("#8A3A1C"))[من أوّل أمرٍ إلى احتراف النظام.]
  }))

  place(bottom + center, dy: -14mm, block(width: 82%, {
    set align(center)
    text(font: FONT.bodyAr, size: 9.5pt, weight: 700, fill: rgb("#26242E"))[المهندس غازي السيف (أبو هيثم)]
    v(2.5mm)
    text(font: FONT.bodyAr, size: 7.2pt, fill: rgb("#4A4857"))[#cover-license-line]
  }))
})
