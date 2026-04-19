import os
import shutil
import json

REPO_ROOT = os.getcwd()

# Mapping configuration based on ORG_CHART.md
MAPPING = {
    "Executive": {
        "personas": ["galyarder-ceo.md", "galyarder-cto.md", "galyarder-cmo.md", "galyarder-cfo-coo.md"],
        "agents": ["galyarder-specialist.md", "fundraising-operator.md", "chief-of-staff.md"],
        "skills": ["using-galyarder-framework", "writing-skills", "brainstorming", "founder-context", "pitch-deck", "investor-research", "fundraising-email", "data-room", "board-update", "accelerator-application", "market-research", "lead-scoring", "founder-thought-leadership"]
    },
    "Engineering": {
        "agents": ["elite-developer.md", "architect.md", "super-architect.md", "qa-automation-engineer.md", "code-reviewer.md", "build-error-resolver.md", "refactor-cleaner.md", "vercel-react-expert.md", "e2e-runner.md", "tdd-guide.md"],
        "skills": ["test-driven-development", "systematic-debugging", "verification-before-completion", "subagent-driven-development", "requesting-code-review", "receiving-code-review", "finishing-a-development-branch", "vercel-react-best-practices", "playwright-pro"],
        "commands": ["tdd.md", "review.md", "build-fix.md", "e2e.md", "clean.md", "docs.md"]
    },
    "Growth": {
        "agents": ["growth-strategist.md", "growth-engineer.md", "conversion-engineer.md", "retention-specialist.md", "social-strategist.md", "sales-engineer.md", "remotion-engineer.md"],
        "skills": ["seo-audit", "schema-markup", "onboarding-cro", "marketing-psychology", "copywriting", "content-strategy", "competitor-alternatives", "analytics-tracking", "ab-test-setup", "campaign-analytics", "content-creator", "email-marketing-bible", "marketing-demand-acquisition", "marketing-ideas", "page-cro", "paywall-upgrade-cro", "programmatic-seo", "referral-program", "revenue-architect", "social-content"],
        "commands": ["marketing.md", "seo.md", "cro.md", "video.md"],
        "design_folder": True
    },
    "Security": {
        "agents": ["security-guardian.md", "security-reviewer.md", "cyber-intel.md", "perseus.md"],
        "skills": ["executing-red-team-exercise", "monitoring-darkweb-sources", "tracking-threat-actor-infrastructure", "testing-for-xss-vulnerabilities-with-burpsuite", "generating-threat-intelligence-reports", "executing-phishing-simulation-campaign", "investigating-phishing-email-incident", "profiling-threat-actor-groups", "intercepting-mobile-traffic-with-burpsuite", "executing-active-directory-attack-simulation", "eradicating-malware-from-infected-systems", "reverse-engineering-malware-with-ghidra", "mapping-mitre-attack-techniques", "executing-red-team-engagement-planning", "recovering-from-ransomware-attack", "recovering-deleted-files-with-photorec", "cloud-security"],
        "commands": ["cybersecurity.md"]
    },
    "Product": {
        "agents": ["product-manager.md", "planner.md", "rapid-prototyper.md"],
        "skills": ["write-a-prd", "prd-to-plan", "prd-to-issues", "writing-plans", "executing-plans", "ubiquitous-language"],
        "commands": ["plan.md", "linear.md", "triage.md"]
    },
    "Infrastructure": {
        "agents": ["devops-engineer.md", "release-manager.md", "sre.md"],
        "skills": [],
        "commands": ["deploy.md", "release.md"]
    },
    "Legal-Finance": {
        "agents": ["legal-counsel.md", "finops-manager.md"],
        "skills": ["legal-tos-privacy", "gdpr-compliance", "iso-42001-ai-governance", "saas-finops-optimization", "accounting", "legal-advisor", "finance-based-pricing-advisor", "open-source-license", "gdpr-ccpa-privacy-auditor", "contract-review", "contract-and-proposal-writer", "financial-analyst"],
        "commands": ["legal.md", "finops.md"]
    },
    "Knowledge": {
        "agents": ["obsidian-architect.md"],
        "skills": ["obsidian-cli", "obsidian-bases", "obsidian-markdown", "json-canvas", "defuddle"],
        "commands": []
    }
}

def move_assets():
    for dept, folders in MAPPING.items():
        print(f"Processing Department: {dept}")
        
        # Move Personas
        if "personas" in folders:
            for p in folders["personas"]:
                src = os.path.join(REPO_ROOT, "personas", p)
                if os.path.exists(src):
                    shutil.move(src, os.path.join(REPO_ROOT, dept, "personas", p))
        
        # Move Agents
        if "agents" in folders:
            for a in folders["agents"]:
                src = os.path.join(REPO_ROOT, "agents", a)
                if os.path.exists(src):
                    shutil.move(src, os.path.join(REPO_ROOT, dept, "agents", a))
        
        # Move Skills
        if "skills" in folders:
            for s in folders["skills"]:
                src = os.path.join(REPO_ROOT, "skills", s)
                if os.path.exists(src):
                    shutil.move(src, os.path.join(REPO_ROOT, dept, "skills", s))
        
        # Move Commands
        if "commands" in folders:
            for c in folders["commands"]:
                src = os.path.join(REPO_ROOT, "commands", c)
                if os.path.exists(src):
                    shutil.move(src, os.path.join(REPO_ROOT, dept, "commands", c))
        
        # Move Design
        if folders.get("design_folder"):
            design_src = os.path.join(REPO_ROOT, "design")
            for f in os.listdir(design_src):
                if f.endswith(".md"):
                    shutil.move(os.path.join(design_src, f), os.path.join(REPO_ROOT, dept, "design", f))

def generate_manifests():
    for dept in MAPPING.keys():
        # Plugin.json
        plugin = {
            "name": f"galyarder-{dept.lower()}",
            "description": f"{dept} Department for Galyarder Framework. Includes specialized agents, skills, and tools.",
            "version": "1.7.0",
            "author": {"name": "Galyarder Labs", "email": "hello@galyarderlabs.app"},
            "personas": "./personas/" if os.path.isdir(os.path.join(dept, "personas")) else None,
            "agents": "./agents/" if os.path.isdir(os.path.join(dept, "agents")) else None,
            "skills": "./skills/" if os.path.isdir(os.path.join(dept, "skills")) else None,
            "commands": "./commands/" if os.path.isdir(os.path.join(dept, "commands")) else None
        }
        # Clean null values
        plugin = {k: v for k, v in plugin.items() if v is not None}
        
        with open(os.path.join(dept, "plugin.json"), "w") as f:
            json.dump(plugin, f, indent=2)
            
        # Gemini-extension.json
        gemini = {
            "name": f"galyarder-{dept.lower()}",
            "description": f"{dept} Department for Galyarder Framework.",
            "version": "1.7.0",
            "personas": "./personas/" if os.path.isdir(os.path.join(dept, "personas")) else None,
            "agents": "./agents/" if os.path.isdir(os.path.join(dept, "agents")) else None,
            "skills": ["./skills/"] if os.path.isdir(os.path.join(dept, "skills")) else None,
            "commands": "./commands/" if os.path.isdir(os.path.join(dept, "commands")) else None
        }
        if dept == "Growth":
            if gemini["skills"]: gemini["skills"].append("./design/")
            else: gemini["skills"] = ["./design/"]
            
        gemini = {k: v for k, v in gemini.items() if v is not None}
        
        with open(os.path.join(dept, "gemini-extension.json"), "w") as f:
            json.dump(gemini, f, indent=2)

if __name__ == "__main__":
    move_assets()
    generate_manifests()
    print("Surgical Restructuring Complete.")
