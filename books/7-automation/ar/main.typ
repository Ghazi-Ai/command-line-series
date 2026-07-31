// «مِن الأمر إلى الأتمتة» — سلسلة سطر الأوامر، الكتاب السابع
// الإصدار العربي الرسمي ضمن سلسلة سطر الأوامر.

#import "/lib/book.typ": book, book-outline

#show: book.with(
  lang: "ar",
  title: "مِن الأمر إلى الأتمتة",
  description: "دليل عربي لتحويل أوامر الطرفية إلى أدوات موثوقة قابلة للاختبار والتراجع",
  keywords: ("الأتمتة", "السكربتات", "Bash", "PowerShell", "Python"),
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
