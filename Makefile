# Makefile — «مِن الصِّفر إلى الجَذر»
# يتطلّب: typst, python3

.PHONY: all ar en watch-ar watch-en structure clean

all: ar en

ar:
	@mkdir -p build
	typst compile books/1-linux/ar/main.typ build/zero-to-root-ar.pdf --root .

en:
	@mkdir -p build
	@if [ -f books/1-linux/en/main.typ ]; then \
		typst compile books/1-linux/en/main.typ build/zero-to-root-en.pdf --root . ; \
	fi

watch-ar:
	@mkdir -p build
	typst watch books/1-linux/ar/main.typ build/zero-to-root-ar.pdf --root .

watch-en:
	@mkdir -p build
	typst watch books/1-linux/en/main.typ build/zero-to-root-en.pdf --root .

# يعيد توليد ملفّات الهيكل والفهرس بعد تعديل المنهج في المولّد
structure:
	python3 tools/generate_structure.py

clean:
	rm -rf build
