#!/usr/bin/env python3
import os
import re
import shutil
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
DOCS_DIR = REPO_ROOT / "docs"

DEPARTMENTS = ["Executive", "Engineering", "Growth", "Security", "Product", "Infrastructure", "Legal-Finance", "Knowledge"]

def prettify(name):
    return name.replace("-", " ").title()

def extract_metadata(file_path):
    name, desc = "", ""
    try:
        with open(file_path, "r", encoding="utf-8") as f:
            content = f.read()
            # Try frontmatter
            fm_match = re.search(r"^---\s*\n(.*?)\n---", content, re.DOTALL)
            if fm_match:
                fm = fm_match.group(1)
                name_m = re.search(r"^name:\s*(.*)", fm, re.MULTILINE)
                desc_m = re.search(r"^description:\s*(.*)", fm, re.MULTILINE)
                if name_m: name = name_m.group(1).strip().strip('"').strip("'")
                if desc_m: desc = desc_m.group(1).strip().strip('"').strip("'")
            
            # Try H1 if name missing
            if not name:
                h1_match = re.search(r"^# (.*)", content, re.MULTILINE)
                if h1_match: name = h1_match.group(1).strip()
    except:
        pass
    return name, desc

def generate():
    print("Initializing Galyarder Documentation Portal Generation...")
    
    # 1. Clean and Recreate doc dirs
    for d in ["agents", "skills", "commands", "design"]:
        target = DOCS_DIR / d
        if target.exists(): shutil.rmtree(target)
        target.mkdir(parents=True, exist_ok=True)

    counts = {"agents": 0, "skills": 0, "commands": 0}
    indices = {"agents": [], "skills": [], "commands": [], "design": []}

    # 2. Process Departments
    for dept in DEPARTMENTS:
        dept_path = REPO_ROOT / dept
        if not dept_path.exists(): continue
        
        print(f"[*] Indexing department: {dept}")

        # Agents
        agent_src = dept_path / "agents"
        if agent_src.exists():
            for f in agent_src.glob("*.md"):
                if f.name == "README.md": continue
                name, desc = extract_metadata(f)
                dest = DOCS_DIR / "agents" / f.name
                shutil.copy(f, dest)
                counts["agents"] += 1
                indices["agents"].append(f"- **[{name or f.stem}]({f.name})** - {desc}")

        # Commands
        cmd_src = dept_path / "commands"
        if cmd_src.exists():
            for f in cmd_src.glob("*.md"):
                if f.name == "README.md": continue
                dest = DOCS_DIR / "commands" / f.name
                shutil.copy(f, dest)
                counts["commands"] += 1
                indices["commands"].append(f"- **[/{f.stem}]({f.name})**")

        # Skills (Recursive)
        skill_src = dept_path / "skills"
        if skill_src.exists():
            for skill_folder in skill_src.iterdir():
                if not skill_folder.is_dir(): continue
                skill_md = skill_folder / "SKILL.md"
                if skill_md.exists():
                    name, desc = extract_metadata(skill_md)
                    dest_folder = DOCS_DIR / "skills" / skill_folder.name
                    dest_folder.mkdir(exist_ok=True)
                    shutil.copy(skill_md, dest_folder / "index.md")
                    
                    for sub in ["references", "assets", "templates"]:
                        if (skill_folder / sub).exists():
                            shutil.copytree(skill_folder / sub, dest_folder / sub, dirs_exist_ok=True)
                    
                    counts["skills"] += 1
                    indices["skills"].append(f"- **[{name or skill_folder.name}]({skill_folder.name}/index.md)** - {desc}")

        # Design (Special case in Growth)
        if dept == "Growth":
            design_src = dept_path / "design"
            if design_src.exists():
                for f in design_src.glob("*.md"):
                    shutil.copy(f, DOCS_DIR / "design" / f.name)
                    indices["design"].append(f"- **[{f.stem}]({f.name})**")

    # 3. Create Index Pages
    with open(DOCS_DIR / "agents/index.md", "w") as f:
        f.write("# Digital Workforce: Agents\n\n" + "\n".join(sorted(indices["agents"])))
    
    with open(DOCS_DIR / "skills/index.md", "w") as f:
        f.write("# Skill Library\n\n" + "\n".join(sorted(indices["skills"])))
        
    with open(DOCS_DIR / "commands/index.md", "w") as f:
        f.write("# Slash Commands\n\n" + "\n".join(sorted(indices["commands"])))
        
    with open(DOCS_DIR / "design/index.md", "w") as f:
        f.write("# Design Systems\n\n" + "\n".join(sorted(indices["design"])))

    print("\nDocumentation Assets Generated:")
    print(f"- Agents: {counts['agents']}")
    print(f"- Skills: {counts['skills']}")
    print(f"- Commands: {counts['commands']}")
    print(f"Total: {sum(counts.values())} pages.")

if __name__ == "__main__":
    generate()
