#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════
#  بناء كتب السلسلة ببيئة خطوطٍ مثبَّتة داخل المستودع (مجلّد fonts/).
#  النتيجة متطابقةٌ على أيّ جهاز: لا تتأثّر بخطوط النظام ولا باختلاف نسخها.
#
#  الاستعمال:
#     ./build.sh              يبني الكتب كلّها
#     ./build.sh 1-linux      يبني كتابًا بعينه
#     TYPST=~/.local/bin/typst ./build.sh      إن لم يكن typst في PATH
# ═══════════════════════════════════════════════════════════════════════════
set -euo pipefail
cd "$(dirname "$0")"

TYPST="${TYPST:-typst}"
command -v "$TYPST" >/dev/null 2>&1 || {
  echo "لم أجد typst. حدّده هكذا:  TYPST=~/.local/bin/typst ./build.sh" >&2; exit 1; }

mkdir -p build

# الصفحات المرجعيّة: أيّ اختلافٍ عنها يعني تغيّرًا في المحتوى — لا في البيئة،
# لأنّ الخطوط مثبَّتةٌ والبناء معزول. (0 = كتابٌ لم يكتمل بعدُ فلا مرجع له)
BOOKS=(
  "1-linux:zero-to-root-ar:590"
  "2-macos:mac-ar:227"
  "3-windows:windows-ar:306"
  "4-bsd:bsd-ar:0"
)

pages() { python3 -c "
import re, sys
d = open(sys.argv[1],'rb').read()
print(max(int(m.group(1)) for m in re.finditer(rb'/Count\s+(\d+)', d)))" "$1"; }

fail=0
for entry in "${BOOKS[@]}"; do
  dir="${entry%%:*}"; rest="${entry#*:}"; out="${rest%%:*}"; expect="${rest##*:}"
  if [ $# -gt 0 ] && [ "$1" != "$dir" ]; then continue; fi
  [ -f "books/$dir/ar/main.typ" ] || continue

  printf '  %-11s ' "$dir"
  "$TYPST" compile "books/$dir/ar/main.typ" "build/$out.pdf" \
      --root . --font-path fonts --ignore-system-fonts
  p=$(pages "build/$out.pdf")

  if [ "$expect" = "0" ]; then
    echo "$p صفحة   → build/$out.pdf"
  elif [ "$p" = "$expect" ]; then
    echo "$p صفحة ✔ → build/$out.pdf"
  else
    echo "$p صفحة ⚠ المرجع $expect — إن لم تكن غيّرت المحتوى فتحقّق من مجلّد fonts/"
    fail=1
  fi
done

exit $fail
