//! The scaffold itself: drop a tidy Forge Anything repo into a folder.
//!
//! What lands in the target directory:
//! - `README.md`, `AGENTS.md`, `WORKFLOW.md`, `.gitignore`, `skills.json`
//! - `skills/<curated>/` — the curated skills, copied whole from the source
//! - `agents/<curated>.md` — the curated agents
//! - `commands/` — all slash commands
//! - `docs/` — specs, plans, reports, templates, design, and the 8
//!   departments with a README and an audit template each
//! - `.claude-plugin/marketplace.json`, `gemini-extension.json` — host
//!   manifests so Claude Code and Gemini discover `skills/` directly
//! - `.cursor/rules/<curated>.mdc` — Cursor rules for the curated skills
//!
//! Other hosts (Codex, OpenCode, Windsurf, KiloCode, Antigravity, OpenClaw,
//! Hermes) read `skills/` directly, so no separate copy is needed for them.
//! The full `integrations/` tree stays in the Forge Anything repo itself;
//! the scaffold ships only what a new project needs to work.

use crate::curated;
use std::fs;
use std::path::{Path, PathBuf};

/// How many things the scaffold wrote, for the final report.
#[derive(Debug, Default)]
pub struct Summary {
    pub skills: usize,
    pub agents: usize,
    pub commands: usize,
    pub cursor_rules: usize,
    pub design_specs: usize,
    pub files: usize,
}

impl Summary {
    fn note_file(&mut self) {
        self.files += 1;
    }
}

/// Scaffold `source` into `target`.
///
/// `target` must not exist, or must be empty, unless `force` is set.
/// `project_name` is used in the generated README; it defaults to the
/// target directory's file name when empty.
pub fn scaffold(
    source: &Path,
    target: &Path,
    project_name: &str,
    force: bool,
) -> Result<Summary, String> {
    // Refuse to clobber a non-empty directory unless forced.
    if target.exists() {
        if !target.is_dir() {
            return Err(format!(
                "target '{}' exists and is not a directory",
                target.display()
            ));
        }
        let non_empty = fs::read_dir(target)
            .map_err(|e| format!("cannot read target '{}': {e}", target.display()))?
            .next()
            .is_some();
        if non_empty && !force {
            return Err(format!(
                "target '{}' is not empty; pass --force to scaffold into it anyway",
                target.display()
            ));
        }
    } else {
        fs::create_dir_all(target)
            .map_err(|e| format!("cannot create target '{}': {e}", target.display()))?;
    }

    let mut s = Summary::default();
    let name = if project_name.is_empty() {
        target
            .file_name()
            .map(|n| n.to_string_lossy().into_owned())
            .unwrap_or_else(|| "my-project".to_string())
    } else {
        project_name.to_string()
    };

    // --- Top-level docs -------------------------------------------------
    copy_file(source.join("AGENTS.md"), target.join("AGENTS.md"), &mut s)?;
    copy_file(
        source.join("WORKFLOW.md"),
        target.join("WORKFLOW.md"),
        &mut s,
    )?;
    write_file(target.join("README.md"), &readme(&name), &mut s)?;
    write_file(target.join(".gitignore"), GITIGNORE, &mut s)?;
    write_file(target.join("skills.json"), &skills_manifest(), &mut s)?;

    // --- Curated skills -------------------------------------------------
    for skill in curated::CURATED_SKILLS {
        let src = source.join("skills").join(skill);
        let dst = target.join("skills").join(skill);
        if !src.join("SKILL.md").is_file() {
            return Err(format!("source is missing skills/{skill}/SKILL.md"));
        }
        copy_dir(&src, &dst, &mut s)?;
        s.skills += 1;
    }

    // --- Curated agents -------------------------------------------------
    for agent in curated::CURATED_AGENTS {
        let src = source.join("agents").join(format!("{agent}.md"));
        let dst = target.join("agents").join(format!("{agent}.md"));
        if !src.is_file() {
            return Err(format!("source is missing agents/{agent}.md"));
        }
        copy_file(src, dst, &mut s)?;
        s.agents += 1;
    }

    // --- All slash commands ---------------------------------------------
    let commands_src = source.join("commands");
    let commands_dst = target.join("commands");
    for entry in read_dir_sorted(&commands_src)? {
        let path = entry.path();
        if path.extension().is_some_and(|e| e == "md") {
            let name = entry.file_name().to_string_lossy().into_owned();
            copy_file(path, commands_dst.join(name), &mut s)?;
            s.commands += 1;
        }
    }

    // --- Docs structure --------------------------------------------------
    for d in ["specs", "plans", "reports", "templates", "design"] {
        fs::create_dir_all(target.join("docs").join(d))
            .map_err(|e| format!("cannot create docs/{d}: {e}"))?;
    }
    // Decision log template -> docs/reports/.
    let decision_log = source
        .join("docs/templates")
        .join(curated::DECISION_LOG_TEMPLATE);
    if decision_log.is_file() {
        copy_file(
            decision_log,
            target
                .join("docs/reports")
                .join(curated::DECISION_LOG_TEMPLATE),
            &mut s,
        )?;
    }
    // Design specs -> docs/design/.
    let design_src = source.join("docs/design");
    let design_dst = target.join("docs/design");
    if design_src.is_dir() {
        for entry in read_dir_sorted(&design_src)? {
            let name = entry.file_name().to_string_lossy().into_owned();
            if name.starts_with(curated::DESIGN_SPEC_PREFIX) && name.ends_with(".md") {
                copy_file(entry.path(), design_dst.join(&name), &mut s)?;
                s.design_specs += 1;
            }
        }
    }
    // Departments: README + audit template each.
    for dept in curated::DEPARTMENTS {
        let dept_dir = target.join("docs/departments").join(dept);
        fs::create_dir_all(&dept_dir)
            .map_err(|e| format!("cannot create docs/departments/{dept}: {e}"))?;
        write_file(dept_dir.join("README.md"), &department_readme(dept), &mut s)?;
        if let Some(template) = curated::audit_template_for(dept) {
            let src = source.join("docs/templates").join(template);
            if src.is_file() {
                copy_file(src, dept_dir.join(template), &mut s)?;
            }
        }
    }

    // --- Host integrations ----------------------------------------------
    // Claude Code + Gemini manifests point at ./skills/, ./agents/ and
    // ./commands/, which the scaffold just created, so copy them as-is.
    copy_file(
        source.join(".claude-plugin/marketplace.json"),
        target.join(".claude-plugin/marketplace.json"),
        &mut s,
    )?;
    copy_file(
        source.join("gemini-extension.json"),
        target.join("gemini-extension.json"),
        &mut s,
    )?;
    // Cursor reads .mdc rules; copy the curated skills' rules.
    let cursor_src = source.join(".cursor/rules");
    let cursor_dst = target.join(".cursor/rules");
    if cursor_src.is_dir() {
        for skill in curated::CURATED_SKILLS {
            let src = cursor_src.join(format!("{skill}.mdc"));
            if src.is_file() {
                copy_file(src, cursor_dst.join(format!("{skill}.mdc")), &mut s)?;
                s.cursor_rules += 1;
            }
        }
    }

    Ok(s)
}

/// The generated README for a scaffolded repo.
fn readme(project_name: &str) -> String {
    format!(
        "# {project_name}\n\
         \n\
         A Forge Anything project: an AI agent already knows the rules, the\n\
         workflow, and where to put its work.\n\
         \n\
         ## Structure\n\
         \n\
         - `skills/` — the curated Forge Anything skills (reusable AI-agent\n\
         rules). `forge` is the entry point; the rest cover the core loop\n\
         (plan, build, verify, ship) and the eight departments.\n\
         - `agents/` — the Forge agents plus the lead role agent per\n\
         department.\n\
         - `commands/` — slash commands (`/plan`, `/docs`, `/release`, ...).\n\
         - `docs/` — specs, plans, reports, templates, design, and\n\
         `docs/departments/` (one folder per department, with its audit\n\
         template).\n\
         - `AGENTS.md` — the operating rules. `WORKFLOW.md` — the workflow.\n\
         - `skills.json` — the manifest of the skills in this repo.\n\
         \n\
         ## Hosts\n\
         \n\
         Claude Code and Gemini discover `skills/` through\n\
         `.claude-plugin/marketplace.json` and `gemini-extension.json`. Cursor\n\
         uses `.cursor/rules/`. Codex, OpenCode, Windsurf and the other hosts\n\
         read `skills/` directly.\n\
         \n\
         ## Working here\n\
         \n\
         Read `AGENTS.md` first. Turn intent into a plan, then into work in\n\
         `docs/`. Verify before claiming anything is done.\n\
         \n\
         Copyright 2026 Galyarder Labs. Forge Anything.\n"
    )
}

/// The generated README for one department folder.
fn department_readme(department: &str) -> String {
    format!(
        "# Department: {department}\n\
         This directory contains persistent reports and strategic memory for the {department} department.\n\
         ---\n\
         Copyright 2026 Galyarder Labs. Forge Anything.\n"
    )
}

/// The generated `skills.json`: skill name -> `skills/<name>/SKILL.md`.
fn skills_manifest() -> String {
    let mut out = String::from("{\n");
    let mut first = true;
    for skill in curated::CURATED_SKILLS {
        if !first {
            out.push_str(",\n");
        }
        first = false;
        out.push_str(&format!("  \"{skill}\": \"skills/{skill}/SKILL.md\""));
    }
    out.push_str("\n}\n");
    out
}

/// Sensible default `.gitignore` for a scaffolded project.
const GITIGNORE: &str = "node_modules/\ntarget/\n.DS_Store\n*.log\n.env\n";

/// Copy one file, creating parent directories. Counts it in the summary.
fn copy_file(src: PathBuf, dst: PathBuf, s: &mut Summary) -> Result<(), String> {
    if let Some(parent) = dst.parent() {
        fs::create_dir_all(parent)
            .map_err(|e| format!("cannot create '{}': {e}", parent.display()))?;
    }
    fs::copy(&src, &dst).map_err(|e| {
        format!(
            "cannot copy '{}' -> '{}': {e}",
            src.display(),
            dst.display()
        )
    })?;
    s.note_file();
    Ok(())
}

/// Write one generated file, creating parent directories.
fn write_file(dst: PathBuf, contents: &str, s: &mut Summary) -> Result<(), String> {
    if let Some(parent) = dst.parent() {
        fs::create_dir_all(parent)
            .map_err(|e| format!("cannot create '{}': {e}", parent.display()))?;
    }
    fs::write(&dst, contents).map_err(|e| format!("cannot write '{}': {e}", dst.display()))?;
    s.note_file();
    Ok(())
}

/// Copy a directory tree (files only, following symlinks), with a depth cap
/// so a symlink loop cannot recurse forever.
fn copy_dir(src: &Path, dst: &Path, s: &mut Summary) -> Result<(), String> {
    copy_dir_depth(src, dst, s, 0)
}

fn copy_dir_depth(src: &Path, dst: &Path, s: &mut Summary, depth: usize) -> Result<(), String> {
    if depth > 12 {
        return Err(format!("directory tree too deep at '{}'", src.display()));
    }
    fs::create_dir_all(dst).map_err(|e| format!("cannot create '{}': {e}", dst.display()))?;
    for entry in read_dir_sorted(src)? {
        let path = entry.path();
        let name = entry.file_name().to_string_lossy().into_owned();
        let target = dst.join(&name);
        if path.is_dir() {
            copy_dir_depth(&path, &target, s, depth + 1)?;
        } else if path.is_file() {
            copy_file(path, target, s)?;
        }
        // Anything else (sockets, devices) is skipped deliberately.
    }
    Ok(())
}

/// Directory entries in sorted order, so the scaffold is deterministic.
fn read_dir_sorted(dir: &Path) -> Result<Vec<fs::DirEntry>, String> {
    let mut entries: Vec<fs::DirEntry> = fs::read_dir(dir)
        .map_err(|e| format!("cannot read '{}': {e}", dir.display()))?
        .collect::<Result<_, _>>()
        .map_err(|e| format!("cannot read '{}': {e}", dir.display()))?;
    entries.sort_by_key(|e| e.file_name());
    Ok(entries)
}
