# Makefile — سلسلة سطر الأوامر
# يتطلّب: typst, python3

.PHONY: all pdf digital print print-interiors print-cover book1 book2 book3 book4 book5 book6 book7 book8 book9 book10 epub epub7 epub8 epub9 epub10 release release-check check clean

EPUB_BOOKS := 1-linux 2-macos 3-windows 4-bsd 5-workbook 6-unix-story 7-automation 8-server 9-network 10-projects

all: pdf

pdf:
	./build.sh

digital: pdf

print:
	tools/print_wizard.sh

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

book7:
	./build.sh 7-automation

book8:
	./build.sh 8-server

book9:
	./build.sh 9-network

book10:
	./build.sh 10-projects

epub:
	mkdir -p build
	@set -e; for book in $(EPUB_BOOKS); do \
		typst compile --root . --font-path fonts --ignore-system-fonts --ppi 200 \
			"books/$$book/ar/frontmatter/cover.typ" \
			"build/$$book-ar-cover.png"; \
		python3 tools/make_epub.py "books/$$book/ar" "build/$$book-ar.epub" \
			--cover "build/$$book-ar-cover.png"; \
	done

epub7:
	$(MAKE) EPUB_BOOKS="7-automation" epub

epub8:
	$(MAKE) EPUB_BOOKS="8-server" epub

epub9:
	$(MAKE) EPUB_BOOKS="9-network" epub

epub10:
	$(MAKE) EPUB_BOOKS="10-projects" epub

release: digital print-interiors epub

release-check:
	bash tools/release_check.sh

check:
	bash -n build.sh tools/*.sh
	python3 -m py_compile tools/*.py
	python3 -m py_compile examples/7-automation/guardian/*.py
	cd examples/7-automation/guardian && python3 -m unittest -q test_guardian.py
	python3 tools/check_license_history.py
	git diff --check

clean:
	rm -rf build
