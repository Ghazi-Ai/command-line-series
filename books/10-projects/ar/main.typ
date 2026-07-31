// «10+ مشاريع كبرى من الطرفية» — سلسلة سطر الأوامر، الكتاب العاشر

#import "/lib/book.typ": book, book-outline

#show: book.with(
  lang: "ar",
  title: "10+ مشاريع كبرى من الطرفية",
  description: "مشروعات عملية متدرجة تجمع النظام والأتمتة والخادم والشبكة والأمن السيبراني",
  keywords: ("مشروعات الطرفية", "الأتمتة", "إدارة الخوادم", "الشبكات", "الأمن السيبراني"),
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
