/**
 * Galyarder Framework Adapter
 * 
 * Executes agents using Galyarder Framework skills library.
 * Bridges Dashboard orchestration with Framework execution.
 */

import { orchestrator } from "./orchestrator.js";
import { loadAgent, loadAllAgents } from "./agent-loader.js";
import { loadAllSkills, skillRegistry } from "./skill-executor.js";

export const type = "galyarder_framework";
export const label = "Galyarder Framework Agent";

export const models = [
  { id: "framework-v1", label: "Framework v1.4.0" }
];

export const agentConfigurationDoc = `# galyarder_framework adapter

Runs agents using Galyarder Framework skills and orchestration.

## Configuration

### Required Fields:
- **agentName** (string): Framework agent name (e.g., "galyarder-specialist", "elite-developer")
- **runtime** (string): Underlying execution runtime ("claude", "cursor", "codex", "gemini")

### Optional Fields:
- **skills** (string[]): Specific skills this agent can use (defaults to all skills for agent's department)
- **department** (string): Department this agent belongs to
- **instructionsPath** (string): Path to agent's .md file (auto-detected if not provided)
- **workingDirectory** (string): Working directory for execution
- **model** (string): LLM model to use (runtime-specific)
- **maxTurns** (number): Max conversation turns per execution
- **timeoutSec** (number): Execution timeout in seconds

## Agent Names

Available Framework agents:
- galyarder-specialist (CEO/Orchestrator)
- product-manager (Product)
- planner (Product)
- super-architect (Engineering)
- architect (Engineering)
- elite-developer (Engineering)
- build-error-resolver (Engineering)
- code-reviewer (Engineering)
- refactor-cleaner (Engineering)
- qa-automation-engineer (Engineering)
- security-guardian (Security)
- security-reviewer (Security)
- perseus (Security)
- cyber-intel (Security)
- growth-strategist (Growth)
- growth-engineer (Growth)
- conversion-engineer (Growth)
- retention-specialist (Growth)
- social-strategist (Growth)
- analytics-architect (Growth)
- devops-engineer (Operations)
- release-manager (Operations)
- legal-counsel (Legal/Finance)
- finops-manager (Legal/Finance)
- fundraising-operator (Founder Office)
- obsidian-architect (Knowledge)

## Example Configuration

\`\`\`json
{
  "agentName": "galyarder-specialist",
  "runtime": "claude",
  "model": "claude-sonnet-4-6",
  "skills": ["brainstorming", "prd-to-plan", "prd-to-issues"],
  "department": "Executive",
  "workingDirectory": "/workspace",
  "maxTurns": 10,
  "timeoutSec": 300
}
\`\`\`

## How It Works

1. Dashboard assigns task to agent
2. Adapter loads agent definition from Framework
3. Determines which skills are needed
4. Executes via specified runtime (Claude/Cursor/etc.)
5. Returns results to Dashboard
6. Dashboard updates task status

## Integration Points

- **Skills**: Loaded from ../../skills/
- **Agents**: Loaded from ../../agents/
- **Commands**: Available from ../../commands/
- **Design Rules**: Available from ../../rules/design/

## Notes

- Agent definitions are loaded from Framework repository
- Skills are executed through the specified runtime adapter
- galyarder-specialist provides orchestration and routing
- Department heads manage their skill workers
- All execution follows Framework workflow (5 phases)
`;

/**
 * Agent configuration schema
 */
export interface GalyarderFrameworkConfig {
  agentName: string;
  runtime: "claude" | "cursor" | "codex" | "gemini";
  skills?: string[];
  department?: string;
  instructionsPath?: string;
  workingDirectory?: string;
  model?: string;
  maxTurns?: number;
  timeoutSec?: number;
}

/**
 * Execution context passed to adapter
 */
export interface ExecutionContext {
  taskId: string;
  taskTitle: string;
  taskDescription: string;
  companyGoal: string;
  agentId: string;
  companyId: string;
}

/**
 * Execution result returned by adapter
 */
export interface ExecutionResult {
  success: boolean;
  output: string;
  skillsUsed: string[];
  tokensUsed?: number;
  cost?: number;
  error?: string;
}

/**
 * Initialize adapter (called once on startup)
 */
export async function initialize(): Promise<void> {
  console.log("Initializing Galyarder Framework adapter...");
  await orchestrator.initialize();
  console.log("Galyarder Framework adapter ready");
}

/**
 * Main execution function called by Dashboard
 * 
 * @param config - Agent configuration
 * @param context - Execution context (task, company, etc.)
 * @returns Execution result
 */
export async function executeHeartbeat(
  config: GalyarderFrameworkConfig,
  context: ExecutionContext
): Promise<ExecutionResult> {
  try {
    // Validate config
    validateConfig(config);
    
    // Execute task through orchestrator
    const result = await orchestrator.executeTask(
      {
        id: context.taskId,
        title: context.taskTitle,
        description: context.taskDescription,
        companyGoal: context.companyGoal
      },
      config.agentName,
      config.runtime,
      config.workingDirectory || "/workspace"
    );
    
    return {
      success: result.success,
      output: result.output,
      skillsUsed: result.skillsUsed,
      tokensUsed: 0, // TODO: Track actual token usage
      cost: 0, // TODO: Calculate actual cost
      error: result.error
    };
  } catch (error) {
    return {
      success: false,
      output: "",
      skillsUsed: [],
      error: error instanceof Error ? error.message : String(error)
    };
  }
}

/**
 * Validate agent configuration
 */
export function validateConfig(config: any): config is GalyarderFrameworkConfig {
  if (!config.agentName || typeof config.agentName !== "string") {
    throw new Error("agentName is required");
  }
  
  if (!config.runtime || !["claude", "cursor", "codex", "gemini"].includes(config.runtime)) {
    throw new Error("runtime must be one of: claude, cursor, codex, gemini");
  }
  
  return true;
}

/**
 * Get available agents from Framework
 */
export async function getAvailableAgents(): Promise<Array<{
  name: string;
  role: string;
  department: string;
  skills: string[];
}>> {
  const agents = await loadAllAgents();
  return agents.map(a => ({
    name: a.name,
    role: a.role,
    department: a.department,
    skills: a.skills
  }));
}

/**
 * Get available skills from Framework
 */
export async function getAvailableSkills(): Promise<Array<{
  name: string;
  description: string;
  department: string;
}>> {
  await skillRegistry.load();
  const skills = skillRegistry.getAll();
  return skills.map(s => ({
    name: s.name,
    description: s.description,
    department: s.department
  }));
}

/**
 * Get agent details
 */
export async function getAgentDetails(agentName: string) {
  const agent = await loadAgent(agentName);
  return {
    name: agent.name,
    role: agent.role,
    mission: agent.mission,
    department: agent.department,
    responsibilities: agent.responsibilities,
    skills: agent.skills
  };
}
