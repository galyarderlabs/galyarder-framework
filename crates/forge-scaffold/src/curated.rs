//! The curated set: what the scaffold copies into a new repo.
//!
//! Criteria (see issue #212):
//! - Reusable as an AI-agent rule (a real SKILL.md with clear instructions).
//! - Covers the Forge Anything loop: goal -> plan -> build -> verify -> ship.
//! - Covers each of the 17 departments, so the scaffolded repo works for any
//!   department out of the box.
//! - Broadly useful, not niche. The ultra-specialized offensive / threat-intel
//!   security skills (red team, malware reversing, darkweb monitoring) and the
//!   narrow CRO tactics stay in the full repo; the scaffold carries the
//!   defensive and compliance basics instead (cloud security, GDPR, licensing).
//! - The department bundle skills (engineering, executive, ...) are NOT
//!   copied: they aggregate the individual skills, and the scaffold ships
//!   the individual skills directly. The one bundle kept is `forge`,
//!   the Forge Anything entry point.
//!
//! This list is data, not law. To change what the scaffold ships, edit the
//! lists below; the tests assert every entry exists in the source repo.

/// Curated skills, copied from `<source>/skills/<name>/` into the new repo.
/// 33 skills: the Forge entry points, the core loop, and 1-6 per department.
pub const CURATED_SKILLS: &[&str] = &[
    // Core: the Forge Anything loop itself.
    "forge",
    "using-forge-anything",
    "writing-plans",
    "executing-plans",
    "verification-before-completion",
    "subagent-driven-development",
    "brainstorming",
    "company-creator",
    "writing-skills",
    "doc-maintenance",
    // Founder Office / Capital.
    "founder-context",
    "pitch-deck",
    "investor-research",
    // Product.
    "prd-flow",
    "ubiquitous-language",
    // Engineering.
    "test-driven-development",
    "systematic-debugging",
    "adversarial-review",
    "finishing-a-development-branch",
    "release",
    "create-agent-adapter",
    // Growth.
    "seo-audit",
    "marketing-core",
    "analytics-tracking",
    // Security: defensive / compliance basics only.
    "cloud-security",
    "gdpr-compliance",
    "open-source-license",
    // Finance.
    "accounting-core",
    // Legal.
    "contract-review",
    "legal-tos-privacy",
    // Knowledge / Documentation.
    "obsidian-markdown",
    "obsidian-cli",
    "defuddle",
];

/// Curated agents, copied from `<source>/agents/<name>.md` into the new repo.
/// The five Forge agents plus the lead role agent(s) per department.
pub const CURATED_AGENTS: &[&str] = &[
    // Forge core agents.
    "forge-ceo",
    "forge-cfo-coo",
    "forge-cmo",
    "forge-cto",
    "forge-specialist",
    // Founder Office.
    "fundraising-operator",
    // Product.
    "product-manager",
    "planner",
    // Engineering.
    "elite-developer",
    "super-architect",
    // Growth.
    "growth-strategist",
    // Security.
    "security-guardian",
    // Infrastructure / Operations.
    "devops-engineer",
    "release-manager",
    // Finance.
    "finops-manager",
    // Legal.
    "legal-counsel",
    // Knowledge / Documentation.
    "doc-updater",
    "obsidian-architect",
];

/// The 17 departments, in the order the shell scaffold used.
pub const DEPARTMENTS: &[&str] = &[
    "Executive",
    "Product",
    "Engineering",
    "Creative",
    "Growth",
    "Security",
    "Infrastructure",
    "Finance",
    "Legal",
    "Knowledge",
    "Operations",
    "Customer Success",
    "People",
    "Data",
    "Trading",
    "External Relations",
    "Life",
];

/// Which audit template seeds each department, from `<source>/docs/templates/`.
/// Mirrors the shell scaffold's name-pattern mapping, made explicit.
pub fn audit_template_for(department: &str) -> Option<&'static str> {
    match department {
        "Executive" => Some("Forge-Anything Executive Audit.md"),
        "Product" => Some("Forge-Anything Product Audit.md"),
        "Engineering" => Some("Forge-Anything Engineering Audit.md"),
        "Creative" => Some("Forge-Anything Creative Audit.md"),
        "Growth" => Some("Forge-Anything Growth Audit.md"),
        "Security" => Some("Forge-Anything Security Audit.md"),
        "Infrastructure" => Some("Forge-Anything Infrastructure Audit.md"),
        "Finance" => Some("Forge-Anything Finance Audit.md"),
        "Legal" => Some("Forge-Anything Legal Audit.md"),
        "Knowledge" => Some("Forge-Anything Knowledge Audit.md"),
        "Operations" => Some("Forge-Anything Operations Audit.md"),
        "Customer Success" => Some("Forge-Anything Customer Success Audit.md"),
        "People" => Some("Forge-Anything People Audit.md"),
        "Data" => Some("Forge-Anything Data Audit.md"),
        "Trading" => Some("Forge-Anything Trading Audit.md"),
        "External Relations" => Some("Forge-Anything External Relations Audit.md"),
        "Life" => Some("Forge-Anything Life Audit.md"),
        _ => None,
    }
}

/// Report template seeded into `docs/reports/`.
pub const DECISION_LOG_TEMPLATE: &str = "Forge-Anything Decision Log Template.md";

/// Design specs are seeded by filename prefix, from `<source>/docs/design/`.
pub const DESIGN_SPEC_PREFIX: &str = "design-md-";
