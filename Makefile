# Makefile — سلسلة سطر الأوامر
# يتطلّب: typst, python3

.PHONY: all pdf digital print-interiors print-cover book1 book2 book3 book4 book5 book6 epub release release-check check clean

all: pdf

pdf:
	./build.sh

digital: pdf

print-interiors:
	PRINT_INTERIOR=1 ./build.sh

print-cover:
	tools/make_print_cover.sh \
		--book-id "$(BOOK_ID)" \
		--spine-width-mm "$(SPINE_WIDTH_MM)" \
		--bleed-mm "$(BLEED_MM)" \
		--spine-direction "$(SPINE_DIRECTION)" \
		--output "$(OUTPUT)"

book1:
	./build.sh 1-linux

book2:
	./build.sh 2-macos

book3:
	./build.sh 3-windows

book4:
	./build.sh 4-bsd

book5:
	./build.sh 5-workbook

book6:
	./build.sh 6-unix-story

epub:
	python3 tools/make_epub.py books/6-unix-story/ar build/6-unix-story-ar.epub

release: digital print-interiors epub

release-check:
	bash tools/release_check.sh

check:
	bash -n build.sh tools/*.sh
	python3 -m py_compile tools/*.py
	python3 tools/check_license_history.py
	git diff --check

clean:
	rm -rf build
