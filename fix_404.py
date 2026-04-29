import os
import re

def fix_links():
    # Fix docs/README.codex.md
    with open('docs/README.codex.md', 'r') as f:
        content = f.read()
    content = content.replace('../skills/using-references/codex-tools.md', 'skills/using-galyarder-framework/references/codex-tools.md')
    with open('docs/README.codex.md', 'w') as f:
        f.write(content)

    # Remove dead links in docs/skills/finance-based-pricing-advisor/index.md
    # No obvious alternative for workshop-facilitation
    with open('docs/skills/finance-based-pricing-advisor/index.md', 'r') as f:
        content = f.read()
    content = re.sub(r'\[([^\]]+)\]\(\.\./workshop-facilitation/SKILL\.md\)', r'\1', content)
    with open('docs/skills/finance-based-pricing-advisor/index.md', 'w') as f:
        f.write(content)

    # Remove dead links in docs/skills/content-creator/index.md
    with open('docs/skills/content-creator/index.md', 'r') as f:
        content = f.read()
    content = re.sub(r'\[([^\]]+)\]\(\.\./content-production/\)', r'\1', content)
    with open('docs/skills/content-creator/index.md', 'w') as f:
        f.write(content)

    # Remove dead links in docs/skills/content-strategy/references/headless-cms.md
    with open('docs/skills/content-strategy/references/headless-cms.md', 'r') as f:
        content = f.read()
    content = re.sub(r'\[([^\]]+)\]\(\.\.\/\.\.\/\.\.\/tools\/integrations\/(?:sanity|contentful|strapi)\.md\)', r'\1', content)
    with open('docs/skills/content-strategy/references/headless-cms.md', 'w') as f:
        f.write(content)

    # Remove dead links in docs/skills/cloud-security/index.md
    with open('docs/skills/cloud-security/index.md', 'r') as f:
        content = f.read()
    content = re.sub(r'\[([^\]]+)\]\(\.\./incident-response/SKILL\.md\)', r'\1', content)
    content = re.sub(r'\[([^\]]+)\]\(\.\./threat-detection/SKILL\.md\)', r'\1', content)
    content = re.sub(r'\[([^\]]+)\]\(\.\./red-team/SKILL\.md\)', r'\1', content)
    content = re.sub(r'\[([^\]]+)\]\(\.\./security-pen-testing/SKILL\.md\)', r'\1', content)
    with open('docs/skills/cloud-security/index.md', 'w') as f:
        f.write(content)

fix_links()
