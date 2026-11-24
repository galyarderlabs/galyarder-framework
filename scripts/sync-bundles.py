#!/usr/bin/env python3
"""Regenerate the consolidated skill bundles from the canonical skills.

There is no upstream bundle generator in this repo; the bundles were
built by concatenating the substantive skills. This script reproduces
that build so the bundles stay in sync with skills/:

  * member list and order come from the existing bundle (its
    '## SKILL: <name>' headings), so membership never changes here;
  * each member's content is the current SKILL.md with its frontmatter
    stripped (the bundle keeps the '# Title' and everything after);
  * header (frontmatter, bundle title, member count) and footer
    (copyright line) are preserved verbatim from the existing bundle.

Run after editing skills/ or after sync-global-protocols.py:

    python3 scripts/sync-bundles.py

Verify with `git diff` - the only changes should be the ones you made
to the skills themselves.
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SKILLS = ROOT / "skills"

FRONTMATTER_RE = re.compile(r"\A---\n.*?\n---\n", re.S)
SECTION_RE = re.compile(r"^## SKILL: (.+)$", re.M)


def skill_content(name: str) -> str:
    path = SKILLS / name / "SKILL.md"
    text = path.read_text()
    body = FRONTMATTER_RE.sub("", text, count=1)
    return body.rstrip("\n") + "\n"


def regen(bundle_path: Path) -> bool:
    text = bundle_path.read_text()
    members = SECTION_RE.findall(text)
    if not members:
        print(f"skip {bundle_path}: no SKILL sections")
        return False
    first = text.index("## SKILL: ")
    header = text[:first]
    # Footer is the copyright line after the final '---' separator.
    last_sep = text.rfind("\n---\n")
    footer = text[last_sep + len("\n---\n"):]
    parts = [header]
    for name in members:
        parts.append(f"## SKILL: {name}\n")
        parts.append(skill_content(name))
        parts.append("\n---\n")
    parts.append(footer)
    new = "".join(parts)
    if new != text:
        bundle_path.write_text(new)
        return True
    return False


changed = []
for bundle in sorted(SKILLS.glob("*/SKILL.md")):
    # A bundle is a skill whose frontmatter says it is a bundle.
    head = (bundle.read_text().split("---", 2)[1] if bundle.read_text().startswith("---") else "")
    if "bundle" in head.lower() or bundle.parent.name in (
        "forge", "engineering", "executive", "growth", "security",
        "knowledge", "product", "infrastructure", "finance", "legal", "creative",
    ):
        if regen(bundle):
            changed.append(str(bundle.relative_to(ROOT)))

print(f"regenerated bundles, changed {len(changed)}")
for p in changed:
    print(" ", p)
sys.exit(0)
