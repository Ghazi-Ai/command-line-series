// ═══════════════════════════════════════════════════════════════════════════
//  From Zero to Root — English edition
//  Build:  typst compile src/en/main.typ build/zero-to-root-en.pdf --root .
//  The English edition mirrors the Arabic original (src/ar). Work in progress.
// ═══════════════════════════════════════════════════════════════════════════

#import "/lib/book.typ": book

#show: book.with(lang: "en", title: "From Zero to Root")

#include "frontmatter/title-page.typ"

#counter(page).update(1)

#include "frontmatter/preface.typ"
