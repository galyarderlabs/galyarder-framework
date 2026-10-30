#!/usr/bin/env python3
"""Fail when a tracked path cannot be checked out on Windows.

Issues #198 and #203: colons in filenames break `git checkout` on Windows,
and a case-only duplicate cannot exist on NTFS either. This guard runs in CI
and locally (`python3 scripts/check-windows-paths.py`) so the class cannot return.
"""
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
# Control characters count too: a trailing carriage return produces the same
# "unable to create file ... Invalid argument" failure as a colon.
INVALID_CHARS = set('<>:"\\|?*') | {chr(code) for code in range(0x20)}
RESERVED_NAMES = {"CON", "PRN", "AUX", "NUL"} | {f"COM{i}" for i in range(1, 10)} | {f"LPT{i}" for i in range(1, 10)}
MAX_PATH_LENGTH = 240


def tracked_paths():
    result = subprocess.run(
        ["git", "ls-files", "-z"],
        cwd=REPO_ROOT,
        capture_output=True,
        check=True,
    )
    return [p for p in result.stdout.decode("utf-8", "replace").split("\0") if p]


def find_problems(paths):
    problems = []
    seen = {}
    for path in paths:
        for segment in path.split("/"):
            illegal = sorted(set(segment) & INVALID_CHARS)
            if illegal:
                problems.append(f"illegal character(s) in segment {segment!r}: {path!r}")
                break
            if segment != segment.rstrip(" ."):
                problems.append(f"trailing dot or space: {path}")
                break
            if segment.split(".")[0].upper() in RESERVED_NAMES:
                problems.append(f"reserved device name {segment!r}: {path}")
                break
        if len(path) > MAX_PATH_LENGTH:
            problems.append(f"path longer than {MAX_PATH_LENGTH} characters: {path}")
        key = path.casefold()
        if key in seen:
            problems.append(f"case-insensitive duplicate of {seen[key]}: {path}")
        else:
            seen[key] = path
    return problems


def main() -> int:
    paths = tracked_paths()
    problems = find_problems(paths)
    if not problems:
        print(f"OK: {len(paths)} tracked paths are Windows-safe.")
        return 0
    print(f"FAIL: {len(problems)} path problem(s) found:\n", file=sys.stderr)
    for problem in problems:
        print(f"  {problem}", file=sys.stderr)
    print("\nRename the paths so `git checkout` works on Windows (see issue #203).", file=sys.stderr)
    return 1


if __name__ == "__main__":
    sys.exit(main())
