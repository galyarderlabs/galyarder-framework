import os
import re

FILE_PATH = 'scripts/generate-docs.py'

with open(FILE_PATH, 'r', encoding='utf-8') as f:
    content = f.read()

# Fix the unpacking of agent_entries
content = content.replace(
    'for name, slug, title, desc in agent_entries:',
    'for name, slug, title, desc, domain in agent_entries:'
)

with open(FILE_PATH, 'w', encoding='utf-8') as f:
    f.write(content)

print(f"Fixed unpacking in {FILE_PATH}")
