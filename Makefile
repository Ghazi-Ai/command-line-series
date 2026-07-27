# Makefile — سلسلة سطر الأوامر
# يتطلّب: typst, python3

.PHONY: all pdf book1 book2 book3 book4 book5 book6 epub release check clean

all: pdf

pdf:
	./build.sh

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

release: pdf epub

check:
	bash -n build.sh
	python3 -m py_compile tools/*.py
	python3 tools/check_license_history.py
	git diff --check

clean:
	rm -rf build
