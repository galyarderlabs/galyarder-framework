//! `forge`: the Forge Anything CLI, in Rust.
//!
//! Replaces `bin/forge.js`. Same interface, same help text, same exit codes:
//!
//! ```text
//! forge <command> [options]
//!
//! scaffold  Initialize a new Forge Anything project (native Rust)
//! deploy    Deploy agents to your IDE or global environment
//! smoke     Run system integrity checks
//! convert   Run conversion engine for different AI platforms
//! sync      Synchronize skills with your local environment
//! version   Show current Forge Anything version
//! help      Show this help message
//! ```
//!
//! `scaffold` runs the native Rust scaffold (`forge-scaffold`). The other
//! commands still run the repo's scripts (`scripts/install.sh`,
//! `scripts/smoke.sh`, `scripts/convert.sh`, `scripts/sync-codex-skills.py`)
//! with the arguments passed through, exactly as the JS CLI did, and the CLI
//! exits with the script's exit code. Reimplementing those in Rust is the
//! follow-up; the CLI surface is Rust now.
//!
//! The version comes from the source checkout's `package.json` (the same
//! file the JS CLI read), falling back to the crate version.

mod delegate;
mod version;

use forge_scaffold::{scaffold as rs_scaffold, source as rs_source};
use std::env;
use std::path::PathBuf;
use std::process::ExitCode;

fn main() -> ExitCode {
    match run() {
        Ok(code) => code,
        Err((code, message)) => {
            eprintln!("forge: {message}");
            ExitCode::from(code)
        }
    }
}

fn run() -> Result<ExitCode, (u8, String)> {
    let args: Vec<String> = env::args().skip(1).collect();
    let command = args.first().cloned();
    let rest: Vec<String> = args.iter().skip(1).cloned().collect();

    let command = match command {
        None => {
            print!("{}", help_text());
            return Ok(ExitCode::from(0));
        }
        Some(c) => c,
    };

    match command.as_str() {
        "help" | "--help" | "-h" => {
            print!("{}", help_text());
            Ok(ExitCode::from(0))
        }
        "version" | "--version" | "-v" => {
            println!("Forge Anything v{}", version::version());
            Ok(ExitCode::from(0))
        }
        "scaffold" => run_scaffold(&rest),
        "deploy" | "smoke" | "convert" | "sync" => run_script_command(&command, &rest),
        _ => {
            eprintln!("[ERR] Unknown command: {command}");
            print!("{}", help_text());
            Ok(ExitCode::from(1))
        }
    }
}

/// `forge scaffold [dir] [--name <name>] [--force] [--source <dir>]`.
/// No dir means the current directory, matching the JS CLI (which scaffolded
/// into the working directory). Unlike the JS CLI, a dir argument is honored
/// instead of ignored.
fn run_scaffold(args: &[String]) -> Result<ExitCode, (u8, String)> {
    let mut target: Option<PathBuf> = None;
    let mut source: Option<PathBuf> = None;
    let mut name = String::new();
    let mut force = false;

    let mut i = 0;
    while i < args.len() {
        let arg = &args[i];
        match arg.as_str() {
            "--help" | "-h" => {
                print!("{SCAFFOLD_HELP}");
                return Ok(ExitCode::from(0));
            }
            "--force" | "-f" => force = true,
            "--source" => {
                i += 1;
                source = Some(take_path(args, i, "--source")?);
            }
            "--name" => {
                i += 1;
                name = take_string(args, i, "--name")?;
            }
            _ if arg.starts_with("--source=") => {
                source = Some(PathBuf::from(arg.trim_start_matches("--source=")));
            }
            _ if arg.starts_with("--name=") => {
                name = arg.trim_start_matches("--name=").to_string();
            }
            _ if arg.starts_with('-') => {
                return Err((1, format!("scaffold: unknown option '{arg}' (see --help)")));
            }
            _ => {
                if target.is_some() {
                    return Err((
                        1,
                        "scaffold: expected at most one target directory".to_string(),
                    ));
                }
                target = Some(PathBuf::from(arg));
            }
        }
        i += 1;
    }

    // Default target: the current directory (absolute, so the project name
    // derives from the real directory name, not ".").
    let target = match target {
        Some(t) => t,
        None => {
            env::current_dir().map_err(|e| (2, format!("cannot read current directory: {e}")))?
        }
    };

    let src = rs_source::resolve(source.as_deref()).map_err(|e| (2, e))?;
    let summary = rs_scaffold::scaffold(&src, &target, &name, force).map_err(|e| (2, e))?;

    let display_name = if name.is_empty() {
        target
            .file_name()
            .map(|n| n.to_string_lossy().into_owned())
            .unwrap_or_else(|| "project".to_string())
    } else {
        name
    };
    println!(
        "scaffolded {display_name} into '{}': {} skills, {} agents, {} commands, \
         {} cursor rules, {} design specs, {} files total",
        target.display(),
        summary.skills,
        summary.agents,
        summary.commands,
        summary.cursor_rules,
        summary.design_specs,
        summary.files,
    );
    println!("source: {}", src.display());
    Ok(ExitCode::from(0))
}

/// `forge deploy|smoke|convert|sync [args...]`: run the repo's script.
fn run_script_command(command: &str, args: &[String]) -> Result<ExitCode, (u8, String)> {
    let script_name = match command {
        "deploy" => "install.sh",
        "smoke" => "smoke.sh",
        "convert" => "convert.sh",
        "sync" => "sync-codex-skills.py",
        _ => unreachable!("command already matched"),
    };
    let src = rs_source::resolve(None).map_err(|e| (2, e))?;
    let script = src.join("scripts").join(script_name);
    if !script.is_file() {
        return Err((2, format!("source is missing scripts/{script_name}")));
    }
    Ok(delegate::run_script(&script, args))
}

fn take_path(args: &[String], i: usize, flag: &str) -> Result<PathBuf, (u8, String)> {
    args.get(i)
        .map(PathBuf::from)
        .ok_or_else(|| (1, format!("{flag} needs a value")))
}

fn take_string(args: &[String], i: usize, flag: &str) -> Result<String, (u8, String)> {
    args.get(i)
        .cloned()
        .ok_or_else(|| (1, format!("{flag} needs a value")))
}

/// The help text, byte-identical to the JS CLI's output (including the
/// leading blank line and the trailing spaces).
fn help_text() -> String {
    let v = version::version();
    format!(
        "\nForge Anything CLI v{v}\n\
         Forge anything with AI agents.\n\
         \n\
         Usage:\n\
         \x20 forge <command> [options]\n\
         \n\
         Commands:\n\
         \x20 scaffold  Initialize a new Forge Anything project\n\
         \x20 deploy    Deploy agents to your IDE or global environment\n\
         \x20 smoke     Run system integrity checks\n\
         \x20 convert   Run conversion engine for different AI platforms\n\
         \x20 sync      Synchronize skills with your local environment\n\
         \x20 version   Show current Forge Anything version\n\
         \x20 help      Show this help message\n\
         \n\
         Examples:\n\
         \x20 forge scaffold\n\
         \x20 forge deploy --tool gemini\n\
         \x20 forge smoke\n\
         \x20   \n"
    )
}

const SCAFFOLD_HELP: &str = "forge scaffold: initialize a new Forge Anything project.\n\
     \n\
     Usage: forge scaffold [OPTIONS] [dir]\n\
     \n\
     Options:\n\
       --source <dir>   Forge Anything checkout to copy from\n\
                        (default: auto-detect; see FORGE_SOURCE)\n\
       --name <name>    Project name for the generated README\n\
                        (default: the target directory's name)\n\
       --force          Scaffold into a non-empty directory\n\
       --help           Show this help\n\
     \n\
     No dir means the current directory. The scaffolded repo gets the docs\n\
     structure, the 8 departments with their audit templates, the curated\n\
     skills and agents, all slash commands, and the host manifests.\n";
