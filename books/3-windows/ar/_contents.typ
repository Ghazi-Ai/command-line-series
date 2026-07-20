#import "/lib/book.typ": part, appendix

#part("الأول", "أساسيات سطر أوامر ويندوز")
#include "chapters/p1-basics/ch01-what-is-cmdline.typ"
#include "chapters/p1-basics/ch02-navigation.typ"
#include "chapters/p1-basics/ch03-viewing-files.typ"
#include "chapters/p1-basics/ch04-manipulating-files.typ"
#include "chapters/p1-basics/ch05-getting-help.typ"

#part("الثاني", "CMD والباتش")
#include "chapters/p2-cmd/ch06-env-path.typ"
#include "chapters/p2-cmd/ch07-batch-basics.typ"
#include "chapters/p2-cmd/ch08-batch-control.typ"
#include "chapters/p2-cmd/ch09-cmd-system.typ"

#part("الثالث", "PowerShell: القوّة الحديثة")
#include "chapters/p3-powershell/ch10-ps-philosophy.typ"
#include "chapters/p3-powershell/ch11-ps-discovery.typ"
#include "chapters/p3-powershell/ch12-ps-files.typ"
#include "chapters/p3-powershell/ch13-ps-variables.typ"
#include "chapters/p3-powershell/ch14-ps-pipeline.typ"
#include "chapters/p3-powershell/ch15-ps-output.typ"
#include "chapters/p3-powershell/ch16-ps-scripting.typ"
#include "chapters/p3-powershell/ch17-ps-control.typ"
#include "chapters/p3-powershell/ch18-ps-admin.typ"
#include "chapters/p3-powershell/ch19-ps-network.typ"

#part("الرابع", "WSL: لِينُكس داخل ويندوز")
#include "chapters/p4-wsl/ch20-wsl-intro.typ"
#include "chapters/p4-wsl/ch21-wsl-bridge.typ"
#include "chapters/p4-wsl/ch22-which-shell.typ"

#part("", "الملاحق")
#include "appendices/appA-cmd-ps-bash.typ"
#include "appendices/appB-ps-cmdlets.typ"
#include "appendices/appC-glossary.typ"
#include "appendices/appD-sources.typ"
#include "appendices/appE-resources.typ"
