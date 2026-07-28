#!/usr/bin/env bash
# فحوص محلية موجزة لمخرجات الإصدار الرقمية وملفات المتن وEPUB.
set -euo pipefail
cd "$(dirname "$0")/.."

BOOKS=(
  "1-linux-ar:628"
  "2-macos-ar:682"
  "3-windows-ar:671"
  "4-bsd-ar:692"
  "5-workbook-ar:140"
  "6-unix-story-ar:114"
)

pages() {
  local result
  if command -v pdfinfo >/dev/null 2>&1; then
    result=$(LC_ALL=C pdfinfo "$1" | awk '/^Pages:/ {print $2; exit}')
  else
    result=$(python3 -c '
import re, sys
data = open(sys.argv[1], "rb").read()
counts = [int(m.group(1)) for m in re.finditer(rb"/Count\s+(\d+)", data)]
if not counts:
    raise SystemExit("تعذر العثور على عدد الصفحات")
print(max(counts))
' "$1")
  fi
  [[ "$result" =~ ^[1-9][0-9]*$ ]] || {
    echo "عدد صفحات غير صالح في $1: ${result:-فارغ}" >&2
    return 1
  }
  printf '%s\n' "$result"
}

check_pdf() {
  local file=$1
  if command -v qpdf >/dev/null 2>&1; then
    qpdf --check "$file" >/dev/null
  elif command -v gs >/dev/null 2>&1; then
    gs -q -dNOPAUSE -dBATCH -sDEVICE=nullpage "$file" >/dev/null
  else
    echo "تحذير: لم يتوفر qpdf أو Ghostscript؛ اكتُفي بفحص بنية الملف وعدد صفحاته." >&2
    [[ $(head -c 5 "$file") == "%PDF-" ]]
  fi
}

for entry in "${BOOKS[@]}"; do
  name=${entry%%:*}
  digital_expected=${entry##*:}
  interior_expected=$((digital_expected - 2))
  digital="build/$name.pdf"
  interior="build/print/$name-interior.pdf"

  [[ -s "$digital" ]] || { echo "ملف رقمي مفقود: $digital" >&2; exit 1; }
  [[ -s "$interior" ]] || { echo "ملف متن مفقود: $interior" >&2; exit 1; }
  [[ $(pages "$digital") = "$digital_expected" ]] || {
    echo "عدد صفحات غير متوقع: $digital" >&2; exit 1;
  }
  [[ $(pages "$interior") = "$interior_expected" ]] || {
    echo "عدد صفحات غير متوقع: $interior" >&2; exit 1;
  }
  check_pdf "$digital"
  check_pdf "$interior"
  printf '  %-20s %s / %s صفحة ✔\n' "$name" "$digital_expected" "$interior_expected"
done

epub="build/6-unix-story-ar.epub"
[[ -s "$epub" ]] || { echo "ملف EPUB مفقود: $epub" >&2; exit 1; }
unzip -t "$epub" >/dev/null
echo "  EPUB سليم ✔"
echo "اكتملت فحوص مخرجات الإصدار."
