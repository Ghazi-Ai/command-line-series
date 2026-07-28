# Makefile — سلسلة سطر الأوامر
# يتطلّب: typst, python3

.PHONY: all pdf digital print-interiors print-cover book1 book2 book3 book4 book5 book6 epub release release-check check clean

EPUB_BOOKS := 1-linux 2-macos 3-windows 4-bsd 5-workbook 6-unix-story

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
		--spine-direction "$(if $(SPINE_DIRECTION),$(SPINE_DIRECTION),bottom-to-top)" \
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
	mkdir -p build
	@set -e; for book in $(EPUB_BOOKS); do \
		typst compile --root . --font-path fonts --ignore-system-fonts --ppi 200 \
			"books/$$book/ar/frontmatter/cover.typ" \
			"build/$$book-ar-cover.png"; \
		python3 tools/make_epub.py "books/$$book/ar" "build/$$book-ar.epub" \
			--cover "build/$$book-ar-cover.png"; \
	done

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
