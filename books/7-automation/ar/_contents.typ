#import "/lib/book.typ": part

#part("الأول", "من التكرار إلى الأداة")
#include "chapters/p1-tool/ch01-repeat.typ"
#include "chapters/p1-tool/ch02-safe-lab.typ"
#include "chapters/p1-tool/ch03-choose-language.typ"
#include "chapters/p1-tool/ch04-script-anatomy.typ"

#part("الثاني", "لغة القرار والتكرار")
#include "chapters/p2-language/ch05-values-paths.typ"
#include "chapters/p2-language/ch06-conditions.typ"
#include "chapters/p2-language/ch07-loops.typ"
#include "chapters/p2-language/ch08-functions.typ"
#include "chapters/p2-language/ch09-structured-data.typ"

#part("الثالث", "الأتمتة التي يمكن الوثوق بها")
#include "chapters/p3-trust/ch10-partial-failure.typ"
#include "chapters/p3-trust/ch11-logging.typ"
#include "chapters/p3-trust/ch12-config-secrets.typ"
#include "chapters/p3-trust/ch13-idempotence.typ"
#include "chapters/p3-trust/ch14-testing.typ"
#include "chapters/p3-trust/ch15-portability.typ"

#part("الرابع", "الوقت والآلات والوكلاء")
#include "chapters/p4-scale/ch16-scheduling.typ"
#include "chapters/p4-scale/ch17-remote.typ"
#include "chapters/p4-scale/ch18-git.typ"
#include "chapters/p4-scale/ch19-python-bridge.typ"
#include "chapters/p4-scale/ch20-agents.typ"

#part("الخامس", "أداة تعيش بعد الفصل")
#include "chapters/p5-product/ch21-design.typ"
#include "chapters/p5-product/ch22-inbox-guardian.typ"

#part("", "الملاحق")
#include "appendices/appA-language-map.typ"
#include "appendices/appB-checklists.typ"
#include "appendices/appC-glossary.typ"
#include "appendices/appD-sources.typ"

