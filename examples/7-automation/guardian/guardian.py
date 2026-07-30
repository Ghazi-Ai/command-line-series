#!/usr/bin/env python3
"""حارس صندوق الوارد: المثال المرجعي للكتاب السابع."""

from __future__ import annotations

import argparse
import fnmatch
import json
import os
import shutil
import sys
import uuid
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Iterable


EXIT_USAGE = 2
EXIT_CONFIG = 3
EXIT_CONFLICT = 4
EXIT_LOCKED = 5
EXIT_PARTIAL = 6
LAB_MARKER = ".guardian-lab"


class GuardianError(Exception):
    """خطأ متوقع يستطيع البرنامج شرحه للمستخدم."""


class ConflictError(GuardianError):
    """تعارض يمنع بدء دفعة النقل."""


class LockedError(GuardianError):
    """تشغيل آخر قائم أو قفل يحتاج مراجعة."""


class PartialRunError(GuardianError):
    """فشل بعد حدوث أثر واحد على الأقل."""


@dataclass(frozen=True)
class Settings:
    root: Path
    inbox: Path
    archive: Path
    logs: Path
    pattern: str


@dataclass(frozen=True)
class Action:
    action: str
    source: Path
    destination: Path | None = None
    reason: str | None = None

    def as_dict(self, root: Path) -> dict[str, str]:
        data = {
            "action": self.action,
            "source": str(self.source.relative_to(root)),
        }
        if self.destination is not None:
            data["destination"] = str(self.destination.relative_to(root))
        if self.reason is not None:
            data["reason"] = self.reason
        return data


def utc_now() -> str:
    return datetime.now(timezone.utc).isoformat(timespec="seconds")


def inside(root: Path, candidate: Path) -> bool:
    try:
        candidate.relative_to(root)
    except ValueError:
        return False
    return True


def resolve_inside(root: Path, value: str, label: str) -> Path:
    candidate = (root / value).expanduser().resolve()
    if not inside(root, candidate):
        raise GuardianError(f"{label} يخرج من جذر المختبر: {candidate}")
    return candidate


def load_settings(config_path: Path) -> Settings:
    try:
        raw: dict[str, Any] = json.loads(config_path.read_text(encoding="utf-8"))
    except FileNotFoundError as error:
        raise GuardianError(f"ملف الإعداد غير موجود: {config_path}") from error
    except (json.JSONDecodeError, UnicodeError) as error:
        if isinstance(error, json.JSONDecodeError):
            location = f":{error.lineno}:{error.colno}"
        else:
            location = ""
        raise GuardianError(
            f"جيسون (JSON) غير صالح في {config_path}{location}"
        ) from error

    if not isinstance(raw, dict):
        raise GuardianError("يجب أن يكون جذر ملف الإعداد كائن جيسون")

    allowed = {"root", "inbox", "archive", "logs", "pattern"}
    unknown = sorted(set(raw) - allowed)
    if unknown:
        raise GuardianError(f"حقول إعداد مجهولة: {', '.join(unknown)}")

    required = allowed
    missing = sorted(required - set(raw))
    if missing:
        raise GuardianError(f"حقول إعداد ناقصة: {', '.join(missing)}")

    if not all(isinstance(raw[key], str) for key in required):
        raise GuardianError("يجب أن تكون قيم الإعداد الخمس نصوصًا")

    root = Path(raw["root"]).expanduser().resolve()
    if not (root / LAB_MARKER).is_file():
        raise GuardianError(
            f"جذر المختبر لا يحمل علامة {LAB_MARKER}: {root}"
        )
    inbox = resolve_inside(root, raw["inbox"], "inbox")
    archive = resolve_inside(root, raw["archive"], "archive")
    logs = resolve_inside(root, raw["logs"], "logs")
    pattern = raw["pattern"]
    if not pattern or "/" in pattern or "\\" in pattern:
        raise GuardianError("pattern يجب أن يكون نمط اسم ملف لا مسارًا")
    paths = {"inbox": inbox, "archive": archive, "logs": logs}
    if len(set(paths.values())) != len(paths):
        raise GuardianError("يجب أن تكون inbox وarchive وlogs مسارات مختلفة")
    if any(
        inside(first, second) or inside(second, first)
        for first_name, first in paths.items()
        for second_name, second in paths.items()
        if first_name < second_name
    ):
        raise GuardianError("يجب ألا تتداخل مسارات inbox وarchive وlogs")
    return Settings(root, inbox, archive, logs, pattern)


def doctor(settings: Settings) -> list[str]:
    findings = [
        f"root={settings.root}",
        f"inbox={settings.inbox}",
        f"archive={settings.archive}",
        f"logs={settings.logs}",
        f"pattern={settings.pattern}",
        f"python={sys.version.split()[0]}",
    ]
    if not settings.root.is_dir():
        raise GuardianError(f"جذر المختبر ليس مجلدًا: {settings.root}")
    if not settings.inbox.is_dir():
        raise GuardianError(f"صندوق الوارد ليس مجلدًا: {settings.inbox}")
    return findings


def build_plan(settings: Settings) -> list[Action]:
    if not settings.inbox.is_dir():
        raise GuardianError(f"صندوق الوارد ليس مجلدًا: {settings.inbox}")

    actions: list[Action] = []
    for source in sorted(settings.inbox.iterdir(), key=lambda item: item.name):
        if not source.is_file() or source.is_symlink():
            actions.append(Action("skip", source, reason="not-a-regular-file"))
            continue
        if not fnmatch.fnmatchcase(source.name, settings.pattern):
            actions.append(Action("skip", source, reason="pattern-mismatch"))
            continue
        destination = settings.archive / source.name
        if destination.exists():
            actions.append(Action("conflict", source, destination, "destination-exists"))
            continue
        actions.append(Action("move", source, destination))
    return actions


def print_actions(actions: Iterable[Action], root: Path, as_json: bool) -> None:
    for action in actions:
        data = action.as_dict(root)
        if as_json:
            print(json.dumps(data, ensure_ascii=False, sort_keys=True))
            continue
        destination = data.get("destination", "-")
        reason = data.get("reason", "-")
        print(
            f"{data['action'].upper():8} "
            f"{data['source']} -> {destination} reason={reason}"
        )


def append_json_line(path: Path, record: dict[str, Any]) -> None:
    with path.open("a", encoding="utf-8") as stream:
        stream.write(json.dumps(record, ensure_ascii=False, sort_keys=True))
        stream.write("\n")
        stream.flush()
        os.fsync(stream.fileno())


class RunLock:
    def __init__(self, path: Path) -> None:
        self.path = path
        self.acquired = False

    def __enter__(self) -> "RunLock":
        try:
            self.path.mkdir()
        except FileExistsError as error:
            raise LockedError(f"يوجد تشغيل آخر أو قفل قديم: {self.path}") from error
        self.acquired = True
        try:
            (self.path / "owner.json").write_text(
                json.dumps({"pid": os.getpid(), "started_at": utc_now()}),
                encoding="utf-8",
            )
        except Exception:
            shutil.rmtree(self.path)
            self.acquired = False
            raise
        return self

    def __exit__(self, _type: Any, _value: Any, _traceback: Any) -> None:
        if self.acquired:
            shutil.rmtree(self.path)


def run(settings: Settings) -> tuple[Path, int]:
    actions = build_plan(settings)
    conflicts = [action for action in actions if action.action == "conflict"]
    if conflicts:
        raise ConflictError(
            f"أُلغيت الدفعة لوجود {len(conflicts)} تعارض؛ شغّل plan للتفاصيل"
        )

    settings.archive.mkdir(parents=True, exist_ok=True)
    settings.logs.mkdir(parents=True, exist_ok=True)
    run_id = uuid.uuid4().hex[:12]
    journal = settings.logs / f"journal-{run_id}.jsonl"
    lock_path = settings.root / ".guardian.lock"

    moved = 0
    with RunLock(lock_path):
        append_json_line(
            journal,
            {"event": "run-start", "run_id": run_id, "timestamp": utc_now()},
        )
        try:
            for action in actions:
                if action.action != "move" or action.destination is None:
                    continue
                # أعد الفحص مباشرة قبل النقل؛ فقد يظهر ملف بعد بناء الخطة.
                if action.destination.exists():
                    raise ConflictError(
                        f"ظهر تعارض بعد بناء الخطة: {action.destination}"
                    )
                append_json_line(
                    journal,
                    {
                        "event": "move-start",
                        "run_id": run_id,
                        "timestamp": utc_now(),
                        **action.as_dict(settings.root),
                    },
                )
                shutil.move(str(action.source), str(action.destination))
                moved += 1
                append_json_line(
                    journal,
                    {
                        "event": "move-done",
                        "run_id": run_id,
                        "timestamp": utc_now(),
                        **action.as_dict(settings.root),
                    },
                )
        except Exception:
            append_json_line(
                journal,
                {
                    "event": "run-failed",
                    "run_id": run_id,
                    "timestamp": utc_now(),
                    "moved": moved,
                },
            )
            if moved:
                raise PartialRunError(
                    f"فشل التشغيل بعد نقل {moved} ملف؛ راجع {journal}"
                )
            raise
        append_json_line(
            journal,
            {
                "event": "run-done",
                "run_id": run_id,
                "timestamp": utc_now(),
                "moved": moved,
            },
        )
    return journal, moved


def read_journal(journal: Path) -> list[dict[str, Any]]:
    try:
        records = [
            json.loads(line)
            for line in journal.read_text(encoding="utf-8").splitlines()
            if line.strip()
        ]
    except (FileNotFoundError, json.JSONDecodeError) as error:
        raise GuardianError(f"تعذر قراءة دفتر التشغيل: {journal}") from error
    if not all(isinstance(record, dict) for record in records):
        raise GuardianError("يجب أن يكون كل سطر في الدفتر كائن جيسون")
    return records


def restore(settings: Settings, journal: Path) -> int:
    journal = journal.expanduser().resolve()
    if not inside(settings.logs, journal):
        raise GuardianError("يجب أن يكون دفتر التشغيل داخل مجلد logs")

    records = read_journal(journal)
    completed = [record for record in records if record.get("event") == "move-done"]
    if not completed:
        raise GuardianError("لا يحتوي الدفتر عمليات نقل مكتملة")

    run_ids = {record.get("run_id") for record in completed}
    if (
        len(run_ids) != 1
        or not all(isinstance(run_id, str) and run_id for run_id in run_ids)
    ):
        raise GuardianError("معرف التشغيل مفقود أو غير متسق في الدفتر")
    run_id = next(iter(run_ids))
    if journal.name != f"journal-{run_id}.jsonl":
        raise GuardianError("اسم الدفتر لا يطابق معرف التشغيل")
    starts = [
        record
        for record in records
        if record.get("event") == "run-start" and record.get("run_id") == run_id
    ]
    if len(starts) != 1:
        raise GuardianError("بداية التشغيل مفقودة أو مكررة في الدفتر")
    started_moves = {
        (record.get("source"), record.get("destination"))
        for record in records
        if (
            record.get("event") == "move-start"
            and record.get("run_id") == run_id
            and record.get("action") == "move"
            and isinstance(record.get("source"), str)
            and isinstance(record.get("destination"), str)
        )
    }

    pairs: list[tuple[Path, Path]] = []
    seen_sources: set[Path] = set()
    seen_destinations: set[Path] = set()
    for record in reversed(completed):
        if (
            record.get("run_id") != run_id
            or record.get("action") != "move"
            or not isinstance(record.get("source"), str)
            or not isinstance(record.get("destination"), str)
        ):
            raise GuardianError("سجل نقل غير صالح في الدفتر")
        if (record["source"], record["destination"]) not in started_moves:
            raise GuardianError("سجل نقل مكتمل بلا سجل بدء مطابق")
        source = resolve_inside(settings.root, record["source"], "source")
        destination = resolve_inside(
            settings.root, record["destination"], "destination"
        )
        if not inside(settings.inbox, source):
            raise GuardianError("مصدر الاستعادة خارج inbox")
        if not inside(settings.archive, destination):
            raise GuardianError("وجهة الاستعادة خارج archive")
        if source in seen_sources or destination in seen_destinations:
            raise GuardianError("مسارات مكررة في دفتر الاستعادة")
        seen_sources.add(source)
        seen_destinations.add(destination)
        if source.exists():
            raise GuardianError(f"تعارض الاستعادة، المصدر موجود: {source}")
        if not destination.is_file():
            raise GuardianError(f"ملف الاستعادة غير موجود: {destination}")
        pairs.append((source, destination))

    restored = 0
    lock_path = settings.root / ".guardian.lock"
    with RunLock(lock_path):
        try:
            for source, destination in pairs:
                # كرر فحص التمهيد قبل كل خطوة لتقليل خطر تغيير طارئ.
                if source.exists():
                    raise ConflictError(
                        f"تعارض الاستعادة، المصدر ظهر لاحقًا: {source}"
                    )
                if not destination.is_file():
                    raise GuardianError(
                        f"ملف الاستعادة اختفى بعد الفحص: {destination}"
                    )
                source.parent.mkdir(parents=True, exist_ok=True)
                shutil.move(str(destination), str(source))
                restored += 1
        except Exception:
            if restored:
                raise PartialRunError(
                    f"توقفت الاستعادة بعد إعادة {restored} ملف"
                )
            raise
    return restored


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser(description="حارس صندوق وارد تجريبي")
    result.add_argument("--config", required=True, type=Path)
    subcommands = result.add_subparsers(dest="command", required=True)
    subcommands.add_parser("doctor")
    plan_parser = subcommands.add_parser("plan")
    plan_parser.add_argument("--json", action="store_true")
    subcommands.add_parser("run")
    restore_parser = subcommands.add_parser("restore")
    restore_parser.add_argument("--journal", required=True, type=Path)
    return result


def main(argv: list[str] | None = None) -> int:
    args = parser().parse_args(argv)
    try:
        settings = load_settings(args.config)
        if args.command == "doctor":
            for finding in doctor(settings):
                print(finding)
            return 0
        if args.command == "plan":
            print_actions(build_plan(settings), settings.root, args.json)
            return 0
        if args.command == "run":
            journal, moved = run(settings)
            print(f"moved={moved} journal={journal}")
            return 0
        if args.command == "restore":
            restored = restore(settings, args.journal)
            print(f"restored={restored}")
            return 0
    except ConflictError as error:
        print(f"guardian: {error}", file=sys.stderr)
        return EXIT_CONFLICT
    except LockedError as error:
        print(f"guardian: {error}", file=sys.stderr)
        return EXIT_LOCKED
    except PartialRunError as error:
        print(f"guardian: فشل جزئي: {error}", file=sys.stderr)
        return EXIT_PARTIAL
    except GuardianError as error:
        print(f"guardian: {error}", file=sys.stderr)
        return EXIT_CONFIG
    except (OSError, shutil.Error) as error:
        print(f"guardian: فشل جزئي: {error}", file=sys.stderr)
        return EXIT_PARTIAL
    return EXIT_USAGE


if __name__ == "__main__":
    raise SystemExit(main())
