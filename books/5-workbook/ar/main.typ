// ═══════════════════════════════════════════════════════════════════════════
//  «الطرفية بالممارسة» — سلسلة سطر الأوامر، الكتاب الخامس (دفتر التمارين)
//  مهمّةٌ واحدة، أربعةُ ألسنة: ويندوز · لِينُكس · ماك · BSD جنبًا إلى جنب.
//  البناء:  ./build.sh 5-workbook   (أو: typst compile … main.typ … --root .)
// ═══════════════════════════════════════════════════════════════════════════

#import "/lib/book.typ": book, book-outline

#show: book.with(lang: "ar", title: "الطرفية بالممارسة", prompt: "$", others: "على أربعة أنظمة")

#include "frontmatter/title-page.typ"
#include "frontmatter/colophon.typ"

#counter(page).update(1)

#include "frontmatter/preface.typ"
#include "frontmatter/how-to-read.typ"

#book-outline()

#include "_contents.typ"
