// ═══════════════════════════════════════════════════════════════════════════
//  «مِن الصِّفر إلى العِفريت» — سلسلة سطر الأوامر، الكتاب الرابع (BSD)
//  البناء:  typst compile books/4-bsd/ar/main.typ build/bsd-ar.pdf --root .
// ═══════════════════════════════════════════════════════════════════════════

#import "/lib/book.typ": book, book-outline

#show: book.with(lang: "ar", title: "مِن الصِّفر إلى العِفريت", prompt: "$", others: "على أنظمةٍ أخرى")

#include "frontmatter/title-page.typ"
#include "frontmatter/colophon.typ"

#counter(page).update(1)

#include "frontmatter/preface.typ"
#include "frontmatter/how-to-read.typ"

#book-outline()

#include "_contents.typ"
