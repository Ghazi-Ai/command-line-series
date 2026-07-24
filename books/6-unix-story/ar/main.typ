// ═══════════════════════════════════════════════════════════════════════════
//  «رُوحٌ في الآلة» — حكايةُ يونِكس · سلسلة سطر الأوامر، الكتاب السادس
//  كتابٌ أدبيٌّ تاريخيٌّ للعامّة، لا مرجعُ أوامر.
//  البناء:  ./build.sh 6-unix-story
// ═══════════════════════════════════════════════════════════════════════════

#import "/lib/book.typ": book, book-outline

#show: book.with(lang: "ar", title: "رُوحٌ في الآلة — حكايةُ يونِكس")

#include "frontmatter/cover.typ"
#include "frontmatter/title-page.typ"
#include "frontmatter/colophon.typ"

#counter(page).update(1)

#include "frontmatter/preface.typ"

#book-outline()

#include "_contents.typ"

#include "frontmatter/cover-back.typ"
