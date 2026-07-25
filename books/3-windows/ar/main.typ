// ═══════════════════════════════════════════════════════════════════════════
//  «مِن الصِّفر إلى المسؤول» — سلسلة سطر الأوامر، الكتاب الثالث (ويندوز)
//  البناء:  typst compile books/3-windows/ar/main.typ build/3-windows-ar.pdf --root .
// ═══════════════════════════════════════════════════════════════════════════

#import "/lib/book.typ": book, book-outline

#show: book.with(lang: "ar", title: "مِن الصِّفر إلى المسؤول", prompt: "C:\\>", others: "على أنظمةٍ أخرى")

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
