#import "/lib/book.typ": part

#part("الأول", "تعرّف إلى الآلة البعيدة")
#include "chapters/p1-machine/ch01-rented-machine.typ"
#include "chapters/p1-machine/ch02-ownership-map.typ"
#include "chapters/p1-machine/ch03-first-connection.typ"
#include "chapters/p1-machine/ch04-your-user.typ"

#part("الثاني", "اقرأ نبض الخادم")
#include "chapters/p2-pulse/ch05-filesystem.typ"
#include "chapters/p2-pulse/ch06-processes.typ"
#include "chapters/p2-pulse/ch07-services.typ"
#include "chapters/p2-pulse/ch08-logs.typ"
#include "chapters/p2-pulse/ch09-packages.typ"

#part("الثالث", "أبواب بقدر الحاجة")
#include "chapters/p3-doors/ch10-ssh-hardening.typ"
#include "chapters/p3-doors/ch11-firewall.typ"
#include "chapters/p3-doors/ch12-permissions-secrets.typ"
#include "chapters/p3-doors/ch13-security-updates.typ"
#include "chapters/p3-doors/ch14-backups.typ"

#part("الرابع", "من خادم فارغ إلى خدمة")
#include "chapters/p4-service/ch15-address-domain.typ"
#include "chapters/p4-service/ch16-web-proxy.typ"
#include "chapters/p4-service/ch17-tls.typ"
#include "chapters/p4-service/ch18-app-service.typ"
#include "chapters/p4-service/ch19-data.typ"
#include "chapters/p4-service/ch20-containers.typ"

#part("الخامس", "حين تنام أنت")
#include "chapters/p5-operations/ch21-monitoring.typ"
#include "chapters/p5-operations/ch22-scheduling.typ"
#include "chapters/p5-operations/ch23-incident.typ"
#include "chapters/p5-operations/ch24-agents.typ"
#include "chapters/p5-operations/ch25-handover.typ"

#part("", "الملاحق")
#include "appendices/appA-runbook.typ"
#include "appendices/appB-checklists.typ"
#include "appendices/appC-glossary.typ"
#include "appendices/appD-sources.typ"
