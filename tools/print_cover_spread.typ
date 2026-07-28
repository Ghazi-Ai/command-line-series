// قالب داخلي لغلاف ممتد: خلفي + كعب + أمامي.
// لا يُستدعى مباشرة؛ تتحقق الأداة make_print_cover.sh من جميع المدخلات أولًا.
#import "/lib/theme.typ": FONT

#let required(name) = {
  let value = sys.inputs.at(name, default: none)
  assert(value != none and value.trim() != "", message: "المدخل الإلزامي مفقود: " + name)
  value
}

#let books = (
  "1-linux": (title: "مِن الصِّفر إلى الجَذر", accent: rgb("#6E2C12"), optical: 0.78),
  "2-macos": (title: "ماك من الطرفية", accent: rgb("#234A5F"), optical: 0.99),
  "3-windows": (title: "مِن الصِّفر إلى المسؤول", accent: rgb("#5E3E0A"), optical: 0.78),
  "4-bsd": (title: "مِن الصِّفر إلى العِفريت", accent: rgb("#5E1A13"), optical: 0.78),
  "5-workbook": (title: "الطرفيّةُ بالممارسة", accent: rgb("#382863"), optical: 0.64),
  "6-unix-story": (title: "رُوحٌ في الآلة", accent: rgb("#363B5E"), optical: 1.20),
)

#let book-id = required("book-id")
#assert(book-id in books, message: "معرّف كتاب غير معروف: " + book-id)
#let info = books.at(book-id)

#let spine-mm = float(required("spine-width-mm"))
#let bleed-mm = float(required("bleed-mm"))
#let direction = required("spine-direction")
#assert(spine-mm >= 6.5, message: "عرض الكعب أقل من 6.5 mm ولا يتسع لعنوان الكتاب واسم صاحب المشروع بصورة مقروءة")
#assert(bleed-mm >= 0, message: "لا يمكن أن تكون قيمة النزف سالبة")
#assert(
  direction == "top-to-bottom" or direction == "bottom-to-top",
  message: "اتجاه الكعب يجب أن يكون top-to-bottom أو bottom-to-top",
)

#let front-image = required("front-image")
#let back-image = required("back-image")
#let spine = spine-mm * 1mm
#let bleed = bleed-mm * 1mm
#let trim-width = 148mm
#let trim-height = 210mm
#let safe-along = 3mm
#let safe-across = if spine-mm < 10 { 0.75mm } else { 1.5mm }
#let title-size = if spine-mm < 8 { 7.5pt } else if spine-mm < 12 { 8.5pt } else { 10pt }
#let owner-size = if spine-mm < 8 { 5.75pt } else if spine-mm < 12 { 6.75pt } else { 8pt }
#let optical-sign = if direction == "top-to-bottom" { 1 } else { -1 }
#let title-cross-shift = optical-sign * info.optical * (title-size / 7.5pt) * 1mm
#let owner-cross-shift = optical-sign * 0.21 * (owner-size / 5.75pt) * 1mm
#let page-width = 2 * trim-width + spine + 2 * bleed
#let page-height = trim-height + 2 * bleed
#let rotation = if direction == "top-to-bottom" { 90deg } else { -90deg }

#set page(
  width: page-width,
  height: page-height,
  margin: 0pt,
  header: none,
  footer: none,
  numbering: none,
  fill: info.accent,
)
#set text(lang: "ar", dir: rtl)

// تتبع أغلفة السلسلة اتجاه الكتب الإنجليزية:
// الأمامي يسار الملف، ثم الكعب، ثم الخلفي يمين الملف.
// تمتد الصورتان إلى النزف الخارجي؛ أما القيم النهائية فيعتمدها مزود الطباعة.
#place(
  top + left,
  image(front-image, width: trim-width + bleed, height: page-height, fit: "cover"),
)
#place(
  top + left,
  dx: bleed + trim-width + spine,
  image(back-image, width: trim-width + bleed, height: page-height, fit: "cover"),
)

// الكعب: أحجام محددة لثلاث فئات عرض وهوامش أمان؛ لا يوجد تصغير حر
// قد ينتج نصًا مجهريًا، وتُرفض القيم الأضيق من الحد التصميمي.
#place(
  top + left,
  dx: bleed + trim-width,
  block(
    width: spine,
    height: page-height,
    fill: info.accent,
    inset: (
      top: bleed + safe-along,
      bottom: bleed + safe-along,
      left: safe-across,
      right: safe-across,
    ),
    clip: true,
  )[
    // يدور كل سطر حول مركزه بعد وضعه في موضعه الفيزيائي داخل الكعب؛
    // وبذلك لا تؤثر مقاييس خط العربية في توسيط السطر عبر عرض الكعب.
    #place(
      center + horizon,
      dx: title-cross-shift,
      rotate(
        rotation,
        reflow: true,
        text(
          font: FONT.displayAr,
          size: title-size,
          weight: 700,
          fill: white,
          info.title,
        ),
      ),
    )
    #place(
      center + bottom,
      dx: owner-cross-shift,
      rotate(
        rotation,
        reflow: true,
        text(
          font: FONT.bodyAr,
          size: owner-size,
          weight: 600,
          fill: white,
          [غازي السيف — أبو هيثم],
        ),
      ),
    )
  ],
)
