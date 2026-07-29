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
  "6-unix-story-ar:105"
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

epub_root=$(mktemp -d build/.epub-check.XXXXXX)
trap 'rm -rf -- "$epub_root"' EXIT
for entry in "${BOOKS[@]}"; do
  name=${entry%%:*}
  epub="build/$name.epub"
  generated_cover="build/$name-cover.png"
  epub_dir="$epub_root/$name"
  [[ -s "$epub" ]] || { echo "ملف EPUB مفقود: $epub" >&2; exit 1; }
  unzip -t "$epub" >/dev/null
  mkdir -p "$epub_dir"
  unzip -q "$epub" -d "$epub_dir"
  python3 - "$epub_dir" "$generated_cover" "$name" <<'PY'
from pathlib import Path
import sys
import xml.etree.ElementTree as ET

root = Path(sys.argv[1])
generated_cover = Path(sys.argv[2])
book_name = sys.argv[3]
xml_files = [
    path for path in root.rglob("*")
    if path.suffix.lower() in {".xml", ".xhtml", ".opf", ".ncx"}
]
if not xml_files:
    raise SystemExit("لا توجد ملفات XML داخل EPUB")
for path in xml_files:
    ET.parse(path)

opf = (root / "OEBPS/content.opf").read_text(encoding="utf-8")
nav = (root / "OEBPS/nav.xhtml").read_text(encoding="utf-8")
embedded_cover = root / "OEBPS/images/cover.png"
pages = "\n".join(
    path.read_text(encoding="utf-8")
    for path in sorted((root / "OEBPS").glob("p*.xhtml"))
)
required = {
    "اتجاه RTL": 'page-progression-direction="rtl"' in opf and 'dir="rtl"' in pages,
    "الفهرس": 'epub:type="toc"' in nav,
    "صفحة الحقوق": "الحقوق والرخصة" in pages,
    "الإفصاح": "نصوصها الأساسية وُلّدت باستخدام أدوات الذكاء الاصطناعي" in pages,
    "تحويل روابط Typst": "#link(" not in pages,
    "اتجاه خرج الطرفية": (
        'class="term"' not in pages
        or ('class="out terminal-line" dir="auto"' in pages and 'class="cmd" dir="ltr"' in pages)
    ),
    "الغلاف المولّد من المصدر الحالي": (
        embedded_cover.is_file()
        and generated_cover.is_file()
        and embedded_cover.read_bytes() == generated_cover.read_bytes()
    ),
}
if book_name == "6-unix-story-ar":
    required["روابط المصادر"] = 'href="https://doi.org/' in pages
missing = [name for name, present in required.items() if not present]
if missing:
    raise SystemExit("فشل فحص EPUB: " + "، ".join(missing))
PY
  printf '  %-20s EPUB سليم ✔\n' "$name"
done
echo "اكتملت فحوص مخرجات الإصدار."
