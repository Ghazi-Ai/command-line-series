// ═══════════════════════════════════════════════════════════════════════════
//  «ماك من الطرفية» — سلسلة سطر الأوامر، الكتاب الثاني (النسخة العربية)
//  البناء:  typst compile books/2-macos/ar/main.typ build/macos-ar.pdf --root .
// ═══════════════════════════════════════════════════════════════════════════

#import "/lib/book.typ": book, book-outline

#show: book.with(
  lang: "ar",
  title: "ماك من الطرفية",
  description: "دليل عربي تعليمي لاستخدام طرفية macOS وأدواتها من الأساسيات إلى إدارة النظام",
  keywords: ("macOS", "سطر الأوامر", "الطرفية", "إدارة النظام"),
  prompt: "%",
  others: "على أنظمةٍ أخرى",
)

// ── الغلاف الأماميّ (الفنّ + العنوان) ──
#include "frontmatter/cover.typ"

#include "frontmatter/title-page.typ"
#include "frontmatter/colophon.typ"

#counter(page).update(1)

#include "frontmatter/preface.typ"
#include "frontmatter/how-to-read.typ"

#book-outline()

#include "_contents.typ"

// ── الغلاف الخلفيّ (الفنّ + النبذة) ──
#include "frontmatter/cover-back.typ"
