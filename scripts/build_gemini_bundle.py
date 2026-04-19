#!/usr/bin/env python3
from __future__ import annotations

import argparse
import os
import shutil
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent
BUNDLE_ROOT = REPO_ROOT / "Gemini"
ROOT_RUNTIME_DIRS = ("agents", "skills", "commands")


def reset_path(path: Path) -> None:
    if path.is_symlink() or path.is_file():
        path.unlink()
    elif path.is_dir():
        shutil.rmtree(path)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--bundle-root", default=str(BUNDLE_ROOT))
    args = parser.parse_args()

    bundle_root = Path(args.bundle_root).resolve()
    bundle_root.mkdir(parents=True, exist_ok=True)
    for name in ROOT_RUNTIME_DIRS:
        source = REPO_ROOT / name
        if not source.exists():
            raise SystemExit(f"Root runtime directory not found: {source}")
        dest = bundle_root / name
        if dest.exists() or dest.is_symlink():
            reset_path(dest)
        dest.symlink_to(os.path.relpath(source, start=bundle_root))

    print(f"Gemini bundle built at {bundle_root}")


if __name__ == "__main__":
    main()
