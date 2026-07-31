#import "/lib/book.typ": part

#part("الأول", "الطريق الذي لا تراه")
#include "chapters/p1-road/ch01-not-cloud.typ"
#include "chapters/p1-road/ch02-packet-journey.typ"
#include "chapters/p1-road/ch03-layers.typ"
#include "chapters/p1-road/ch04-safe-lab.typ"

#part("الثاني", "هويتك في الحي")
#include "chapters/p2-neighborhood/ch05-interface.typ"
#include "chapters/p2-neighborhood/ch06-address-prefix.typ"
#include "chapters/p2-neighborhood/ch07-neighbor-gateway.typ"
#include "chapters/p2-neighborhood/ch08-dhcp.typ"
#include "chapters/p2-neighborhood/ch09-wireless.typ"

#part("الثالث", "من الاسم إلى الطريق")
#include "chapters/p3-names-routes/ch10-dns.typ"
#include "chapters/p3-names-routes/ch11-routing-table.typ"
#include "chapters/p3-names-routes/ch12-hops.typ"
#include "chapters/p3-names-routes/ch13-nat.typ"
#include "chapters/p3-names-routes/ch14-ipv6.typ"

#part("الرابع", "من منفذ إلى محادثة")
#include "chapters/p4-conversation/ch15-ports-sockets.typ"
#include "chapters/p4-conversation/ch16-tcp.typ"
#include "chapters/p4-conversation/ch17-udp.typ"
#include "chapters/p4-conversation/ch18-tls.typ"
#include "chapters/p4-conversation/ch19-curl-http.typ"

#part("الخامس", "شخّص قبل أن تغيّر")
#include "chapters/p5-diagnose/ch20-ladder.typ"
#include "chapters/p5-diagnose/ch21-dns-failure.typ"
#include "chapters/p5-diagnose/ch22-service-silent.typ"
#include "chapters/p5-diagnose/ch23-packet-capture.typ"
#include "chapters/p5-diagnose/ch24-small-lab.typ"
#include "chapters/p5-diagnose/ch25-incident-agent.typ"

#part("", "الملاحق")
#include "appendices/appA-command-map.typ"
#include "appendices/appB-checklists.typ"
#include "appendices/appC-glossary.typ"
#include "appendices/appD-sources.typ"
