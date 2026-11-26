//! `forge-scaffold`: drop a tidy Forge Anything repo into a folder.
//!
//! Usage:
//! ```text
//! forge-scaffold [OPTIONS] <target-dir>
//!
//! Options:
//!   --source <dir>   Forge Anything checkout to copy from
//!                      (default: auto-detect; see FORGE_SOURCE)
//!   --name <name>    Project name for the generated README
//!                      (default: the target directory's name)
//!   --force          Scaffold into a non-empty directory
//!   --help           Show this help
//!   --version        Show the version
//! ```
//!
//! The source is resolved in order: `--source`, `FORGE_SOURCE`, walking up
//! from the current directory, then next to the executable. A source checkout
//! contains `skills/using-forge-anything/SKILL.md` and `agents/forge-ceo/SOUL.md`.
//!
//! Exit codes: 0 on success, 1 on usage errors, 2 when the scaffold fails.

use forge_scaffold::{scaffold, source};
use std::env;
use std::path::PathBuf;
use std::process::ExitCode;

const VERSION: &str = env!("CARGO_PKG_VERSION");

fn main() -> ExitCode {
    match run() {
        Ok(()) => ExitCode::from(0),
        Err((code, message)) => {
            eprintln!("forge-scaffold: {message}");
            ExitCode::from(code)
        }
    }
}

fn run() -> Result<(), (u8, String)> {
    let args: Vec<String> = env::args().skip(1).collect();
    let mut target: Option<PathBuf> = None;
    let mut source: Option<PathBuf> = None;
    let mut name = String::new();
    let mut force = false;

    let mut i = 0;
    while i < args.len() {
        let arg = &args[i];
        match arg.as_str() {
            "--help" | "-h" => {
                print!("{HELP}");
                return Ok(());
            }
            "--version" | "-V" => {
                println!("forge-scaffold {VERSION}");
                return Ok(());
            }
            "--force" | "-f" => force = true,
            "--source" => {
                i += 1;
                source = Some(take_value(&args, i, "--source")?);
            }
            "--name" => {
                i += 1;
                name = take_value_string(&args, i, "--name")?;
            }
            _ if arg.starts_with("--source=") => {
                source = Some(PathBuf::from(arg.trim_start_matches("--source=")));
            }
            _ if arg.starts_with("--name=") => {
                name = arg.trim_start_matches("--name=").to_string();
            }
            _ if arg.starts_with('-') => {
                return Err((1, format!("unknown option '{arg}' (see --help)")));
            }
            _ => {
                if target.is_some() {
                    return Err((1, "expected exactly one target directory".to_string()));
                }
                target = Some(PathBuf::from(arg));
            }
        }
        i += 1;
    }

    let target = match target {
        Some(t) => t,
        None => return Err((1, "missing target directory (see --help)".to_string())),
    };

    let src = source::resolve(source.as_deref()).map_err(|e| (2, e))?;
    let summary = scaffold::scaffold(&src, &target, &name, force).map_err(|e| (2, e))?;

    println!(
        "scaffolded {} into '{}': {} skills, {} agents, {} commands, \
         {} design specs, {} files total",
        if name.is_empty() {
            target
                .file_name()
                .map(|n| n.to_string_lossy().into_owned())
                .unwrap_or_else(|| "project".to_string())
        } else {
            name
        },
        target.display(),
        summary.skills,
        summary.agents,
        summary.commands,
        summary.design_specs,
        summary.files,
    );
    println!("source: {}", src.display());
    Ok(())
}

fn take_value(args: &[String], i: usize, flag: &str) -> Result<PathBuf, (u8, String)> {
    args.get(i)
        .map(PathBuf::from)
        .ok_or_else(|| (1, format!("{flag} needs a value")))
}

fn take_value_string(args: &[String], i: usize, flag: &str) -> Result<String, (u8, String)> {
    args.get(i)
        .cloned()
        .ok_or_else(|| (1, format!("{flag} needs a value")))
}

const HELP: &str = "forge-scaffold: drop a tidy Forge Anything repo into a folder.\n\
     \n\
     Usage: forge-scaffold [OPTIONS] <target-dir>\n\
     \n\
     Options:\n\
       --source <dir>   Forge Anything checkout to copy from\n\
                        (default: auto-detect; see FORGE_SOURCE)\n\
       --name <name>    Project name for the generated README\n\
                        (default: the target directory's name)\n\
       --force          Scaffold into a non-empty directory\n\
       --help           Show this help\n\
       --version        Show the version\n\
     \n\
     The scaffolded repo gets the docs structure, the 17 departments with\n\
     their audit templates, the curated skills and agents, and all slash\n\
     commands. Any agent or host reads `skills/` and `agents/` straight\n\
     from the project folder.\n\
     \n\
     Source resolution: --source, FORGE_SOURCE, then walking up from the\n\
     current directory, then next to the executable. A source checkout\n\
     contains skills/using-forge-anything/SKILL.md and agents/forge-ceo/SOUL.md.\n";

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn help_text_mentions_target() {
        assert!(HELP.contains("<target-dir>"));
    }

    #[test]
    fn version_is_semver_like() {
        assert!(VERSION.split('.').count() >= 2);
    }
}
