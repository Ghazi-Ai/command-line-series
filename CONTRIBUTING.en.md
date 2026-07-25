# Contributing

<a href="CONTRIBUTING.md">العربية</a> · <a href="CONTRIBUTING.en.md">English</a>

Welcome to **The Command Line Series**. This repository contains six completed
Arabic books, their Typst sources, build tools, covers, and release files.

## Before contributing

- Read the [README](README.md) and the [license](LICENSE).
- Check [project status](PROJECT-STATUS.md) before starting work.
- Do not rebuild or alter completed book files merely to update documentation.
- Use clear LTR formatting for paths, commands, and code, and keep Arabic prose
  in its appropriate RTL direction.

## License and modification limits

The project is published under **CC BY-ND 4.0**. You may read, download, and
share complete unmodified copies with proper attribution. You may not distribute
modified, translated, or derivative versions of the books without the author's
prior written permission.

Therefore:

- Report errors and suggestions through [Issues](https://github.com/Ghazi-Ai/command-line-series/issues).
- Do not open a Pull Request changing book text or Typst files without the
  author's prior approval.
- Documentation, tooling, and README improvements are welcome when they do not
  change the books or released files without prior coordination.

## Useful contributions

- Correct an outdated link, description, or path in the documentation.
- Improve build or EPUB tools without intentionally changing book output.
- Improve accessibility, RTL/LTR handling, and responsive README presentation.
- Report a technical or language issue with the exact file, location, and source.

## Contributing to the English edition

The current edition of the series is Arabic only. Contributions toward an
English translation are welcome, but please open an Issue first to coordinate
terminology and scope. Obtain the author's permission before distributing any
translated version, as a translation is derivative material under CC BY-ND 4.0.

## Build and verification

From the repository root, use `build.sh` for a local build:

```bash
./build.sh
./build.sh 6-unix-story
```

Do not commit local `build/` output. Public downloads are attached to the
[GitHub release](https://github.com/Ghazi-Ai/command-line-series/releases).

For permission requests or project contact:

**Ghazi Alsaif** — `https://github.com/Ghazi-Ai/command-line-series/issues`
