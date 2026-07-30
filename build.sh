#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════
#  بناء كتب السلسلة ببيئة خطوطٍ مثبَّتة داخل المستودع (مجلّد fonts/).
#  النتيجة متسقة في الخطوط والتصفيف وعدد الصفحات ولا تعتمد على خطوط النظام.
#
#  الاستعمال:
#     ./build.sh              يبني الكتب الستة المنشورة
#     ./build.sh 1-linux      يبني كتابًا بعينه
#     ./build.sh 7-automation يبني مسودة الكتاب السابع وحدها
#     ./build.sh 8-server     يبني مسودة الكتاب الثامن وحدها
#     PRINT_INTERIOR=1 ./build.sh   يبني المتون المخصّصة للطباعة
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

print_interior="${PRINT_INTERIOR:-0}"
case "$print_interior" in
  0|1) ;;
  *)
    echo "يجب أن تكون قيمة PRINT_INTERIOR إما 0 أو 1." >&2
    exit 2
    ;;
esac

if [ "$print_interior" = "1" ]; then
  output_dir="build/print"
else
  output_dir="build"
fi
mkdir -p "$output_dir"

# الصفحات المرجعيّة: أيّ اختلافٍ عنها يعني تغيّرًا في المحتوى — لا في البيئة،
# لأنّ الخطوط مثبَّتةٌ والبناء معزول. (0 = كتابٌ لم يكتمل بعدُ فلا مرجع له)
PUBLISHED_BOOKS=(
  "1-linux:1-linux-ar:628"
  "2-macos:2-macos-ar:682"
  "3-windows:3-windows-ar:671"
  "4-bsd:4-bsd-ar:692"
  "5-workbook:5-workbook-ar:140"
  "6-unix-story:6-unix-story-ar:105"
)

DRAFT_BOOKS=(
  "7-automation:7-automation-ar-draft:0"
  "8-server:8-server-ar-draft:0"
)

ALL_BOOKS=("${PUBLISHED_BOOKS[@]}" "${DRAFT_BOOKS[@]}")

if [ $# -gt 1 ]; then
  echo "الاستعمال: ./build.sh [اسم-الكتاب]" >&2
  exit 2
fi
if [ $# -eq 1 ]; then
  found=0
  for entry in "${ALL_BOOKS[@]}"; do
    [ "${entry%%:*}" = "$1" ] && found=1
  done
  if [ "$found" -ne 1 ]; then
    echo "كتاب غير معروف: $1" >&2
    exit 2
  fi
fi

if [ $# -eq 1 ]; then
  BUILD_BOOKS=("${ALL_BOOKS[@]}")
else
  # لا تدخل المسودات في البناء الرقمي أو الإصدار العام دون اعتماد صريح.
  BUILD_BOOKS=("${PUBLISHED_BOOKS[@]}")
fi

pages() {
  local result
  if command -v pdfinfo >/dev/null 2>&1; then
    result=$(LC_ALL=C pdfinfo "$1" | awk '/^Pages:/ {print $2; exit}')
  else
    result=$(python3 -c "
import re, sys
d = open(sys.argv[1], 'rb').read()
counts = [int(m.group(1)) for m in re.finditer(rb'/Count\\s+(\\d+)', d)]
if not counts:
    raise SystemExit('تعذر العثور على عدد الصفحات')
print(max(counts))" "$1")
  fi
  if [[ ! "$result" =~ ^[1-9][0-9]*$ ]]; then
    echo "عدد صفحات غير صالح في $1: ${result:-فارغ}" >&2
    return 1
  fi
  printf '%s\n' "$result"
}

fail=0
for entry in "${BUILD_BOOKS[@]}"; do
  dir="${entry%%:*}"; rest="${entry#*:}"; out="${rest%%:*}"; expect="${rest##*:}"
  if [ $# -gt 0 ] && [ "$1" != "$dir" ]; then continue; fi
  [ -f "books/$dir/ar/main.typ" ] || continue

  compile_args=(
    --root .
    --font-path fonts
    --ignore-system-fonts
    --pdf-standard 1.5
  )
  if [ "$print_interior" = "1" ]; then
    target="$output_dir/$out-interior.pdf"
    compile_args+=(--input print-interior=true)
    if [ "$expect" != "0" ]; then
      expect=$((expect - 2))
    fi
  else
    target="$output_dir/$out.pdf"
  fi

  printf '  %-11s ' "$dir"
  "$TYPST" compile "books/$dir/ar/main.typ" "$target" "${compile_args[@]}"
  p=$(pages "$target")

  if [ "$expect" = "0" ]; then
    echo "$p صفحة   → $target"
  elif [ "$p" = "$expect" ]; then
    echo "$p صفحة ✔ → $target"
  else
    echo "$p صفحة ⚠ المرجع $expect — إن لم تكن غيّرت المحتوى فتحقّق من مجلّد fonts/"
    fail=1
  fi
done

exit $fail
