import os
import json

DEPARTMENTS = [
    "Engineering", "Growth", "Security", "Product",
    "Executive", "Infrastructure", "Legal-Finance", "Knowledge"
]

def generate_consolidated_skill(name, skill_paths, output_dir):
    os.makedirs(output_dir, exist_ok=True)
    output_file = os.path.join(output_dir, "SKILL.md")
    
    with open(output_file, "w") as out:
        out.write(f"---\nname: {name}\ndescription: \"Consolidated Galyarder Framework {name.capitalize()} intelligence bundle.\"\n---\n\n")
        out.write(f"# GALYARDER {name.upper()} BUNDLE\n\n")
        out.write(f"This bundle contains {len(skill_paths)} high-integrity SOPs for the {name.capitalize()} department.\n\n")
        
        for path in sorted(skill_paths):
            if os.path.exists(path):
                skill_name = os.path.basename(os.path.dirname(path))
                out.write(f"\n---\n## SKILL: {skill_name}\n")
                with open(path, "r") as f:
                    content = f.read()
                    # Remove frontmatter if present
                    if content.startswith("---"):
                        parts = content.split("---", 2)
                        if len(parts) >= 3:
                            content = parts[2]
                    out.write(content.strip() + "\n")
    
    return output_file

def generate_manifest():
    skills_map = {}
    dept_skills = {dept.lower(): [] for dept in DEPARTMENTS}
    all_skill_paths = []

    # 1. Scan Departments
    for dept in DEPARTMENTS:
        dept_path = os.path.join(dept, "skills")
        if not os.path.exists(dept_path):
            continue
            
        for skill_dir in os.listdir(dept_path):
            skill_full_path = os.path.join(dept_path, skill_dir)
            if not os.path.isdir(skill_full_path):
                continue
                
            skill_file = os.path.join(skill_full_path, "SKILL.md")
            if os.path.exists(skill_file):
                skills_map[skill_dir] = skill_file
                dept_skills[dept.lower()].append(skill_file)
                all_skill_paths.append(skill_file)

    # 2. Generate Departmental Bundles inside root skills/
    for dept, paths in dept_skills.items():
        if paths:
            bundle_dir = os.path.join("skills", dept)
            generate_consolidated_skill(dept, paths, bundle_dir)
            
    # 3. Generate 'full' and 'galyarder' bundles
    generate_consolidated_skill("full", all_skill_paths, os.path.join("skills", "full"))
    generate_consolidated_skill("galyarder", all_skill_paths, os.path.join("skills", "galyarder"))

    # 4. Build the Registry (skills.json)
    # Mapping for tools that support manifest
    registry = {}
    for name, path in skills_map.items():
        registry[name] = path
    
    for dept in dept_skills:
        registry[dept] = f"skills/{dept}/SKILL.md"
    
    registry["full"] = "skills/full/SKILL.md"
    registry["galyarder"] = "skills/galyarder/SKILL.md"

    with open("skills.json", "w") as f:
        json.dump(registry, f, indent=2)
    
    print(f"✅ Created consolidated bundles in skills/ (engineering, growth, etc.)")
    print(f"✅ Created skills.json with {len(skills_map)} individual skills.")

if __name__ == "__main__":
    generate_manifest()
