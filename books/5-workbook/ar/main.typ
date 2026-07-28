// ═══════════════════════════════════════════════════════════════════════════
//  «الطرفية بالممارسة» — سلسلة سطر الأوامر، الكتاب الخامس (دفتر التمارين)
//  مهمّةٌ واحدة، أربعةُ ألسنة: ويندوز · لِينُكس · ماك · BSD جنبًا إلى جنب.
//  البناء:  ./build.sh 5-workbook   (أو: typst compile … main.typ … --root .)
// ═══════════════════════════════════════════════════════════════════════════

#import "/lib/book.typ": book, book-outline

#show: book.with(
  lang: "ar",
  title: "الطرفية بالممارسة",
  description: "دفتر تمارين عربي لتطبيق مهارات الطرفية على Linux وmacOS وWindows وBSD",
  keywords: ("تمارين", "Linux", "macOS", "Windows", "BSD", "سطر الأوامر"),
  prompt: "$",
  others: "على أربعة أنظمة",
)

#let print-interior = sys.inputs.at("print-interior", default: "false") == "true"

// ── الغلاف الأماميّ (الفنّ + العنوان) ──
#if not print-interior {
  include "frontmatter/cover.typ"
}

#include "frontmatter/title-page.typ"
#include "frontmatter/colophon.typ"

#counter(page).update(1)

#include "frontmatter/preface.typ"
#include "frontmatter/how-to-read.typ"

#book-outline()

#include "_contents.typ"

// ── الغلاف الخلفيّ (الفنّ + النبذة) ──
#if not print-interior {
  include "frontmatter/cover-back.typ"
}
