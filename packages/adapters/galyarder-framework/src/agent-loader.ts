import fs from "fs/promises";
import path from "path";
import matter from "gray-matter";

/**
 * Agent definition loaded from Framework
 */
export interface AgentDefinition {
  name: string;
  role: string;
  mission: string;
  department: string;
  responsibilities: string[];
  skills: string[];
  reportsTo?: string;
  filePath: string;
}

/**
 * Load agent definition from Framework agents directory
 */
export async function loadAgent(agentName: string): Promise<AgentDefinition> {
  const agentsDir = path.resolve(__dirname, "../../../../../agents");
  const agentPath = path.join(agentsDir, `${agentName}.md`);
  
  try {
    const content = await fs.readFile(agentPath, "utf-8");
    const parsed = matter(content);
    
    // Parse markdown content
    const agent: AgentDefinition = {
      name: agentName,
      role: extractRole(content),
      mission: extractMission(content),
      department: extractDepartment(content),
      responsibilities: extractResponsibilities(content),
      skills: extractSkills(content),
      filePath: agentPath
    };
    
    return agent;
  } catch (error) {
    throw new Error(`Failed to load agent ${agentName}: ${error}`);
  }
}

/**
 * Load all available agents from Framework
 */
export async function loadAllAgents(): Promise<AgentDefinition[]> {
  const agentsDir = path.resolve(__dirname, "../../../../../agents");
  
  try {
    const files = await fs.readdir(agentsDir);
    const agentFiles = files.filter(f => f.endsWith(".md"));
    
    const agents = await Promise.all(
      agentFiles.map(async (file) => {
        const agentName = file.replace(".md", "");
        return loadAgent(agentName);
      })
    );
    
    return agents;
  } catch (error) {
    throw new Error(`Failed to load agents: ${error}`);
  }
}

/**
 * Get agents by department
 */
export async function getAgentsByDepartment(department: string): Promise<AgentDefinition[]> {
  const agents = await loadAllAgents();
  return agents.filter(a => a.department === department);
}

// Helper parsers

function extractRole(content: string): string {
  const match = content.match(/\*\*Role:\*\*\s*(.+)/i) || 
                content.match(/\*\*Mission:\*\*\s*(.+)/i);
  return match ? match[1].trim() : "Agent";
}

function extractMission(content: string): string {
  const match = content.match(/\*\*Mission:\*\*\s*(.+?)(?:\n\n|\*\*)/s);
  return match ? match[1].trim() : "";
}

function extractDepartment(content: string): string {
  // Try to extract from headers or content
  if (content.includes("Engineering")) return "Engineering";
  if (content.includes("Product")) return "Product";
  if (content.includes("Growth")) return "Growth";
  if (content.includes("Security")) return "Security";
  if (content.includes("Legal") || content.includes("Finance")) return "Legal/Finance";
  if (content.includes("Operations") || content.includes("DevOps")) return "Operations";
  if (content.includes("Founder") || content.includes("Fundraising")) return "Founder Office";
  if (content.includes("Knowledge") || content.includes("Obsidian")) return "Knowledge";
  return "General";
}

function extractResponsibilities(content: string): string[] {
  const match = content.match(/\*\*Core Responsibilities:\*\*\s*\n((?:[-*]\s*.+\n?)+)/);
  if (!match) return [];
  
  return match[1]
    .split("\n")
    .filter(line => line.trim().startsWith("-") || line.trim().startsWith("*"))
    .map(line => line.replace(/^[-*]\s*/, "").trim())
    .filter(Boolean);
}

function extractSkills(content: string): string[] {
  // Look for skills section or references to skills
  const skillsMatch = content.match(/\*\*Skills:\*\*\s*\n((?:[-*]\s*.+\n?)+)/);
  if (skillsMatch) {
    return skillsMatch[1]
      .split("\n")
      .filter(line => line.trim().startsWith("-") || line.trim().startsWith("*"))
      .map(line => line.replace(/^[-*]\s*/, "").replace(/`/g, "").trim())
      .filter(Boolean);
  }
  
  // Fallback: extract skill names from content
  const skillPattern = /`([a-z-]+(?:-[a-z]+)*)`/g;
  const skills = new Set<string>();
  let match;
  
  while ((match = skillPattern.exec(content)) !== null) {
    const skill = match[1];
    // Only include if it looks like a skill name (kebab-case)
    if (skill.includes("-") && skill.length > 3) {
      skills.add(skill);
    }
  }
  
  return Array.from(skills);
}

/**
 * Get agent's full instructions for execution
 */
export async function getAgentInstructions(agentName: string): Promise<string> {
  const agent = await loadAgent(agentName);
  const content = await fs.readFile(agent.filePath, "utf-8");
  return content;
}
