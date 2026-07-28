#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════
#  بناء كتب السلسلة ببيئة خطوطٍ مثبَّتة داخل المستودع (مجلّد fonts/).
#  النتيجة متسقة في الخطوط والتصفيف وعدد الصفحات ولا تعتمد على خطوط النظام.
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

required_typst=$(tr -d '[:space:]' < TYPST_VERSION)
actual_typst=$("$TYPST" --version | awk '{print $2}')
if [ "$actual_typst" != "$required_typst" ]; then
  echo "يتطلب البناء Typst $required_typst؛ الموجود هو $actual_typst." >&2
  exit 1
fi

mkdir -p build

# الصفحات المرجعيّة: أيّ اختلافٍ عنها يعني تغيّرًا في المحتوى — لا في البيئة،
# لأنّ الخطوط مثبَّتةٌ والبناء معزول. (0 = كتابٌ لم يكتمل بعدُ فلا مرجع له)
BOOKS=(
  "1-linux:1-linux-ar:628"
  "2-macos:2-macos-ar:682"
  "3-windows:3-windows-ar:671"
  "4-bsd:4-bsd-ar:692"
  "5-workbook:5-workbook-ar:140"
  "6-unix-story:6-unix-story-ar:114"
)

if [ $# -gt 1 ]; then
  echo "الاستعمال: ./build.sh [اسم-الكتاب]" >&2
  exit 2
fi
if [ $# -eq 1 ]; then
  found=0
  for entry in "${BOOKS[@]}"; do
    [ "${entry%%:*}" = "$1" ] && found=1
  done
  if [ "$found" -ne 1 ]; then
    echo "كتاب غير معروف: $1" >&2
    exit 2
  fi
fi

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
      --root . --font-path fonts --ignore-system-fonts \
      --pdf-standard 1.5
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
