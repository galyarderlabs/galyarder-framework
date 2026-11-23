#!/usr/bin/env python3
"""Single-source the GLOBAL PROTOCOLS header.

Canonical source: docs/GLOBAL-PROTOCOLS.md (the majority header block,
verbatim, ending with the '---' separator).

Every agent, skill and command file carries the protocols inline (host
tools read SKILL.md directly and need them there), so this script does not
replace the block with a pointer. It rewrites the inline block from the
single canonical file. Run it after editing the canonical file:

    python3 scripts/sync-global-protocols.py

Files missing the block get it inserted before their first '# ' title
(after frontmatter when present).
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CANONICAL = (ROOT / "docs" / "GLOBAL-PROTOCOLS.md").read_text()

HEADER_RE = re.compile(
    r"## THE Agentic Company Framework GLOBAL PROTOCOLS \(MANDATORY\).*?\n---\n",
    re.S,
)
FRONTMATTER_RE = re.compile(r"\A---\n.*?\n---\n", re.S)

targets = (
    sorted((ROOT / "agents").glob("*.md"))
    + sorted((ROOT / "skills").glob("*/SKILL.md"))
    + sorted((ROOT / "commands").glob("*.md"))
)

changed = []
for path in targets:
    text = path.read_text()
    if HEADER_RE.search(text):
        new = HEADER_RE.sub(lambda _: CANONICAL, text, count=1)
    else:
        # Insert before the first top-level title, after frontmatter.
        m = FRONTMATTER_RE.match(text)
        if m:
            new = text[: m.end()] + CANONICAL + text[m.end() :]
        else:
            new = CANONICAL + text
    if new != text:
        path.write_text(new)
        changed.append(str(path.relative_to(ROOT)))

print(f"synced {len(targets)} files, changed {len(changed)}")
for p in changed:
    print(" ", p)
sys.exit(0)
