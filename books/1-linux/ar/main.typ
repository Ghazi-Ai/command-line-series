// ═══════════════════════════════════════════════════════════════════════════
//  «مِن الصِّفر إلى الجَذر» — النسخة العربية
//  الملفّ الرئيس: يجمع القالب والمقدّمات والمحتوى.
//  البناء:  typst compile src/ar/main.typ build/1-linux-ar.pdf --root .
// ═══════════════════════════════════════════════════════════════════════════

#import "/lib/book.typ": book, book-outline

#show: book.with(
  lang: "ar",
  title: "مِن الصِّفر إلى الجَذر",
  description: "دليل عربي تعليمي لإتقان سطر أوامر Linux من الأساسيات إلى إدارة النظام",
  keywords: ("Linux", "سطر الأوامر", "الطرفية", "إدارة النظام"),
)

#let print-interior = sys.inputs.at("print-interior", default: "false") == "true"

// ── الغلاف الأماميّ (الفنّ + العنوان) ──
#if not print-interior {
  include "frontmatter/cover.typ"
}

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
#if not print-interior {
  include "frontmatter/cover-back.typ"
}
