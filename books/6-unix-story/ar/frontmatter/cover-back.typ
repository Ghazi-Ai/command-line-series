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

    text(size: 10pt)[في صيف 1969 بدأ كِن طومسون تنفيذ نظامٍ صغيرٍ على آلةٍ قليلة الاستخدام، ثم أسهم دِنِس ريتشي وزملاؤهما في تشكيله حتى صار واحدًا من أعمق الجذور التي قامت عليها الحوسبة الحديثة.]
    v(9mm)

    text(size: 10pt)[هذه حكايةُ يونيكس؛ فكرةٌ امتدّت إلى الخوادم والحواسيب والهواتف، مباشرةً في بعض الأنظمة، وتأثيرًا ومعاييرَ في أنظمةٍ أخرى. رحلةٌ في نصف قرنٍ من مختبرات بِل إلى البنى التي تعمل فوقها خدمات العصر.]
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
