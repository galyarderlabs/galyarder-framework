import os
import json

DEPARTMENTS = [
    "Engineering", "Growth", "Security", "Product",
    "Executive", "Infrastructure", "Legal-Finance", "Knowledge"
]

def generate_manifest():
    skills_manifest = {}
    dept_bundles = {dept.lower(): [] for dept in DEPARTMENTS}
    all_skills = []

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
                skills_manifest[skill_dir] = skill_file
                dept_bundles[dept.lower()].append(skill_file)
                all_skills.append(skill_file)

    # 2. Scan Root Skills (for any missed ones)
    root_skills_path = "skills"
    if os.path.exists(root_skills_path):
        for skill_dir in os.listdir(root_skills_path):
            if skill_dir in skills_manifest:
                continue
            
            skill_full_path = os.path.join(root_skills_path, skill_dir)
            if not os.path.isdir(skill_full_path):
                continue
                
            skill_file = os.path.join(skill_full_path, "SKILL.md")
            if os.path.exists(skill_file):
                skills_manifest[skill_dir] = skill_file
                all_skills.append(skill_file)

    # 3. Build the Registry
    # skills.sh format is a simple mapping of skill_name -> file_path or list of paths
    registry = {}
    
    # Individual Skills
    for name, path in skills_manifest.items():
        registry[name] = path
        
    # Department Bundles
    for dept, paths in dept_bundles.items():
        if paths:
            registry[dept] = paths
            
    # Full Bundle
    registry["full"] = all_skills
    registry["galyarder"] = all_skills

    # 4. Save to skills.json
    with open("skills.json", "w") as f:
        json.dump(registry, f, indent=2)
    
    print(f"✅ Created skills.json with {len(skills_manifest)} individual skills and {len(dept_bundles)} department bundles.")

if __name__ == "__main__":
    generate_manifest()
