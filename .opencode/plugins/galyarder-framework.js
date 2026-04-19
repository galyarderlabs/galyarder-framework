/**
 * Galyarder Framework plugin for OpenCode.ai
 */

import path from 'path';
import fs from 'fs';
import os from 'os';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const extractAndStripFrontmatter = (content) => {
  const match = content.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
  if (!match) return { frontmatter: {}, content };

  const frontmatterStr = match[1];
  const body = match[2];
  const frontmatter = {};

  for (const line of frontmatterStr.split('\n')) {
    const colonIdx = line.indexOf(':');
    if (colonIdx > 0) {
      const key = line.slice(0, colonIdx).trim();
      const value = line.slice(colonIdx + 1).trim().replace(/^["']|["']$/g, '');
      frontmatter[key] = value;
    }
  }

  return { frontmatter, content: body };
};

export const GalyarderFrameworkPlugin = async ({ client, directory }) => {
  const repoRoot = path.resolve(__dirname, '../../');
  
  // High-Integrity Silo Discovery
  const SILOS = [
    'Executive', 'Engineering', 'Growth', 'Security', 
    'Product', 'Infrastructure', 'Legal-Finance', 'Knowledge'
  ];

  const getBootstrapContent = () => {
    // Bootstrap always comes from Executive department
    const skillPath = path.join(repoRoot, 'Executive', 'skills', 'using-galyarder-framework', 'SKILL.md');
    if (!fs.existsSync(skillPath)) return null;

    const fullContent = fs.readFileSync(skillPath, 'utf8');
    const { content } = extractAndStripFrontmatter(fullContent);

    const toolMapping = `**Tool Mapping for OpenCode:**
When skills reference tools you don't have, substitute OpenCode equivalents:
- \`TodoWrite\`  \`todowrite\`
- \`Task\` tool with subagents  Use OpenCode's subagent system (@mention)
- \`Skill\` tool  OpenCode's native \`skill\` tool
- \`Read\`, \`Write\`, \`Edit\`, \`Bash\`  Your native tools`;

    return `<EXTREMELY_IMPORTANT>
You have Galyarder Framework.

${content}

${toolMapping}
</EXTREMELY_IMPORTANT>`;
  };

  return {
    config: async (config) => {
      config.skills = config.skills || {};
      config.skills.paths = config.skills.paths || [];
      
      // Inject all Silo paths
      SILOS.forEach(silo => {
        const siloSkillsPath = path.join(repoRoot, silo, 'skills');
        if (fs.existsSync(siloSkillsPath) && !config.skills.paths.includes(siloSkillsPath)) {
          config.skills.paths.push(siloSkillsPath);
        }
      });
    },

    'experimental.chat.messages.transform': async (_input, output) => {
      const bootstrap = getBootstrapContent();
      if (!bootstrap || !output.messages.length) return;
      const firstUser = output.messages.find(m => m.info.role === 'user');
      if (!firstUser || !firstUser.parts.length) return;
      if (firstUser.parts.some(p => p.type === 'text' && p.text.includes('EXTREMELY_IMPORTANT'))) return;
      const ref = firstUser.parts[0];
      firstUser.parts.unshift({ ...ref, type: 'text', text: bootstrap });
    }
  };
};
