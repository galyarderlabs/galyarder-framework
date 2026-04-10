import fs from "fs/promises";
import path from "path";
import matter from "gray-matter";

/**
 * Skill definition loaded from Framework
 */
export interface SkillDefinition {
  name: string;
  description: string;
  department: string;
  managedBy?: string;
  triggers?: string[];
  inputs?: string[];
  outputs?: string[];
  filePath: string;
}

/**
 * Skill execution context
 */
export interface SkillContext {
  taskId: string;
  taskTitle: string;
  taskDescription: string;
  companyGoal: string;
  agentName: string;
  workingDirectory: string;
  additionalContext?: Record<string, any>;
}

/**
 * Skill execution result
 */
export interface SkillResult {
  success: boolean;
  output: string;
  artifacts?: string[];
  nextSteps?: string[];
  error?: string;
}

/**
 * Load skill definition from Framework skills directory
 */
export async function loadSkill(skillName: string): Promise<SkillDefinition> {
  const skillsDir = path.resolve(__dirname, "../../../../../skills");
  const skillPath = path.join(skillsDir, skillName, "SKILL.md");
  
  try {
    const content = await fs.readFile(skillPath, "utf-8");
    const parsed = matter(content);
    
    const skill: SkillDefinition = {
      name: skillName,
      description: extractDescription(content),
      department: extractDepartment(content),
      managedBy: extractManagedBy(content),
      triggers: extractTriggers(content),
      inputs: extractInputs(content),
      outputs: extractOutputs(content),
      filePath: skillPath
    };
    
    return skill;
  } catch (error) {
    throw new Error(`Failed to load skill ${skillName}: ${error}`);
  }
}

/**
 * Load all available skills from Framework
 */
export async function loadAllSkills(): Promise<SkillDefinition[]> {
  const skillsDir = path.resolve(__dirname, "../../../../../skills");
  
  try {
    const dirs = await fs.readdir(skillsDir, { withFileTypes: true });
    const skillDirs = dirs.filter(d => d.isDirectory()).map(d => d.name);
    
    const skills = await Promise.all(
      skillDirs.map(async (skillName) => {
        try {
          return await loadSkill(skillName);
        } catch {
          return null;
        }
      })
    );
    
    return skills.filter((s): s is SkillDefinition => s !== null);
  } catch (error) {
    throw new Error(`Failed to load skills: ${error}`);
  }
}

/**
 * Get skills by department
 */
export async function getSkillsByDepartment(department: string): Promise<SkillDefinition[]> {
  const skills = await loadAllSkills();
  return skills.filter(s => s.department === department);
}

/**
 * Get skills managed by specific agent
 */
export async function getSkillsByAgent(agentName: string): Promise<SkillDefinition[]> {
  const skills = await loadAllSkills();
  return skills.filter(s => s.managedBy === agentName);
}

/**
 * Execute skill via runtime adapter
 * 
 * This is a placeholder - actual execution will delegate to runtime adapters
 * (claude-local, cursor-local, etc.)
 */
export async function executeSkill(
  skill: SkillDefinition,
  context: SkillContext,
  runtime: string
): Promise<SkillResult> {
  try {
    // Load skill instructions
    const instructions = await fs.readFile(skill.filePath, "utf-8");
    
    // Build execution prompt
    const prompt = buildSkillPrompt(skill, context, instructions);
    
    // TODO: Delegate to runtime adapter (claude, cursor, etc.)
    // For now, return mock result
    
    return {
      success: true,
      output: `Executed skill: ${skill.name}\nTask: ${context.taskTitle}`,
      artifacts: [],
      nextSteps: []
    };
  } catch (error) {
    return {
      success: false,
      output: "",
      error: error instanceof Error ? error.message : String(error)
    };
  }
}

/**
 * Build execution prompt for skill
 */
function buildSkillPrompt(
  skill: SkillDefinition,
  context: SkillContext,
  instructions: string
): string {
  return `
# Skill Execution: ${skill.name}

## Company Goal
${context.companyGoal}

## Task
**Title:** ${context.taskTitle}
**Description:** ${context.taskDescription}

## Skill Instructions
${instructions}

## Context
Agent: ${context.agentName}
Working Directory: ${context.workingDirectory}

## Your Task
Execute this skill according to the instructions above.
Produce the expected outputs.
Report results clearly.
`.trim();
}

// Helper parsers

function extractDescription(content: string): string {
  const lines = content.split("\n");
  for (let i = 0; i < Math.min(10, lines.length); i++) {
    const line = lines[i].trim();
    if (line && !line.startsWith("#") && !line.startsWith("**")) {
      return line;
    }
  }
  return "";
}

function extractDepartment(content: string): string {
  if (content.includes("Engineering") || content.includes("TDD") || content.includes("debugging")) return "Engineering";
  if (content.includes("Product") || content.includes("PRD")) return "Product";
  if (content.includes("Growth") || content.includes("SEO") || content.includes("marketing")) return "Growth";
  if (content.includes("Security") || content.includes("vulnerability")) return "Security";
  if (content.includes("Legal") || content.includes("compliance")) return "Legal/Finance";
  if (content.includes("DevOps") || content.includes("deployment")) return "Operations";
  if (content.includes("fundraising") || content.includes("investor")) return "Founder Office";
  if (content.includes("Obsidian") || content.includes("documentation")) return "Knowledge";
  return "General";
}

function extractManagedBy(content: string): string | undefined {
  const match = content.match(/\*\*Managed by:\*\*\s*@?([a-z-]+)/i);
  return match ? match[1] : undefined;
}

function extractTriggers(content: string): string[] {
  const match = content.match(/\*\*Triggers?:\*\*\s*\n((?:[-*]\s*.+\n?)+)/);
  if (!match) return [];
  
  return match[1]
    .split("\n")
    .filter(line => line.trim().startsWith("-") || line.trim().startsWith("*"))
    .map(line => line.replace(/^[-*]\s*/, "").trim())
    .filter(Boolean);
}

function extractInputs(content: string): string[] {
  const match = content.match(/\*\*Inputs?:\*\*\s*\n((?:[-*]\s*.+\n?)+)/);
  if (!match) return [];
  
  return match[1]
    .split("\n")
    .filter(line => line.trim().startsWith("-") || line.trim().startsWith("*"))
    .map(line => line.replace(/^[-*]\s*/, "").trim())
    .filter(Boolean);
}

function extractOutputs(content: string): string[] {
  const match = content.match(/\*\*Outputs?:\*\*\s*\n((?:[-*]\s*.+\n?)+)/);
  if (!match) return [];
  
  return match[1]
    .split("\n")
    .filter(line => line.trim().startsWith("-") || line.trim().startsWith("*"))
    .map(line => line.replace(/^[-*]\s*/, "").trim())
    .filter(Boolean);
}

/**
 * Create skill registry for fast lookup
 */
export class SkillRegistry {
  private skills: Map<string, SkillDefinition> = new Map();
  private loaded = false;
  
  async load(): Promise<void> {
    if (this.loaded) return;
    
    const skills = await loadAllSkills();
    for (const skill of skills) {
      this.skills.set(skill.name, skill);
    }
    
    this.loaded = true;
  }
  
  get(skillName: string): SkillDefinition | undefined {
    return this.skills.get(skillName);
  }
  
  getAll(): SkillDefinition[] {
    return Array.from(this.skills.values());
  }
  
  getByDepartment(department: string): SkillDefinition[] {
    return this.getAll().filter(s => s.department === department);
  }
  
  getByAgent(agentName: string): SkillDefinition[] {
    return this.getAll().filter(s => s.managedBy === agentName);
  }
}

// Global registry instance
export const skillRegistry = new SkillRegistry();
