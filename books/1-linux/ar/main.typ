// ═══════════════════════════════════════════════════════════════════════════
//  «مِن الصِّفر إلى الجَذر» — النسخة العربية
//  الملفّ الرئيس: يجمع القالب والمقدّمات والمحتوى.
//  البناء:  typst compile src/ar/main.typ build/1-linux-ar.pdf --root .
// ═══════════════════════════════════════════════════════════════════════════

#import "/lib/book.typ": book, book-outline

#show: book.with(lang: "ar", title: "مِن الصِّفر إلى الجَذر")

// ── الغلاف الأماميّ (الفنّ + العنوان) ──
#include "frontmatter/cover.typ"

// ── المقدّمات (بلا ترقيم صفحات) ──
#include "frontmatter/title-page.typ"
#include "frontmatter/colophon.typ"

// يبدأ ترقيم الصفحات من هنا
#counter(page).update(1)

#include "frontmatter/preface.typ"
#include "frontmatter/how-to-read.typ"

// ── الفهرس ──
#book-outline()

// ── الأجزاء والفصول والملاحق (مولّد آليًّا) ──
#include "_contents.typ"

// ── الغلاف الخلفيّ (الفنّ + النبذة) ──
#include "frontmatter/cover-back.typ"
