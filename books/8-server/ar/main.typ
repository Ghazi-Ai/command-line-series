// «الخادمُ الذي لا ينام» — سلسلة سطر الأوامر، الكتاب الثامن

#import "/lib/book.typ": book, book-outline

#show: book.with(
  lang: "ar",
  title: "الخادمُ الذي لا ينام",
  description: "دليل عربي لإدارة خادم أوبونتو بثقة من أول اتصال إلى خدمة مستقرة",
  keywords: ("الخوادم", "أوبونتو", "لينكس", "SSH", "إدارة الأنظمة"),
  prompt: "$",
  others: "على أنظمةٍ أخرى",
)

#let print-interior = sys.inputs.at("print-interior", default: "false") == "true"

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

#if not print-interior {
  include "frontmatter/cover-back.typ"
}
