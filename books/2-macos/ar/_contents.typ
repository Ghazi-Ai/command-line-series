#import "/lib/book.typ": part, appendix

#part("الأول", "الأساسات")
#include "chapters/p1-basics/ch01-what-is-terminal-mac.typ"
#include "chapters/p1-basics/ch02-navigation.typ"
#include "chapters/p1-basics/ch03-filesystem-tree.typ"
#include "chapters/p1-basics/ch04-viewing-files.typ"
#include "chapters/p1-basics/ch05-manipulating-files.typ"
#include "chapters/p1-basics/ch06-globbing.typ"
#include "chapters/p1-basics/ch07-getting-help.typ"
#include "chapters/p1-basics/ch08-arabic-terminal.typ"

#part("الثاني", "النظام والمستخدمون")
#include "chapters/p2-system/ch09-users-groups.typ"
#include "chapters/p2-system/ch10-permissions-acl.typ"
#include "chapters/p2-system/ch11-sudo-root-sip.typ"
#include "chapters/p2-system/ch12-processes.typ"
#include "chapters/p2-system/ch13-homebrew.typ"

#part("الثالث", "النصوص وتدفّق البيانات")
#include "chapters/p3-text/ch14-streams-pipes.typ"
#include "chapters/p3-text/ch15-bsd-vs-gnu.typ"
#include "chapters/p3-text/ch16-regex.typ"
#include "chapters/p3-text/ch17-sed-awk.typ"
#include "chapters/p3-text/ch18-editors.typ"

#part("الرابع", "الصدفة والأتمتة")
#include "chapters/p4-shell/ch19-zsh.typ"
#include "chapters/p4-shell/ch20-environment.typ"
#include "chapters/p4-shell/ch21-scripting.typ"
#include "chapters/p4-shell/ch22-control-flow.typ"
#include "chapters/p4-shell/ch23-real-world-scripts.typ"

#part("الخامس", "إدارة النظام")
#include "chapters/p5-sysadmin/ch24-launchd.typ"
#include "chapters/p5-sysadmin/ch25-scheduling.typ"
#include "chapters/p5-sysadmin/ch26-disks-apfs.typ"
#include "chapters/p5-sysadmin/ch27-monitoring.typ"
#include "chapters/p5-sysadmin/ch28-archive-backup.typ"

#part("السادس", "الشبكات")
#include "chapters/p6-network/ch29-networking-basics.typ"
#include "chapters/p6-network/ch30-transfer-download.typ"
#include "chapters/p6-network/ch31-ssh-basics.typ"
#include "chapters/p6-network/ch32-ssh-advanced.typ"
#include "chapters/p6-network/ch33-firewall-diagnostics.typ"

#part("السابع", "مسار المطوّر")
#include "chapters/p7-dev/ch34-git.typ"
#include "chapters/p7-dev/ch35-dev-environments.typ"
#include "chapters/p7-dev/ch36-containers.typ"
#include "chapters/p7-dev/ch37-mac-native.typ"
#include "chapters/p7-dev/ch38-terminal-env.typ"

#part("الثامن", "الأمن")
#include "chapters/p8-security/ch39-security-principles.typ"
#include "chapters/p8-security/ch40-security-ethics-law.typ"
#include "chapters/p8-security/ch41-app-protection.typ"
#include "chapters/p8-security/ch42-system-data-protection.typ"
#include "chapters/p8-security/ch43-storage-encryption.typ"
#include "chapters/p8-security/ch44-encryption-passwords.typ"
#include "chapters/p8-security/ch45-system-hardening.typ"
#include "chapters/p8-security/ch46-logs-forensics.typ"

#part("التاسع", "الجسر إلى عوالم يونِكس")
#include "chapters/p9-bridge/ch47-linux-bsd-bridge.typ"

#part("", "الملاحق")
#include "appendices/appA-mac-linux-bsd.typ"
#include "appendices/appB-homebrew.typ"
#include "appendices/appC-glossary.typ"
#include "appendices/appD-sources.typ"
#include "appendices/appE-resources.typ"
