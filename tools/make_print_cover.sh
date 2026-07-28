#!/usr/bin/env bash
# يبني غلافًا ممتدًا من غلافي PDF الرقمي بعد استلام مواصفات المطبعة صراحةً.
set -euo pipefail
cd "$(dirname "$0")/.."

usage() {
  cat >&2 <<'EOF'
الاستعمال:
  tools/make_print_cover.sh \
    --book-id ID \
    --spine-width-mm NUMBER \
    --bleed-mm NUMBER \
    --spine-direction top-to-bottom|bottom-to-top \
    --output FILE.pdf
EOF
}

book_id=
spine_width=
bleed=
direction=
output=

while [ $# -gt 0 ]; do
  case "$1" in
    --book-id) book_id=${2-}; shift 2 ;;
    --spine-width-mm) spine_width=${2-}; shift 2 ;;
    --bleed-mm) bleed=${2-}; shift 2 ;;
    --spine-direction) direction=${2-}; shift 2 ;;
    --output) output=${2-}; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "خيار غير معروف: $1" >&2; usage; exit 2 ;;
  esac
done

for required in book_id spine_width bleed direction output; do
  if [ -z "${!required}" ]; then
    echo "قيمة إلزامية مفقودة: $required" >&2
    usage
    exit 2
  fi
done

case "$book_id" in
  1-linux) pdf=build/1-linux-ar.pdf ;;
  2-macos) pdf=build/2-macos-ar.pdf ;;
  3-windows) pdf=build/3-windows-ar.pdf ;;
  4-bsd) pdf=build/4-bsd-ar.pdf ;;
  5-workbook) pdf=build/5-workbook-ar.pdf ;;
  6-unix-story) pdf=build/6-unix-story-ar.pdf ;;
  *) echo "معرّف كتاب غير معروف: $book_id" >&2; exit 2 ;;
esac

number_re='^[0-9]+([.][0-9]+)?$'
[[ "$spine_width" =~ $number_re ]] || {
  echo "عرض الكعب يجب أن يكون رقمًا بوحدة mm." >&2; exit 2;
}
[[ "$bleed" =~ $number_re ]] || {
  echo "النزف يجب أن يكون رقمًا غير سالب بوحدة mm." >&2; exit 2;
}
awk -v width="$spine_width" 'BEGIN { exit !(width >= 6.5) }' || {
  echo "عرض الكعب $spine_width mm ضيق؛ الحد التصميمي 6.5 mm لحماية مقروئية العنوان والاسم." >&2
  exit 2
}
case "$direction" in
  top-to-bottom|bottom-to-top) ;;
  *) echo "اتجاه الكعب يجب أن يكون top-to-bottom أو bottom-to-top." >&2; exit 2 ;;
esac
case "$output" in
  *.pdf) ;;
  *) echo "يجب أن ينتهي ملف الإخراج بالامتداد .pdf" >&2; exit 2 ;;
esac

[[ -s "$pdf" ]] || {
  echo "ملف PDF الرقمي مفقود: $pdf — شغّل make digital أولًا." >&2
  exit 1
}
command -v pdfinfo >/dev/null 2>&1 || {
  echo "تتطلب الأداة pdfinfo من حزمة Poppler." >&2; exit 1;
}
command -v pdftoppm >/dev/null 2>&1 || {
  echo "تتطلب الأداة pdftoppm من حزمة Poppler." >&2; exit 1;
}

TYPST=${TYPST:-typst}
command -v "$TYPST" >/dev/null 2>&1 || {
  echo "لم أجد Typst." >&2; exit 1;
}
required_typst=$(tr -d '[:space:]' < TYPST_VERSION)
actual_typst=$("$TYPST" --version | awk '{print $2}')
[[ "$actual_typst" = "$required_typst" ]] || {
  echo "يتطلب القالب Typst $required_typst؛ الموجود هو $actual_typst." >&2
  exit 1
}

page_count=$(LC_ALL=C pdfinfo "$pdf" | awk '/^Pages:/ {print $2; exit}')
[[ "$page_count" =~ ^[1-9][0-9]*$ ]] || {
  echo "تعذر تحديد آخر صفحة في $pdf" >&2; exit 1;
}

mkdir -p build
temp_dir=$(mktemp -d build/.cover-spread.XXXXXX)
trap 'rm -rf -- "$temp_dir"' EXIT

pdftoppm -f 1 -l 1 -singlefile -png -r 300 "$pdf" "$temp_dir/back-or-front-first" >/dev/null 2>&1
pdftoppm -f "$page_count" -l "$page_count" -singlefile -png -r 300 \
  "$pdf" "$temp_dir/back-or-front-last" >/dev/null 2>&1

# ملفات PDF الرقمية مرتبة: أمامي ثم متن ثم خلفي.
front="/${temp_dir}/back-or-front-first.png"
back="/${temp_dir}/back-or-front-last.png"
mkdir -p "$(dirname "$output")"

"$TYPST" compile tools/print_cover_spread.typ "$output" \
  --root . --font-path fonts --ignore-system-fonts --pdf-standard 1.5 \
  --input "book-id=$book_id" \
  --input "spine-width-mm=$spine_width" \
  --input "bleed-mm=$bleed" \
  --input "spine-direction=$direction" \
  --input "front-image=$front" \
  --input "back-image=$back"

echo "غلاف معاينة ممتد: $output"
echo "يجب اعتماد اتجاه الكعب والنزف وعرض الكعب مع المطبعة قبل النشر."
