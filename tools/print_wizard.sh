#!/usr/bin/env bash
# معالج تفاعلي لبناء حزمة الطباعة: المتن والغلاف الممتد.
set -euo pipefail
cd "$(dirname "$0")/.."

BOOK_IDS=(
  "1-linux"
  "2-macos"
  "3-windows"
  "4-bsd"
  "5-workbook"
  "6-unix-story"
  "7-automation"
  "8-server"
  "9-network"
  "10-projects"
)
BOOK_TITLES=(
  "مِن الصفر إلى الجذر — Linux"
  "ماك من الطرفية — macOS"
  "مِن الصفر إلى المسؤول — Windows"
  "مِن الصفر إلى العفريت — BSD"
  "الطرفية بالممارسة"
  "روح في الآلة — حكاية يونكس"
  "مِن الأمر إلى الأتمتة"
  "الخادم الذي لا ينام"
  "الشبكة من الطرفية"
  "10+ مشاريع كبرى من الطرفية"
)

SPINE_WIDTHS=()

cancelled() {
  printf '\nأُلغي معالج الطباعة؛ لم تُنشأ ملفات جديدة.\n'
  exit 0
}

read_answer() {
  local prompt=$1
  printf '%s' "$prompt"
  IFS= read -r ANSWER || cancelled
}

require_tools() {
  local typst_bin=${TYPST:-typst}
  local tool
  for tool in "$typst_bin" pdfinfo pdftoppm; do
    command -v "$tool" >/dev/null 2>&1 || {
      printf 'الأداة المطلوبة غير موجودة: %s\n' "$tool" >&2
      printf 'راجع docs/PRINTING.md لتثبيت متطلبات البناء.\n' >&2
      exit 1
    }
  done

  local required_typst actual_typst
  required_typst=$(tr -d '[:space:]' < TYPST_VERSION)
  actual_typst=$("$typst_bin" --version | awk '{print $2}')
  if [ "$actual_typst" != "$required_typst" ]; then
    printf 'يتطلب المشروع Typst %s؛ الموجود هو %s.\n' \
      "$required_typst" "$actual_typst" >&2
    exit 1
  fi
}

choose_books() {
  local choice
  while true; do
    printf '\nسلسلة سطر الأوامر — معالج حزمة الطباعة\n\n'
    printf '0) جميع الكتب\n'
    local index
    for index in "${!BOOK_IDS[@]}"; do
      printf '%d) %s\n' "$((index + 1))" "${BOOK_TITLES[$index]}"
    done
    printf 'q) إلغاء\n\n'
    read_answer 'اختيارك: '
    choice=$ANSWER
    case "$choice" in
      0)
        SELECTED_INDEXES=(0 1 2 3 4 5 6 7 8 9)
        return
        ;;
      1|2|3|4|5|6|7|8|9|10)
        SELECTED_INDEXES=("$((choice - 1))")
        return
        ;;
      q|Q)
        cancelled
        ;;
      *)
        printf 'اختيار غير صحيح. اختر رقمًا من 0 إلى 10، أو q للإلغاء.\n'
        ;;
    esac
  done
}

book_title() {
  local wanted=$1
  local index
  for index in "${!BOOK_IDS[@]}"; do
    if [ "${BOOK_IDS[$index]}" = "$wanted" ]; then
      printf '%s' "${BOOK_TITLES[$index]}"
      return
    fi
  done
}

read_decimal() {
  local label=$1
  local minimum=$2
  local value
  while true; do
    read_answer "$label"
    value=$ANSWER
    if [[ "$value" =~ ^[0-9]+([.][0-9]+)?$ ]] &&
       awk -v value="$value" -v minimum="$minimum" \
         'BEGIN { exit !(value >= minimum) }'; then
      DECIMAL_VALUE=$value
      return
    fi
    printf 'أدخل رقمًا لا يقل عن %s، واستعمل النقطة للفاصلة العشرية.\n' \
      "$minimum" >&2
  done
}

read_spine_widths() {
  local index book
  printf '\nأدخل عرض الكعب الذي أعطتك إياه المطبعة لكل كتاب.\n'
  printf 'لا يُحسب العرض تلقائيًا، والحد التصميمي للقالب 6.5 mm.\n\n'
  for index in "${SELECTED_INDEXES[@]}"; do
    book=${BOOK_IDS[$index]}
    read_decimal "عرض كعب «$(book_title "$book")» بالملليمتر: " "6.5"
    SPINE_WIDTHS[$index]=$DECIMAL_VALUE
  done
}

choose_direction() {
  local choice
  while true; do
    printf '\nاتجاه قراءة نص الكعب:\n'
    printf '1) bottom-to-top — اتجاه السلسلة المعتمد\n'
    printf '2) top-to-bottom — فقط إذا طلبته المطبعة\n'
    read_answer 'اختيارك [1]: '
    choice=$ANSWER
    case "$choice" in
      ""|1|bottom-to-top)
        SPINE_DIRECTION=bottom-to-top
        return
        ;;
      2|top-to-bottom)
        SPINE_DIRECTION=top-to-bottom
        return
        ;;
      *)
        printf 'اختيار غير صحيح؛ اختر 1 أو 2.\n'
        ;;
    esac
  done
}

confirm_settings() {
  local index book answer
  printf '\nملخص حزمة الطباعة\n'
  printf 'النزف: %s mm\n' "$BLEED_MM"
  printf 'اتجاه الكعب: %s\n' "$SPINE_DIRECTION"
  for index in "${SELECTED_INDEXES[@]}"; do
    book=${BOOK_IDS[$index]}
    printf -- '- %s: كعب %s mm\n' \
      "$(book_title "$book")" "${SPINE_WIDTHS[$index]}"
  done
  printf '\nسيُعاد بناء PDF الرقمي والمتن للكتب المختارة، ثم تُنشأ الأغلفة.\n'
  read_answer 'هل تريد المتابعة؟ [y/N]: '
  answer=$ANSWER
  case "$answer" in
    y|Y|yes|YES|Yes|ن|نعم) ;;
    *) cancelled ;;
  esac
}

build_selected_books() {
  if [ "${#SELECTED_INDEXES[@]}" -eq "${#BOOK_IDS[@]}" ]; then
    printf '\nبناء ملفات PDF الرقمية للكتب العشرة...\n'
    ./build.sh
    printf '\nبناء ملفات المتون للكتب العشرة...\n'
    PRINT_INTERIOR=1 ./build.sh
  else
    local index=${SELECTED_INDEXES[0]}
    local book=${BOOK_IDS[$index]}
    printf '\nبناء PDF الرقمي: %s\n' "$(book_title "$book")"
    ./build.sh "$book"
    printf '\nبناء ملف المتن: %s\n' "$(book_title "$book")"
    PRINT_INTERIOR=1 ./build.sh "$book"
  fi
}

build_covers() {
  local index book output
  mkdir -p build/print-covers
  for index in "${SELECTED_INDEXES[@]}"; do
    book=${BOOK_IDS[$index]}
    output="build/print-covers/$book-ar-cover.pdf"
    tools/make_print_cover.sh \
      --book-id "$book" \
      --spine-width-mm "${SPINE_WIDTHS[$index]}" \
      --bleed-mm "$BLEED_MM" \
      --spine-direction "$SPINE_DIRECTION" \
      --output "$output"
  done
}

show_results() {
  local index book
  printf '\nاكتملت حزمة الطباعة:\n\n'
  for index in "${SELECTED_INDEXES[@]}"; do
    book=${BOOK_IDS[$index]}
    printf '%s\n' "$(book_title "$book")"
    printf '  المتن:   build/print/%s-ar-interior.pdf\n' "$book"
    printf '  الغلاف:  build/print-covers/%s-ar-cover.pdf\n\n' "$book"
  done
  printf 'اعرض الغلاف والمتن على المطبعة واطلب عينة طباعة قبل الإنتاج النهائي.\n'
}

require_tools
choose_books
read_spine_widths
read_decimal 'مقدار النزف Bleed الذي طلبته المطبعة بالملليمتر: ' "0"
BLEED_MM=$DECIMAL_VALUE
choose_direction
confirm_settings
build_selected_books
build_covers
show_results
