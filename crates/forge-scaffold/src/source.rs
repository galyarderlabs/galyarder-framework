//! Where the scaffold's source material lives.
//!
//! The scaffold copies from a Forge Anything checkout (the repo that ships
//! `skills/`, `agents/`, `commands/`, `docs/templates/` and the host
//! manifests). It does not embed that content, so the binary stays small and
//! the scaffolded repo always matches the source it was built from.
//!
//! Resolution order:
//! 1. `--source <dir>` on the command line.
//! 2. `FORGE_SOURCE` environment variable.
//! 3. Walk up from the current directory looking for a checkout marker.
//! 4. Look next to the executable (`<exe-dir>/..` and `<exe-dir>/../..`).
//!
//! A directory counts as a source when it contains
//! `skills/using-forge-anything/SKILL.md` and `agents/forge-ceo.md`. If
//! nothing is found, the error tells the user exactly how to point the
//! scaffold at a source.

use std::env;
use std::path::{Path, PathBuf};

/// Marker files that identify a Forge Anything source checkout.
const MARKERS: &[&str] = &[
    "skills/using-forge-anything/SKILL.md",
    "agents/forge-ceo.md",
];

/// True when `dir` looks like a Forge Anything source checkout.
pub fn is_source(dir: &Path) -> bool {
    MARKERS.iter().all(|m| dir.join(m).is_file())
}

/// Resolve the source directory, or return a human-readable error.
pub fn resolve(explicit: Option<&Path>) -> Result<PathBuf, String> {
    // 1. Explicit --source.
    if let Some(dir) = explicit {
        let dir = absolutize(dir);
        if is_source(&dir) {
            return Ok(dir);
        }
        return Err(format!(
            "--source '{}' is not a Forge Anything checkout (missing {})",
            dir.display(),
            MARKERS.join(" and ")
        ));
    }

    // 2. FORGE_SOURCE env var.
    if let Ok(val) = env::var("FORGE_SOURCE") {
        if !val.trim().is_empty() {
            let dir = absolutize(Path::new(&val));
            if is_source(&dir) {
                return Ok(dir);
            }
            return Err(format!(
                "FORGE_SOURCE '{}' is not a Forge Anything checkout (missing {})",
                dir.display(),
                MARKERS.join(" and ")
            ));
        }
    }

    // 3. Walk up from the current directory.
    if let Ok(cwd) = env::current_dir() {
        let mut dir: Option<&Path> = Some(&cwd);
        while let Some(d) = dir {
            if is_source(d) {
                return Ok(d.to_path_buf());
            }
            dir = d.parent();
        }
    }

    // 4. Walk up from the executable's directory (installed layouts, and
    // binaries built inside a checkout, e.g. crates/forge/target/debug/).
    if let Ok(exe) = env::current_exe() {
        if let Some(exe_dir) = exe.parent() {
            let mut dir: Option<&Path> = Some(exe_dir);
            while let Some(d) = dir {
                if is_source(d) {
                    return Ok(d.to_path_buf());
                }
                dir = d.parent();
            }
        }
    }

    Err("could not find a Forge Anything source checkout.\n\
         Run this from inside a forge-anything checkout, pass --source <dir>, \
         or set FORGE_SOURCE to the checkout directory.\n\
         A source checkout contains skills/using-forge-anything/SKILL.md and agents/forge-ceo.md."
        .to_string())
}

/// Make a path absolute (relative to the current directory) without requiring
/// it to exist. Canonicalize when possible so the result is clean.
fn absolutize(path: &Path) -> PathBuf {
    if path.is_absolute() {
        return path.to_path_buf();
    }
    match env::current_dir() {
        Ok(cwd) => cwd.join(path),
        Err(_) => path.to_path_buf(),
    }
}
