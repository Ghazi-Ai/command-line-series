// ═══════════════════════════════════════════════════════════════════════════
//  «رُوحٌ في الآلة» — حكايةُ يونيكس · سلسلة سطر الأوامر، الكتاب السادس
//  كتابٌ أدبيٌّ تاريخيٌّ للعامّة، لا مرجعُ أوامر.
//  البناء:  ./build.sh 6-unix-story
// ═══════════════════════════════════════════════════════════════════════════

#import "/lib/book.typ": book, book-outline

#show: book.with(
  lang: "ar",
  title: "رُوحٌ في الآلة — حكايةُ يونيكس",
  description: "حكاية عربية أدبية تاريخية عن يونيكس وأثره في الحوسبة الحديثة",
  keywords: ("يونيكس", "Unix", "تاريخ الحوسبة", "أنظمة التشغيل", "سرد تقني"),
)

#let print-interior = sys.inputs.at("print-interior", default: "false") == "true"

#if not print-interior {
  include "frontmatter/cover.typ"
}
#include "frontmatter/title-page.typ"
#include "frontmatter/colophon.typ"

#counter(page).update(1)

#include "frontmatter/preface.typ"

#book-outline()

#include "_contents.typ"

#if not print-interior {
  include "frontmatter/cover-back.typ"
}
