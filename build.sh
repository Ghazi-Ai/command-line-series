#!/usr/bin/env bash
# بناء كتاب «مِن الصِّفر إلى الجَذر» إلى PDF.
# الاستعمال:  ./build.sh [ar|en|all]   (الافتراضي: all)
set -euo pipefail
cd "$(dirname "$0")"

TARGET="${1:-all}"
mkdir -p build

if ! command -v typst >/dev/null 2>&1; then
  echo "خطأ: Typst غير مثبّت. انظر README.md لطريقة التثبيت." >&2
  exit 1
fi

build_ar() {
  echo "» بناء النسخة العربية..."
  typst compile books/1-linux/ar/main.typ build/zero-to-root-ar.pdf --root .
  echo "  ✓ build/zero-to-root-ar.pdf"
}

build_en() {
  if [ -f books/1-linux/en/main.typ ]; then
    echo "» بناء النسخة الإنجليزية..."
    typst compile books/1-linux/en/main.typ build/zero-to-root-en.pdf --root .
    echo "  ✓ build/zero-to-root-en.pdf"
  fi
}

case "$TARGET" in
  ar)  build_ar ;;
  en)  build_en ;;
  all) build_ar; build_en ;;
  *)   echo "هدف غير معروف: $TARGET (استعمل ar أو en أو all)" >&2; exit 1 ;;
esac

echo "تمّ."
