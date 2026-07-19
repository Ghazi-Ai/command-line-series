#import "/src/lib/book.typ": part, appendix

#part("الأول", "الأساسات")
#include "chapters/p1-foundations/ch01-what-is-terminal.typ"
#include "chapters/p1-foundations/ch02-navigation.typ"
#include "chapters/p1-foundations/ch03-filesystem-tree.typ"
#include "chapters/p1-foundations/ch04-viewing-files.typ"
#include "chapters/p1-foundations/ch05-manipulating-files.typ"
#include "chapters/p1-foundations/ch06-globbing.typ"
#include "chapters/p1-foundations/ch07-getting-help.typ"

#part("الثاني", "النظام والمستخدمون")
#include "chapters/p2-system/ch08-users-groups.typ"
#include "chapters/p2-system/ch09-permissions.typ"
#include "chapters/p2-system/ch10-sudo-root.typ"
#include "chapters/p2-system/ch11-processes.typ"
#include "chapters/p2-system/ch12-packages.typ"

#part("الثالث", "النصوص وتدفّق البيانات")
#include "chapters/p3-text/ch13-streams.typ"
#include "chapters/p3-text/ch14-filters.typ"
#include "chapters/p3-text/ch15-regex.typ"
#include "chapters/p3-text/ch16-sed.typ"
#include "chapters/p3-text/ch17-awk.typ"
#include "chapters/p3-text/ch18-editors.typ"

#part("الرابع", "الصدفة والأتمتة")
#include "chapters/p4-shell/ch19-environment.typ"
#include "chapters/p4-shell/ch20-scripting-basics.typ"
#include "chapters/p4-shell/ch21-control-flow.typ"
#include "chapters/p4-shell/ch22-functions.typ"
#include "chapters/p4-shell/ch23-real-scripts.typ"
#include "chapters/p4-shell/ch24-scheduling.typ"

#part("الخامس", "إدارة النظام")
#include "chapters/p5-sysadmin/ch25-boot-systemd.typ"
#include "chapters/p5-sysadmin/ch26-disks.typ"
#include "chapters/p5-sysadmin/ch27-monitoring.typ"
#include "chapters/p5-sysadmin/ch28-backup.typ"
#include "chapters/p5-sysadmin/ch29-kernel.typ"

#part("السادس", "الشبكات")
#include "chapters/p6-networking/ch30-network-basics.typ"
#include "chapters/p6-networking/ch31-transfer.typ"
#include "chapters/p6-networking/ch32-ssh.typ"
#include "chapters/p6-networking/ch33-firewalls.typ"
#include "chapters/p6-networking/ch34-network-diag.typ"

#part("السابع", "مسار المطوّر")
#include "chapters/p7-developer/ch35-git.typ"
#include "chapters/p7-developer/ch36-build.typ"
#include "chapters/p7-developer/ch37-containers.typ"
#include "chapters/p7-developer/ch38-tmux-dotfiles.typ"
#include "chapters/p7-developer/ch39-modern-tools.typ"

#part("الثامن", "الأمن السيبراني")
#include "chapters/p8-security/ch40-security-ethics.typ"
#include "chapters/p8-security/ch41-recon.typ"
#include "chapters/p8-security/ch42-traffic.typ"
#include "chapters/p8-security/ch43-crypto.typ"
#include "chapters/p8-security/ch44-hardening.typ"
#include "chapters/p8-security/ch45-forensics.typ"

#part("التاسع", "عوالم يونِكس الأخرى: BSD وماك")
#include "chapters/p9-unix-worlds/ch46-bsd.typ"
#include "chapters/p9-unix-worlds/ch47-macos.typ"

#part("", "الملاحق")
#include "appendices/appA-quick-reference.typ"
#include "appendices/appB-package-managers.typ"
#include "appendices/appC-shortcuts.typ"
#include "appendices/appD-practice-lab.typ"
#include "appendices/appE-glossary.typ"
#include "appendices/appF-resources.typ"
