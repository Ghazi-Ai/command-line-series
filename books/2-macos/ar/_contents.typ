#import "/lib/book.typ": part, appendix

#part("الأول", "أساسيات الطرفية على ماك")
#include "chapters/p1-basics/ch01-what-is-terminal-mac.typ"
#include "chapters/p1-basics/ch02-navigation.typ"
#include "chapters/p1-basics/ch03-viewing-files.typ"
#include "chapters/p1-basics/ch04-manipulating-files.typ"
#include "chapters/p1-basics/ch05-getting-help.typ"

#part("الثاني", "صدفة zsh والبيئة")
#include "chapters/p2-shell/ch06-zsh.typ"
#include "chapters/p2-shell/ch07-environment.typ"
#include "chapters/p2-shell/ch08-scripting.typ"
#include "chapters/p2-shell/ch09-control-flow.typ"

#part("الثالث", "ما يميّز ماك")
#include "chapters/p3-macos/ch10-bsd-vs-gnu.typ"
#include "chapters/p3-macos/ch11-homebrew.typ"
#include "chapters/p3-macos/ch12-mac-native.typ"
#include "chapters/p3-macos/ch13-processes-launchd.typ"
#include "chapters/p3-macos/ch14-disks-system.typ"

#part("الرابع", "النصوص والشبكات والتطوير")
#include "chapters/p4-dev/ch15-text.typ"
#include "chapters/p4-dev/ch16-networking.typ"
#include "chapters/p4-dev/ch17-git-dev.typ"
#include "chapters/p4-dev/ch18-terminal-env.typ"

#part("الخامس", "الجسر إلى عوالم يونِكس")
#include "chapters/p5-bridge/ch19-linux-bsd-bridge.typ"

#part("", "الملاحق")
#include "appendices/appA-mac-linux-bsd.typ"
#include "appendices/appB-homebrew.typ"
#include "appendices/appC-glossary.typ"
#include "appendices/appD-sources.typ"
#include "appendices/appE-resources.typ"
