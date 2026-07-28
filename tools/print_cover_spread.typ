// قالب داخلي لغلاف ممتد: خلفي + كعب + أمامي.
// لا يُستدعى مباشرة؛ تتحقق الأداة make_print_cover.sh من جميع المدخلات أولًا.
#import "/lib/theme.typ": FONT

#let required(name) = {
  let value = sys.inputs.at(name, default: none)
  assert(value != none and value.trim() != "", message: "المدخل الإلزامي مفقود: " + name)
  value
}

#let books = (
  "1-linux": (title: "مِن الصِّفر إلى الجَذر", accent: rgb("#6E2C12")),
  "2-macos": (title: "ماك من الطرفية", accent: rgb("#234A5F")),
  "3-windows": (title: "مِن الصِّفر إلى المسؤول", accent: rgb("#5E3E0A")),
  "4-bsd": (title: "مِن الصِّفر إلى العِفريت", accent: rgb("#5E1A13")),
  "5-workbook": (title: "الطرفيّةُ بالممارسة", accent: rgb("#382863")),
  "6-unix-story": (title: "رُوحٌ في الآلة", accent: rgb("#363B5E")),
)

#let book-id = required("book-id")
#assert(book-id in books, message: "معرّف كتاب غير معروف: " + book-id)
#let info = books.at(book-id)

#let spine-mm = float(required("spine-width-mm"))
#let bleed-mm = float(required("bleed-mm"))
#let direction = required("spine-direction")
#assert(spine-mm >= 18, message: "عرض الكعب أقل من 18 mm ولا يتسع للنص بهوامش الأمان الثابتة")
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
#let safe = 3mm
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

// تمتد الصورتان إلى النزف الخارجي؛ أما القيم النهائية فيعتمدها مزود الطباعة.
#place(
  top + left,
  image(back-image, width: trim-width + bleed, height: page-height, fit: "cover"),
)
#place(
  top + left,
  dx: bleed + trim-width + spine,
  image(front-image, width: trim-width + bleed, height: page-height, fit: "cover"),
)

// الكعب: نص ثابت الحجم، وهوامش أمان ثابتة؛ ترفض الأداة العرض الضيق بدل تصغيره.
#place(
  top + left,
  dx: bleed + trim-width,
  block(
    width: spine,
    height: page-height,
    fill: info.accent,
    inset: (top: bleed + safe, bottom: bleed + safe, left: safe, right: safe),
    clip: true,
    align(
      center + horizon,
      rotate(
        rotation,
        reflow: true,
        block(
          width: trim-height - 2 * safe,
          height: spine - 2 * safe,
          grid(
            columns: (1fr, auto),
            column-gutter: 10mm,
            align: horizon,
            text(
              font: FONT.displayAr,
              size: 10pt,
              weight: 700,
              fill: white,
              info.title,
            ),
            text(
              font: FONT.bodyAr,
              size: 8pt,
              weight: 600,
              fill: white,
              [غازي السيف — أبو هيثم],
            ),
          ),
        ),
      ),
    ),
  ),
)
