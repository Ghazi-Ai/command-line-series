from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

import guardian


class GuardianTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temporary = tempfile.TemporaryDirectory()
        self.root = Path(self.temporary.name).resolve()
        (self.root / guardian.LAB_MARKER).touch()
        self.inbox = self.root / "inbox"
        self.archive = self.root / "archive"
        self.logs = self.root / "logs"
        self.inbox.mkdir()
        self.config = self.root / "config.json"
        self.config.write_text(
            json.dumps(
                {
                    "root": str(self.root),
                    "inbox": "inbox",
                    "archive": "archive",
                    "logs": "logs",
                    "pattern": "report-*.txt",
                }
            ),
            encoding="utf-8",
        )
        self.settings = guardian.load_settings(self.config)

    def tearDown(self) -> None:
        self.temporary.cleanup()

    def write(self, name: str, content: str = "data") -> Path:
        path = self.inbox / name
        path.write_text(content, encoding="utf-8")
        return path

    def test_plan_moves_matches_and_skips_others(self) -> None:
        self.write("report-1.txt")
        self.write("notes.txt")
        actions = guardian.build_plan(self.settings)
        self.assertEqual(["move", "skip"], sorted(action.action for action in actions))

    def test_run_is_safe_to_repeat(self) -> None:
        self.write("report-1.txt", "original")
        journal, moved = guardian.run(self.settings)
        self.assertEqual(1, moved)
        self.assertTrue(journal.is_file())
        self.assertFalse((self.inbox / "report-1.txt").exists())
        self.assertEqual("original", (self.archive / "report-1.txt").read_text())
        _second_journal, second_moved = guardian.run(self.settings)
        self.assertEqual(0, second_moved)

    def test_conflict_aborts_before_move(self) -> None:
        source = self.write("report-1.txt", "new")
        self.archive.mkdir()
        destination = self.archive / source.name
        destination.write_text("old", encoding="utf-8")
        with self.assertRaisesRegex(guardian.ConflictError, "تعارض"):
            guardian.run(self.settings)
        self.assertEqual("new", source.read_text(encoding="utf-8"))
        self.assertEqual("old", destination.read_text(encoding="utf-8"))

    def test_late_conflict_does_not_overwrite_destination(self) -> None:
        source = self.write("report-1.txt", "new")
        self.archive.mkdir()
        destination = self.archive / source.name
        destination.write_text("old", encoding="utf-8")
        planned = [guardian.Action("move", source, destination)]
        with patch.object(guardian, "build_plan", return_value=planned):
            with self.assertRaisesRegex(guardian.ConflictError, "تعارض"):
                guardian.run(self.settings)
        self.assertEqual("new", source.read_text(encoding="utf-8"))
        self.assertEqual("old", destination.read_text(encoding="utf-8"))

    def test_late_conflict_after_move_is_partial_failure(self) -> None:
        first = self.write("report-1.txt", "first")
        second = self.write("report-2.txt", "second")
        first_destination = self.archive / first.name
        second_destination = self.archive / second.name
        planned = [
            guardian.Action("move", first, first_destination),
            guardian.Action("move", second, second_destination),
        ]
        real_move = guardian.shutil.move

        def move_then_create_conflict(source: str, destination: str) -> str:
            result = real_move(source, destination)
            if Path(destination) == first_destination:
                second_destination.write_text("outside", encoding="utf-8")
            return result

        with patch.object(guardian, "build_plan", return_value=planned):
            with patch.object(
                guardian.shutil, "move", side_effect=move_then_create_conflict
            ):
                with self.assertRaisesRegex(guardian.PartialRunError, "بعد نقل 1"):
                    guardian.run(self.settings)
        self.assertEqual("first", first_destination.read_text(encoding="utf-8"))
        self.assertEqual("second", second.read_text(encoding="utf-8"))
        self.assertEqual("outside", second_destination.read_text(encoding="utf-8"))

    def test_restore_reverses_completed_moves(self) -> None:
        source = self.write("report-1.txt", "original")
        journal, _moved = guardian.run(self.settings)
        restored = guardian.restore(self.settings, journal)
        self.assertEqual(1, restored)
        self.assertEqual("original", source.read_text(encoding="utf-8"))

    def test_path_outside_root_is_rejected(self) -> None:
        raw = json.loads(self.config.read_text(encoding="utf-8"))
        raw["archive"] = "../outside"
        self.config.write_text(json.dumps(raw), encoding="utf-8")
        with self.assertRaisesRegex(guardian.GuardianError, "يخرج"):
            guardian.load_settings(self.config)

    def test_non_object_config_is_rejected(self) -> None:
        self.config.write_text("null", encoding="utf-8")
        with self.assertRaisesRegex(guardian.GuardianError, "كائن جيسون"):
            guardian.load_settings(self.config)

    def test_missing_lab_marker_is_rejected(self) -> None:
        (self.root / guardian.LAB_MARKER).unlink()
        with self.assertRaisesRegex(guardian.GuardianError, "علامة"):
            guardian.load_settings(self.config)

    def test_overlapping_directories_are_rejected(self) -> None:
        raw = json.loads(self.config.read_text(encoding="utf-8"))
        raw["archive"] = "inbox/archive"
        self.config.write_text(json.dumps(raw), encoding="utf-8")
        with self.assertRaisesRegex(guardian.GuardianError, "تتداخل"):
            guardian.load_settings(self.config)

    def test_restore_respects_run_lock(self) -> None:
        self.write("report-1.txt")
        journal, _moved = guardian.run(self.settings)
        lock = self.root / ".guardian.lock"
        lock.mkdir()
        with self.assertRaises(guardian.LockedError):
            guardian.restore(self.settings, journal)

    def test_restore_rejects_paths_outside_inbox_and_archive(self) -> None:
        self.logs.mkdir()
        other_source = self.root / "other-source.txt"
        other_destination = self.root / "other-destination.txt"
        other_destination.write_text("data", encoding="utf-8")
        journal = self.logs / "journal-forged.jsonl"
        journal.write_text(
            "\n".join(
                json.dumps(record)
                for record in (
                    {"event": "run-start", "run_id": "forged"},
                    {
                        "event": "move-start",
                        "run_id": "forged",
                        "action": "move",
                        "source": other_source.name,
                        "destination": other_destination.name,
                    },
                    {
                        "event": "move-done",
                        "run_id": "forged",
                        "action": "move",
                        "source": other_source.name,
                        "destination": other_destination.name,
                    },
                )
            )
            + "\n",
            encoding="utf-8",
        )
        with self.assertRaisesRegex(guardian.GuardianError, "خارج inbox"):
            guardian.restore(self.settings, journal)

    def test_non_object_journal_record_is_rejected(self) -> None:
        self.logs.mkdir()
        journal = self.logs / "journal-invalid.jsonl"
        journal.write_text("[]\n", encoding="utf-8")
        with self.assertRaisesRegex(guardian.GuardianError, "كائن جيسون"):
            guardian.restore(self.settings, journal)


if __name__ == "__main__":
    unittest.main()
