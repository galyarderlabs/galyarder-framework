//! Parity tests for the Rust `forge` CLI against the JS CLI (`bin/forge.js`).
//!
//! The help text, version output, no-args behavior and unknown-command
//! handling must be byte-identical to the JS CLI. `scaffold` must produce a
//! ready repo through the CLI, and `smoke` must run the repo's smoke test.
//! The JS-comparison tests skip gracefully when `node` is not installed.

use std::fs;
use std::path::PathBuf;
use std::process::Command;

fn repo_root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("..")
        .join("..")
        .canonicalize()
        .expect("repo root resolves")
}

fn forge_bin() -> String {
    env!("CARGO_BIN_EXE_forge").to_string()
}

/// True when `node` runs (needed to compare against the JS CLI).
fn node_available() -> bool {
    Command::new("node")
        .arg("--version")
        .output()
        .map(|o| o.status.success())
        .unwrap_or(false)
}

fn run_forge(args: &[&str]) -> std::process::Output {
    Command::new(forge_bin())
        .args(args)
        .current_dir(repo_root())
        .output()
        .expect("run forge")
}

fn run_js(args: &[&str]) -> std::process::Output {
    Command::new("node")
        .arg(repo_root().join("bin/forge.js"))
        .args(args)
        .current_dir(repo_root())
        .output()
        .expect("run node bin/forge.js")
}

#[test]
fn help_is_byte_identical_to_js() {
    if !node_available() {
        eprintln!("node not available; skipping JS parity check");
        return;
    }
    let rust = run_forge(&["--help"]);
    let js = run_js(&["--help"]);
    assert!(rust.status.success());
    assert_eq!(
        rust.stdout, js.stdout,
        "help output differs from the JS CLI"
    );
    assert_eq!(rust.stderr, js.stderr);
}

#[test]
fn version_is_byte_identical_to_js() {
    if !node_available() {
        eprintln!("node not available; skipping JS parity check");
        return;
    }
    let rust = run_forge(&["--version"]);
    let js = run_js(&["--version"]);
    assert!(rust.status.success());
    assert_eq!(
        rust.stdout, js.stdout,
        "version output differs from the JS CLI"
    );
}

#[test]
fn no_args_shows_help() {
    let out = run_forge(&[]);
    assert!(out.status.success());
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.contains("Forge Anything CLI"));
    assert!(text.contains("forge <command> [options]"));
    for cmd in [
        "scaffold", "deploy", "smoke", "convert", "sync", "version", "help",
    ] {
        assert!(text.contains(cmd), "help lists {cmd}");
    }
}

#[test]
fn unknown_command_exits_1_with_error_and_help() {
    let out = run_forge(&["bogus"]);
    assert_eq!(out.status.code(), Some(1));
    let err = String::from_utf8_lossy(&out.stderr);
    assert!(err.contains("[ERR] Unknown command: bogus"));
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.contains("Forge Anything CLI"));
}

#[test]
fn scaffold_through_cli_produces_a_ready_repo() {
    let tmp = std::env::temp_dir().join(format!("forge-cli-e2e-{}", std::process::id()));
    let _ = fs::remove_dir_all(&tmp);
    let target = tmp.join("my-project");
    let out = Command::new(forge_bin())
        .arg("scaffold")
        .arg("--name")
        .arg("my-project")
        .arg(&target)
        .current_dir(repo_root())
        .output()
        .expect("run forge scaffold");
    assert!(
        out.status.success(),
        "forge scaffold failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    assert!(target.join("README.md").is_file());
    assert!(target.join("skills/forge/SKILL.md").is_file());
    assert!(target.join("agents/forge-ceo.md").is_file());
    assert!(target.join("commands/plan.md").is_file());
    assert!(
        target
            .join("docs/departments/Executive/README.md")
            .is_file()
    );
    assert_eq!(fs::read_dir(target.join("skills")).unwrap().count(), 38);
    assert_eq!(fs::read_dir(target.join("agents")).unwrap().count(), 18);
    assert_eq!(fs::read_dir(target.join("commands")).unwrap().count(), 25);
    let _ = fs::remove_dir_all(&tmp);
}

#[test]
fn smoke_through_cli_succeeds() {
    let out = run_forge(&["smoke"]);
    assert!(
        out.status.success(),
        "forge smoke failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.contains("SMOKE TEST PASSED"));
}
