//! Run one of the repo's scripts on behalf of a CLI command.
//!
//! This is the transitional layer: the CLI surface is Rust, while the
//! `deploy`, `smoke`, `convert` and `sync` implementations are still the
//! existing scripts. Each script is run as `bash <script> <args...>` (or
//! `python3 <script> <args...>` for `.py`), with inherited stdio and
//! environment, and the CLI exits with the script's exit code.

use std::path::Path;
use std::process::{Command, ExitCode};

/// Run `script` (a `.sh` via bash, a `.py` via python3) with `args`.
/// Returns the script's exit code (0 when it exits cleanly).
pub fn run_script(script: &Path, args: &[String]) -> ExitCode {
    let is_python = script.extension().is_some_and(|e| e == "py");
    let program = if is_python { "python3" } else { "bash" };

    match Command::new(program)
        .arg(script)
        .args(args)
        .stdin(std::process::Stdio::inherit())
        .stdout(std::process::Stdio::inherit())
        .stderr(std::process::Stdio::inherit())
        .status()
    {
        Ok(status) => ExitCode::from(status.code().unwrap_or(1) as u8),
        Err(e) => {
            eprintln!("forge: cannot run {program} '{}': {e}", script.display());
            ExitCode::from(2)
        }
    }
}
