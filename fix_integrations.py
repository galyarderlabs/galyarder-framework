import re
import os

TOOLS = ["antigravity", "cursor", "kilocode", "windsurf", "opencode", "augment", "claude-code", "codex", "gemini", "openclaw", "hermes", "galyarder-agent"]

count = 0
for t in TOOLS:
    for root, dirs, files in os.walk(f'integrations/{t}'):
        for file in files:
            if file.endswith('.md') or file.endswith('.mdc') or file.endswith('.py'):
                filepath = os.path.join(root, file)
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()

                new_content = re.sub(r'"version": "0.0.1"', r'"version": "1.8.1"', content)

                if new_content != content:
                    count += 1
                    with open(filepath, 'w', encoding='utf-8') as f:
                        f.write(new_content)
print(count)
