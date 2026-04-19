#!/usr/bin/env python3
from __future__ import annotations

import argparse
import os
import shutil
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent
ROOT_LINKS = {
    "agents": REPO_ROOT / "Gemini" / "agents",
    "skills": REPO_ROOT / "Gemini" / "skills",
    "commands": REPO_ROOT / "Gemini" / "commands",
    "personas": REPO_ROOT / "Bundle" / "personas",
}


def reset_path(path: Path) -> None:
    if path.is_symlink() or path.is_file():
        path.unlink()
    elif path.is_dir():
        shutil.rmtree(path)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-root", default=str(REPO_ROOT))
    args = parser.parse_args()

    repo_root = Path(args.repo_root).resolve()

    for name, source in ROOT_LINKS.items():
        dest = repo_root / name
        if dest.exists() or dest.is_symlink():
            reset_path(dest)
        dest.symlink_to(os.path.relpath(source, start=repo_root))

    print(f"Root extension surface built at {repo_root}")


if __name__ == "__main__":
    main()
