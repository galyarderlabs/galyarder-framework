import { loadAgent, AgentDefinition } from "./agent-loader.js";
import { loadSkill, executeSkill, skillRegistry, SkillContext, SkillResult } from "./skill-executor.js";

/**
 * Task routing decision
 */
export interface RoutingDecision {
  targetAgent: string;
  targetDepartment: string;
  recommendedSkills: string[];
  reasoning: string;
}

/**
 * Orchestrator - implements galyarder-specialist routing logic
 */
export class Orchestrator {
  private agents: Map<string, AgentDefinition> = new Map();
  
  async initialize(): Promise<void> {
    // Load skill registry
    await skillRegistry.load();
    
    // Load key agents
    const keyAgents = [
      "galyarder-specialist",
      "product-manager",
      "super-architect",
      "elite-developer",
      "security-guardian",
      "growth-strategist",
      "fundraising-operator",
      "obsidian-architect"
    ];
    
    for (const agentName of keyAgents) {
      try {
        const agent = await loadAgent(agentName);
        this.agents.set(agentName, agent);
      } catch (error) {
        console.warn(`Failed to load agent ${agentName}:`, error);
      }
    }
  }
  
  /**
   * Route task to appropriate department/agent
   */
  async routeTask(task: {
    title: string;
    description: string;
    companyGoal: string;
  }): Promise<RoutingDecision> {
    const taskText = `${task.title} ${task.description}`.toLowerCase();
    
    // Engineering tasks
    if (this.isEngineeringTask(taskText)) {
      return {
        targetAgent: "elite-developer",
        targetDepartment: "Engineering",
        recommendedSkills: ["test-driven-development", "systematic-debugging"],
        reasoning: "Task involves code implementation or debugging"
      };
    }
    
    // Product tasks
    if (this.isProductTask(taskText)) {
      return {
        targetAgent: "product-manager",
        targetDepartment: "Product",
        recommendedSkills: ["write-a-prd", "prd-to-plan", "brainstorming"],
        reasoning: "Task involves product planning or requirements"
      };
    }
    
    // Security tasks
    if (this.isSecurityTask(taskText)) {
      return {
        targetAgent: "security-guardian",
        targetDepartment: "Security",
        recommendedSkills: ["executing-red-team-exercise"],
        reasoning: "Task involves security review or threat analysis"
      };
    }
    
    // Growth tasks
    if (this.isGrowthTask(taskText)) {
      return {
        targetAgent: "growth-strategist",
        targetDepartment: "Growth",
        recommendedSkills: ["seo-audit", "copywriting", "onboarding-cro"],
        reasoning: "Task involves marketing, growth, or conversion"
      };
    }
    
    // Fundraising tasks
    if (this.isFundraisingTask(taskText)) {
      return {
        targetAgent: "fundraising-operator",
        targetDepartment: "Founder Office",
        recommendedSkills: ["pitch-deck", "investor-research", "fundraising-email"],
        reasoning: "Task involves fundraising or investor relations"
      };
    }
    
    // Default to product for planning
    return {
      targetAgent: "product-manager",
      targetDepartment: "Product",
      recommendedSkills: ["brainstorming"],
      reasoning: "Default routing for general tasks"
    };
  }
  
  /**
   * Execute task through appropriate agent and skills
   */
  async executeTask(
    task: {
      id: string;
      title: string;
      description: string;
      companyGoal: string;
    },
    assignedAgent: string,
    runtime: string,
    workingDirectory: string
  ): Promise<{
    success: boolean;
    output: string;
    skillsUsed: string[];
    error?: string;
  }> {
    try {
      // Get routing decision
      const routing = await this.routeTask(task);
      
      // Load agent
      const agent = this.agents.get(assignedAgent) || await loadAgent(assignedAgent);
      
      // Determine which skills to use
      const skillsToUse = routing.recommendedSkills.length > 0 
        ? routing.recommendedSkills 
        : agent.skills.slice(0, 3); // Use first 3 agent skills as fallback
      
      // Execute skills sequentially
      const results: SkillResult[] = [];
      const context: SkillContext = {
        taskId: task.id,
        taskTitle: task.title,
        taskDescription: task.description,
        companyGoal: task.companyGoal,
        agentName: assignedAgent,
        workingDirectory
      };
      
      for (const skillName of skillsToUse) {
        try {
          const skill = await loadSkill(skillName);
          const result = await executeSkill(skill, context, runtime);
          results.push(result);
          
          if (!result.success) {
            break; // Stop on first failure
          }
        } catch (error) {
          console.warn(`Failed to execute skill ${skillName}:`, error);
        }
      }
      
      // Aggregate results
      const allSuccess = results.every(r => r.success);
      const output = results.map(r => r.output).join("\n\n");
      
      return {
        success: allSuccess,
        output,
        skillsUsed: skillsToUse,
        error: allSuccess ? undefined : "Some skills failed to execute"
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
  
  // Task classification helpers
  
  private isEngineeringTask(text: string): boolean {
    const keywords = [
      "implement", "code", "build", "develop", "fix", "bug", "test",
      "refactor", "debug", "api", "database", "frontend", "backend"
    ];
    return keywords.some(k => text.includes(k));
  }
  
  private isProductTask(text: string): boolean {
    const keywords = [
      "prd", "requirements", "spec", "design", "plan", "roadmap",
      "feature", "prioritize", "scope"
    ];
    return keywords.some(k => text.includes(k));
  }
  
  private isSecurityTask(text: string): boolean {
    const keywords = [
      "security", "vulnerability", "audit", "pentest", "threat",
      "exploit", "attack", "breach", "compliance"
    ];
    return keywords.some(k => text.includes(k));
  }
  
  private isGrowthTask(text: string): boolean {
    const keywords = [
      "seo", "marketing", "growth", "conversion", "funnel", "landing",
      "copy", "content", "social", "analytics", "traffic"
    ];
    return keywords.some(k => text.includes(k));
  }
  
  private isFundraisingTask(text: string): boolean {
    const keywords = [
      "fundraising", "investor", "pitch", "deck", "raise", "capital",
      "board", "accelerator", "vc", "angel"
    ];
    return keywords.some(k => text.includes(k));
  }
}

// Global orchestrator instance
export const orchestrator = new Orchestrator();
