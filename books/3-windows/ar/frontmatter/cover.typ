// صفحة الغلاف الأماميّ — الفنّ الجاهز مع العنوان مطبوعًا فوقه
#import "/lib/theme.typ": FONT
#import "/lib/publication.typ": cover-author-credit

#page(width: 148mm, height: 210mm, margin: 0pt, header: none, footer: none, numbering: none, {
  set text(lang: "ar", dir: rtl)
  set par(justify: false)

  // الفنّ يملأ الصفحة
  place(top + left, image("/books/3-windows/ar/assets/cover-front.png", width: 148mm, height: 210mm))

  // العنوان أعلى الصفحة، فوق الهالة
  place(top + center, dy: 15mm, block(width: 100%, {
    set align(center)
    text(font: FONT.displayAr, size: 30pt, weight: 800, fill: rgb("#5E3E0A"))[مِن الصِّفر \ إلى المسؤول]
    v(5mm)
    text(font: FONT.bodyAr, size: 12pt, weight: 600, fill: rgb("#7A5410"))[الدليل الشامل إلى سطر الأوامر على ويندوز]
  }))

  // لوحة الاسم أسفل الصفحة، مستقلة بصريًّا عن تفاصيل الفنّ
  place(bottom + center, dy: -7mm, cover-author-credit())
})
