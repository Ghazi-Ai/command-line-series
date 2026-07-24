#import "/lib/book.typ": part, appendix

#part("الأول", "الأساسات")
#include "chapters/p1-basics/ch01-what-is-cmdline.typ"
#include "chapters/p1-basics/ch02-navigation.typ"
#include "chapters/p1-basics/ch03-filesystem-tree.typ"
#include "chapters/p1-basics/ch04-viewing-files.typ"
#include "chapters/p1-basics/ch05-manipulating-files.typ"
#include "chapters/p1-basics/ch06-getting-help.typ"
#include "chapters/p1-basics/ch07-arabic-terminal.typ"
#include "chapters/p1-basics/ch08-fluency.typ"

#part("الثاني", "النظام والمستخدمون")
#include "chapters/p2-system/ch09-env-path.typ"
#include "chapters/p2-system/ch10-users-groups-uac.typ"
#include "chapters/p2-system/ch11-permissions-acl.typ"
#include "chapters/p2-system/ch12-registry.typ"
#include "chapters/p2-system/ch13-package-managers.typ"

#part("الثالث", "CMD والباتش")
#include "chapters/p3-cmd/ch14-batch-basics.typ"
#include "chapters/p3-cmd/ch15-batch-control.typ"
#include "chapters/p3-cmd/ch16-cmd-system.typ"
#include "chapters/p3-cmd/ch17-findstr-regex.typ"

#part("الرابع", "PowerShell: القوّة الحديثة")
#include "chapters/p4-powershell/ch18-ps-philosophy.typ"
#include "chapters/p4-powershell/ch19-ps-discovery.typ"
#include "chapters/p4-powershell/ch20-ps-files.typ"
#include "chapters/p4-powershell/ch21-ps-variables.typ"
#include "chapters/p4-powershell/ch22-ps-pipeline.typ"
#include "chapters/p4-powershell/ch23-ps-output.typ"
#include "chapters/p4-powershell/ch24-ps-scripting.typ"
#include "chapters/p4-powershell/ch25-ps-control.typ"
#include "chapters/p4-powershell/ch26-ps-admin.typ"
#include "chapters/p4-powershell/ch27-ps-processes-services.typ"

#part("الخامس", "إدارة النظام")
#include "chapters/p5-sysadmin/ch28-scheduling.typ"
#include "chapters/p5-sysadmin/ch29-disks-storage.typ"
#include "chapters/p5-sysadmin/ch30-event-logs.typ"
#include "chapters/p5-sysadmin/ch31-archive-backup.typ"

#part("السادس", "الشبكات")
#include "chapters/p6-network/ch32-networking.typ"
#include "chapters/p6-network/ch33-firewall-diagnostics.typ"

#part("السابع", "مسار المطوّر")
#include "chapters/p7-dev/ch34-git.typ"
#include "chapters/p7-dev/ch35-terminal-env.typ"

#part("الثامن", "الأمن")
#include "chapters/p8-security/ch36-security-principles.typ"
#include "chapters/p8-security/ch37-defender.typ"
#include "chapters/p8-security/ch38-encryption-bitlocker.typ"
#include "chapters/p8-security/ch39-hardening.typ"

#part("التاسع", "الجسر إلى عالم يونِكس: WSL")
#include "chapters/p9-bridge/ch40-wsl-intro.typ"
#include "chapters/p9-bridge/ch41-wsl-bridge.typ"
#include "chapters/p9-bridge/ch42-which-shell.typ"

#part("", "الملاحق")
#include "appendices/appA-cmd-ps-bash.typ"
#include "appendices/appB-ps-cmdlets.typ"
#include "appendices/appC-glossary.typ"
#include "appendices/appD-sources.typ"
#include "appendices/appE-resources.typ"
