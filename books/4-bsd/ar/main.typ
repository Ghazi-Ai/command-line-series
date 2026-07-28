// ═══════════════════════════════════════════════════════════════════════════
//  «مِن الصِّفر إلى العِفريت» — سلسلة سطر الأوامر، الكتاب الرابع (BSD)
//  البناء:  typst compile books/4-bsd/ar/main.typ build/4-bsd-ar.pdf --root .
// ═══════════════════════════════════════════════════════════════════════════

#import "/lib/book.typ": book, book-outline

#show: book.with(
  lang: "ar",
  title: "مِن الصِّفر إلى العِفريت",
  description: "دليل عربي تعليمي لأنظمة BSD وسطر الأوامر وإدارة النظام",
  keywords: ("BSD", "FreeBSD", "سطر الأوامر", "إدارة النظام"),
  prompt: "$",
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
