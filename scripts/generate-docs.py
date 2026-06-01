#!/usr/bin/env python3
import os
import re
import shutil
import json
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
DOCS_DIR = REPO_ROOT / "docs"

# Global icons for auto-discovered domains (MkDocs Material syntax: :material-icon-name:)
ICONS = {
    "executive": "material-account-tie",
    "engineering": "material-hammer-wrench",
    "growth": "material-trending-up",
    "security": "material-shield-lock",
    "product": "material-package-variant-closed",
    "infrastructure": "material-server",
    "finance": "material-scale-balance",
    "knowledge": "material-brain",
    "default": "material-folder-zip"
}


PUBLIC_DOC_REPLACEMENTS = [
    (r"THE 1-MAN ARMY GLOBAL PROTOCOLS \(MANDATORY\)", "AGENTIC COMPANY OPERATING PROTOCOLS"),
    (r"1-Man Army Global Protocols", "agentic company operating protocols"),
    (r"1-Man Army Command Protocol", "agentic-company command protocol"),
    (r"1-Man Army", "agentic company"),
    (r"Humans 3\.0", "human-directed execution"),
    (r"zero[- ]slop", "verified-output"),
    (r"Digital HQ", "project operating workspace"),
    (r"Global Karpathy protocol", "technical integrity protocol"),
    (r"Karpathy Principles", "technical integrity principles"),
    (r"\bKarpathy\b", "technical integrity"),
    (r"high-integrity", "evidence-backed"),
    (r"High-integrity", "Evidence-backed"),
    (r"\bAGI\b", "Agentic Company Framework"),
    (r"Autonomous Goal Integration", "Open-source Agentic Company Framework"),
    (r"\bswarms\b", "workflows"),
    (r"\bSwarms\b", "Workflows"),
    (r"\bswarm\b", "workflow"),
    (r"\bEmpire\b", "Company"),
    (r"\bempire\b", "company"),
    (r"\bsentient\b", "persistent"),
    (r"\bSentient\b", "Persistent"),
]


def sanitize_public_copy(text):
    """Rewrite older runtime/source language into public docs positioning.

    The source packages may retain historical/internal names, but MkDocs output should
    present Framework as a human-directed Agentic Company Framework / Intelligence Layer.
    """
    for pattern, replacement in PUBLIC_DOC_REPLACEMENTS:
        text = re.sub(pattern, replacement, text)
    # Keep the internal term, but never leave the public docs sounding like an
    # artificial-general-intelligence claim.
    text = text.replace(
        "Open-source Agentic Company Framework means Open-source Agentic Company Framework",
        "Open-source Agentic Company Framework means turning goals into governed execution",
    )
    return text

def prettify(name):
    # Fix double names and kebab-case
    name = name.replace("-", " ").replace("_", " ").title()
    if name.startswith("Galyarder"):
        name = name.replace("Galyarder ", "")
    return name.strip()

class Asset:
    def __init__(self, file_path, category):
        self.src_path = Path(file_path)
        self.category = category
        self.name = self.src_path.stem if self.src_path.name != "SKILL.md" else self.src_path.parent.name
        self.title = ""
        self.description = ""
        self.content = ""
        self.is_skill = (self.src_path.name == "SKILL.md")
        self.parse()

    def parse(self):
        with open(self.src_path, "r", encoding="utf-8") as f:
            raw = sanitize_public_copy(f.read())

        # 1. Extract Frontmatter
        fm_match = re.search(r"^---\s*\n(.*?)\n---", raw, re.DOTALL)
        if fm_match:
            fm = fm_match.group(1)
            name_m = re.search(r"^name:\s*(.*)", fm, re.MULTILINE)
            desc_m = re.search(r"^description:\s*(.*)", fm, re.MULTILINE)
            if name_m: self.title = name_m.group(1).strip().strip('"').strip("'")
            if desc_m: self.description = desc_m.group(1).strip().strip('"').strip("'")
            self.content = raw[fm_match.end():].strip()
        else:
            self.content = raw.strip()

        # 2. Extract H1 if title missing
        if not self.title or self.title == "|":
            h1_match = re.search(r"^# (.*)", self.content, re.MULTILINE)
            if h1_match:
                self.title = h1_match.group(1).strip()
                # Remove the H1 from content to avoid double headers
                self.content = re.sub(r"^# .*", "", self.content, count=1, flags=re.MULTILINE).strip()

        if not self.title or self.title == "|":
            self.title = prettify(self.name)

        # 3. Clean Garbage Descriptions
        if self.description == "|" or not self.description:
            clean_content = re.sub(r"##.*", "", self.content, flags=re.DOTALL).strip()
            # Remove protocol headers from description preview
            clean_content = re.sub(r"## (THE 1-MAN ARMY GLOBAL PROTOCOLS|AGENTIC COMPANY OPERATING PROTOCOLS).*?\n---", "", clean_content, flags=re.DOTALL).strip()
            lines = [l for l in clean_content.split("\n") if l.strip() and not l.startswith("#") and not l.startswith(">")]
            if lines:
                self.description = lines[0][:200].strip().rstrip(".") + "..."
            else:
                self.description = f"Specialized {self.category} unit for Galyarder Framework orchestration."

        # Ensure title and desc are clean
        self.title = self.title.replace("Galyarder ", "").strip()
        self.description = self.description.replace('"', "'").strip()

    def generate_page(self, icon, label):
        mk_icon = f":{icon}:"
        return f"""---
title: "{self.title} | Galyarder Framework"
description: "{self.description}"
---

# {mk_icon} {self.title}

<p class="domain-label">{label} {self.category.title()}</p>

---

{self.content}
"""

def generate():
    print("🚀 Executing Professional Portal Synchronization...")

    # Clean output directories
    for d in ["agents", "skills", "commands", "design"]:
        target = DOCS_DIR / d
        if target.exists(): shutil.rmtree(target)
        target.mkdir(parents=True, exist_ok=True)

    # 0. Sync selected core files from root and fix internal links.
    print("[*] Syncing selected core markdown files...")
    sync_core_files = {"AGENTS.md", "CHANGELOG.md", "RELEASE-NOTES.md", "WORKFLOW.md"}
    for name in sorted(sync_core_files):
        f = REPO_ROOT / name
        if not f.exists():
            continue
        with open(f, 'r', encoding='utf-8') as src:
            content = sanitize_public_copy(src.read())

        # FIX: Remove "docs/" from relative links because these files are
        # copied into docs/. Keep the captured path, not a control character.
        content = re.sub(r'\(docs/([^)]+\.md)\)', r'(\1)', content)

        dest = DOCS_DIR / f.name
        with open(dest, 'w', encoding='utf-8') as out:
            out.write(content)
        print(f"  - Synchronized and repaired: {f.name}")

    # Discovery: v1.9.9 uses canonical root-level agents/, skills/, and commands/.
    # Older plugin-silo discovery is retained as fallback for nested marketplace bundles.
    silos = {
        "framework": {
            "icon": ICONS["default"],
            "label": "Framework",
            "path": REPO_ROOT,
        }
    }
    for item in REPO_ROOT.iterdir():
        if item.is_dir() and (item / ".claude-plugin" / "plugin.json").exists():
            with open(item / ".claude-plugin" / "plugin.json", "r") as f:
                manifest = json.load(f)
                cat = manifest.get("category", "default")
                silos[item.name] = {
                    "icon": ICONS.get(cat, ICONS["default"]),
                    "label": item.name,
                    "path": item,
                }

    inventory = {"agents": {}, "skills": {}, "commands": {}}

    for silo_name, info in silos.items():
        silo_path = info["path"]

        # 1. Agents
        agent_src = silo_path / "agents"
        if agent_src.exists():
            for f in sorted(agent_src.glob("*.md")):
                if f.name == "README.md":
                    continue
                a = Asset(f, "agent")
                out_path = DOCS_DIR / "agents" / f.name
                with open(out_path, "w", encoding="utf-8") as out:
                    out.write(a.generate_page(info["icon"], info["label"]))
                inventory["agents"].setdefault(silo_name, []).append((a.title, f"{f.name}", a.description))

        # 2. Commands
        cmd_src = silo_path / "commands"
        if cmd_src.exists():
            for f in sorted(cmd_src.glob("*.md")):
                c = Asset(f, "command")
                out_path = DOCS_DIR / "commands" / f.name
                with open(out_path, "w", encoding="utf-8") as out:
                    out.write(c.generate_page(info["icon"], info["label"]))
                inventory["commands"].setdefault(silo_name, []).append((f"/{c.name}", f"{f.name}", c.description))

        # 3. Skills
        skill_src = silo_path / "skills"
        if skill_src.exists():
            for skill_folder in sorted(skill_src.iterdir()):
                if not skill_folder.is_dir():
                    continue
                skill_md = skill_folder / "SKILL.md"
                if not skill_md.exists():
                    continue
                s = Asset(skill_md, "skill")
                dest_folder = DOCS_DIR / "skills" / skill_folder.name
                dest_folder.mkdir(exist_ok=True)
                with open(dest_folder / "index.md", "w", encoding="utf-8") as out:
                    out.write(s.generate_page(info["icon"], info["label"]))
                for sub in ["references", "assets", "templates"]:
                    if (skill_folder / sub).exists():
                        shutil.copytree(skill_folder / sub, dest_folder / sub, dirs_exist_ok=True)
                        for copied in (dest_folder / sub).rglob("*.md"):
                            copied.write_text(sanitize_public_copy(copied.read_text(encoding="utf-8", errors="replace")), encoding="utf-8")
                inventory["skills"].setdefault(silo_name, []).append((s.title, f"{skill_folder.name}/index.md", s.description))

    # 4. Generate High-Density Grid Landing Pages
    for category in ["agents", "skills", "commands"]:
        idx_content = f"# Galyarder Framework: {category.title()}\n\n"
        idx_content += "Discover the agentic company workforce, commands, and operating protocols designed for human-directed execution.\n\n"

        for silo_name in sorted(inventory[category].keys()):
            info = silos[silo_name]
            mk_icon = f":{info['icon'].replace('/', '-')}:"
            idx_content += f"## {mk_icon} {silo_name} Department\n\n"
            idx_content += '<div class="grid cards" markdown>\n\n'
            for title, link, desc in sorted(inventory[category][silo_name]):
                idx_content += f"-   **[{title}]({link})**\n\n    ---\n\n    {desc}\n\n"
            idx_content += "</div>\n\n"

        with open(DOCS_DIR / category / "index.md", "w", encoding="utf-8") as f:
            f.write(idx_content)

    # Special Case: Design System Grid
    design_idx = "# Design System Specifications\n\nProduction-grade interface specifications for consistent agent-generated product surfaces.\n\n"
    design_idx += '<div class="grid cards" markdown>\n\n'
    design_src = REPO_ROOT / "skills"
    if design_src.exists():
        for skill_dir in sorted(design_src.glob("design-md-*")):
            skill_file = skill_dir / "SKILL.md"
            if not skill_file.exists():
                continue
            output_name = f"{skill_dir.name}.md"
            shutil.copy(skill_file, DOCS_DIR / "design" / output_name)
            design_page = DOCS_DIR / "design" / output_name
            design_page.write_text(sanitize_public_copy(design_page.read_text(encoding="utf-8", errors="replace")), encoding="utf-8")
            title = skill_dir.name.replace("design-md-", "").replace("-", " ").replace(".", " ").title()
            design_idx += f"-   **[{title}]({output_name})**\n\n    ---\n\n    Evidence-backed design specification.\n\n"
    design_idx += "</div>"
    with open(DOCS_DIR / "design/index.md", "w", encoding="utf-8") as f: f.write(design_idx)

    print("Success: Professional Portal Synchronization complete.")

if __name__ == "__main__":
    generate()
