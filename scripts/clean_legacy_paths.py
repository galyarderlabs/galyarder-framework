import os
import re

replacements = [
    (r'\.agents/founder-context\.md', r'docs/departments/Executive/founder-context.md'),
    (r'\.agents/product-marketing-context\.md', r'docs/departments/Growth/product-marketing-context.md'),
    (r'\.claude/product-marketing-context\.md', r'docs/departments/Growth/product-marketing-context.md'),
    (r'~/\.claude/skills` for Claude Code, `~/\.agents/skills/` for Codex', r'integrations/claude-code/` for Claude Code, `integrations/codex/` for Codex'),
    (r'\.agents/skills/release-changelog/SKILL\.md', r'Infrastructure/skills/release-changelog/SKILL.md'),
    (r'New \.agents/skills/ directory convention', r'New Department Silo directory convention'),
]

files_changed = 0

for root, _, files in os.walk('.'):
    # Only target source files (integrations/ and docs/ will be rebuilt)
    if any(d in root for d in ['.git', 'node_modules', 'integrations', 'docs']):
        continue
        
    for file in files:
        if file.endswith('.md'):
            filepath = os.path.join(root, file)
            try:
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                original_content = content
                for old_pat, new_str in replacements:
                    content = re.sub(old_pat, new_str, content)
                
                if content != original_content:
                    with open(filepath, 'w', encoding='utf-8') as f:
                        f.write(content)
                    files_changed += 1
            except Exception as e:
                pass

print(f"Path cleanup complete. Modified {files_changed} source files.")
