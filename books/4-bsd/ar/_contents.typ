#import "/lib/book.typ": part, appendix

#part("الأول", "عالم BSD والأساسيات")
#include "chapters/p1-intro/ch01-what-is-bsd.typ"
#include "chapters/p1-intro/ch02-shell-basics.typ"
#include "chapters/p1-intro/ch03-navigation.typ"
#include "chapters/p1-intro/ch04-files.typ"
#include "chapters/p1-intro/ch05-getting-help.typ"

#part("الثاني", "النظام وما يميّز BSD")
#include "chapters/p2-system/ch06-users-permissions.typ"
#include "chapters/p2-system/ch07-pkg.typ"
#include "chapters/p2-system/ch08-ports.typ"
#include "chapters/p2-system/ch09-rc-services.typ"
#include "chapters/p2-system/ch10-install-disks.typ"

#part("الثالث", "قوّة BSD")
#include "chapters/p3-power/ch11-zfs.typ"
#include "chapters/p3-power/ch12-jails.typ"
#include "chapters/p3-power/ch13-pf.typ"
#include "chapters/p3-power/ch14-networking.typ"
#include "chapters/p3-power/ch15-monitoring.typ"

#part("الرابع", "النصوص والتطوير والأمن")
#include "chapters/p4-dev/ch16-text.typ"
#include "chapters/p4-dev/ch17-scripting.typ"
#include "chapters/p4-dev/ch18-security.typ"

#part("الخامس", "الجسر إلى لِينُكس")
#include "chapters/p5-bridge/ch19-linux-bridge.typ"

#part("", "الملاحق")
#include "appendices/appA-bsd-linux.typ"
#include "appendices/appB-pkg-ports.typ"
#include "appendices/appC-glossary.typ"
#include "appendices/appD-sources.typ"
#include "appendices/appE-resources.typ"
