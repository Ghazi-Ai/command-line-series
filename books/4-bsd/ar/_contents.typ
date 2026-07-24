#import "/lib/book.typ": part, appendix

#part("الأول", "الأساسات")
#include "chapters/p1-basics/ch01-what-is-bsd.typ"
#include "chapters/p1-basics/ch02-shell.typ"
#include "chapters/p1-basics/ch03-filesystem-tree.typ"
#include "chapters/p1-basics/ch04-viewing-files.typ"
#include "chapters/p1-basics/ch05-manipulating-files.typ"
#include "chapters/p1-basics/ch06-getting-help.typ"
#include "chapters/p1-basics/ch07-fluency.typ"
#include "chapters/p1-basics/ch08-arabic-terminal.typ"

#part("الثاني", "النظام والمستخدمون")
#include "chapters/p2-system/ch09-users-groups.typ"
#include "chapters/p2-system/ch10-permissions-flags.typ"
#include "chapters/p2-system/ch11-doas-root.typ"
#include "chapters/p2-system/ch12-processes.typ"
#include "chapters/p2-system/ch13-pkg.typ"

#part("الثالث", "النصوص وتدفّق البيانات")
#include "chapters/p3-text/ch14-streams-pipes.typ"
#include "chapters/p3-text/ch15-filtering-regex.typ"
#include "chapters/p3-text/ch16-sed-awk.typ"
#include "chapters/p3-text/ch17-editors.typ"

#part("الرابع", "الصدفة والأتمتة")
#include "chapters/p4-shell/ch18-environment.typ"
#include "chapters/p4-shell/ch19-scripting.typ"
#include "chapters/p4-shell/ch20-control-flow.typ"
#include "chapters/p4-shell/ch21-real-world-scripts.typ"

#part("الخامس", "إدارة النظام")
#include "chapters/p5-sysadmin/ch22-rc-services.typ"
#include "chapters/p5-sysadmin/ch23-boot-install.typ"
#include "chapters/p5-sysadmin/ch24-ports.typ"
#include "chapters/p5-sysadmin/ch25-scheduling.typ"
#include "chapters/p5-sysadmin/ch26-disks-ufs-geom.typ"
#include "chapters/p5-sysadmin/ch27-monitoring.typ"
#include "chapters/p5-sysadmin/ch28-archive-backup.typ"

#part("السادس", "الشبكات")
#include "chapters/p6-network/ch29-networking.typ"
#include "chapters/p6-network/ch30-ssh.typ"
#include "chapters/p6-network/ch31-pf-firewall.typ"

#part("السابع", "التخزين والعزل والتطوير")
#include "chapters/p7-power/ch32-zfs.typ"
#include "chapters/p7-power/ch33-jails.typ"
#include "chapters/p7-power/ch34-git.typ"
#include "chapters/p7-power/ch35-terminal-env.typ"

#part("الثامن", "الأمن")
#include "chapters/p8-security/ch36-security-principles.typ"
#include "chapters/p8-security/ch37-bsd-builtin-security.typ"
#include "chapters/p8-security/ch38-encryption-geli.typ"
#include "chapters/p8-security/ch39-hardening.typ"

#part("التاسع", "الجسر إلى عالم لِينُكس")
#include "chapters/p9-bridge/ch40-linux-bridge.typ"

#part("", "الملاحق")
#include "appendices/appA-bsd-linux.typ"
#include "appendices/appB-pkg-ports.typ"
#include "appendices/appC-glossary.typ"
#include "appendices/appD-sources.typ"
#include "appendices/appE-resources.typ"
