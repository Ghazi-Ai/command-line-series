// الغلاف الخلفيّ — الفنّ الجاهز مع النبذة مطبوعةً فوقه
#import "/lib/theme.typ": FONT

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  place(top + left, image("/books/2-macos/ar/assets/cover-back.png", width: 148mm, height: 210mm))

  place(top + center, dy: 38mm, block(width: 80%, {
    set align(center)
    set text(font: FONT.bodyAr, fill: rgb("#26242E"))
    set par(leading: 0.9em, spacing: 0.9em)

    text(font: FONT.displayAr, size: 15pt, weight: 700, fill: rgb("#234A5F"))[ماك من الطرفية]
    v(6mm)

    text(size: 10pt)[تحت واجهةِ ماك الأنيقةِ يسكنُ نظامٌ يونِكسيٌّ عريق. هذا الكتابُ يفتحُ لك بابَ الطرفيّة على macOS، فتكتشفَ القوّةَ الكامنةَ التي لا تُظهرها النوافذُ الجميلة.]
    v(6mm)

    text(size: 10pt)[من الملفّات والأذون إلى Homebrew وZsh والأتمتةِ بـlaunchd وdefaults — رحلةٌ منظّمةٌ تجعلُ ماك في يدك أداةَ محترفٍ لا جهازَ تصفّح.]
    v(6mm)

    text(size: 10pt)[لا تحتاج خبرةً سابقة؛ يكفيك فضولٌ ورغبةٌ في أن تأمرَ جهازك بدل أن تنقرَه.]
    v(7mm)

    text(size: 10pt, style: "italic", fill: rgb("#305A70"))[من أوّل أمرٍ إلى احتراف النظام.]
  }))

  place(bottom + center, dy: -14mm, block(width: 82%, {
    set align(center)
    text(font: FONT.bodyAr, size: 9.5pt, weight: 700, fill: rgb("#26242E"))[المهندس غازي السيف (أبو هيثم)]
    v(2.5mm)
    text(font: FONT.bodyAr, size: 7.5pt, fill: rgb("#4A4857"))[مفتوحٌ · CC BY‑ND 4.0 · github.com/Ghazi-Ai/command-line-series]
  }))
})
