#!/usr/bin/env python3
"""Reject obsolete license wording outside narrow v1.2 history notes."""

from __future__ import annotations

import re
import subprocess
from pathlib import Path


ROOT = Path(__file__).resolve().parent.parent

OBSOLETE_PATTERNS = (
    re.compile(r"CC\s+BY" + r"-ND", re.IGNORECASE),
    re.compile(r"\bBY" + r"-ND\b", re.IGNORECASE),
    re.compile(r"No\s*" + "Derivatives", re.IGNORECASE),
    re.compile(r"No\s+" + "Derivatives", re.IGNORECASE),
    re.compile("بلا " + "اشتقاق"),
    re.compile("منع " + "الاشتقاق"),
    re.compile("منع " + "الترجمة"),
    re.compile("لا يجوز " + "التعديل"),
    re.compile("إذن كتابي " + "للترجمة"),
)

# Every allowed match must remain an explicit statement about version 1.2.
# Do not add directories or broad path globs here.
ALLOWED_HISTORY_LINES = {
    "README.md": (
        re.compile(r"^نُشر الإصدار 1\.2 سابقًا تحت CC BY" + r"-ND 4\.0"),
    ),
    "README.en.md": (
        re.compile(
            r"^Version 1\.2 was previously published under CC BY"
            r"-ND 4\.0\."
        ),
    ),
    "LICENSE": (
        re.compile(r"^نُشر الإصدار 1\.2 سابقًا تحت CC BY" + r"-ND 4\.0\."),
    ),
    "LICENSES/README.md": (
        re.compile(r"^نُشر الإصدار 1\.2 سابقًا تحت CC BY" + r"-ND 4\.0\."),
    ),
    "CHANGELOG.md": (
        re.compile(r"^- الفهرس التفاعليّ .*رخصة CC BY" + r"-ND 4\.0 التي$"),
    ),
}


def tracked_files() -> list[str]:
    result = subprocess.run(
        ["git", "ls-files", "-z"],
        cwd=ROOT,
        check=True,
        stdout=subprocess.PIPE,
    )
    return [item.decode("utf-8") for item in result.stdout.split(b"\0") if item]


def is_allowed_history(path: str, line: str) -> bool:
    return any(
        pattern.search(line)
        for pattern in ALLOWED_HISTORY_LINES.get(path, ())
    )


def main() -> int:
    violations: list[tuple[str, int, str]] = []
    for relative in tracked_files():
        path = ROOT / relative
        try:
            text = path.read_text(encoding="utf-8")
        except (UnicodeDecodeError, OSError):
            continue
        for line_number, line in enumerate(text.splitlines(), start=1):
            if not any(pattern.search(line) for pattern in OBSOLETE_PATTERNS):
                continue
            if not is_allowed_history(relative, line):
                violations.append((relative, line_number, line.strip()))

    if violations:
        print("Obsolete license wording found outside approved v1.2 history lines:")
        for path, line_number, line in violations:
            print(f"{path}:{line_number}: {line}")
        return 1

    print("License-history check passed: old wording appears only in approved v1.2 history lines.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
