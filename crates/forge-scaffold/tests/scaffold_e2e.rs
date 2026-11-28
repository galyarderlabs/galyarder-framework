//! End-to-end acceptance test for the scaffold (issue #212).
//!
//! Runs the built `forge-scaffold` binary into an empty temp dir, using the
//! repo checkout as `--source`, and asserts the result is a ready repo:
//! the structure, the docs, the curated skills + agents and the commands,
//! with no manual copying afterwards. Any agent or host reads `skills/` and
//! `agents/` straight from the project folder, so there are no per-host
//! copies or manifests to assert.

use forge_scaffold::curated;
use std::fs;
use std::path::{Path, PathBuf};
use std::process::Command;

/// The repo checkout, derived from the crate's manifest dir.
fn repo_root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("..")
        .join("..")
        .canonicalize()
        .expect("repo root resolves")
}

/// A unique temp dir for this test run; removed when the guard drops.
struct TempDir {
    path: PathBuf,
}

impl TempDir {
    fn new(tag: &str) -> Self {
        let path =
            std::env::temp_dir().join(format!("forge-scaffold-e2e-{}-{}", std::process::id(), tag));
        let _ = fs::remove_dir_all(&path);
        fs::create_dir_all(&path).expect("create temp dir");
        Self { path }
    }
}

impl Drop for TempDir {
    fn drop(&mut self) {
        let _ = fs::remove_dir_all(&self.path);
    }
}

fn run_scaffold(source: &Path, target: &Path) -> std::process::Output {
    let bin = env!("CARGO_BIN_EXE_forge-scaffold");
    Command::new(bin)
        .arg("--source")
        .arg(source)
        .arg("--name")
        .arg("test-project")
        .arg(target)
        .output()
        .expect("run forge-scaffold")
}

fn assert_file(path: &Path) {
    assert!(path.is_file(), "expected file to exist: {}", path.display());
}

fn assert_dir(path: &Path) {
    assert!(
        path.is_dir(),
        "expected directory to exist: {}",
        path.display()
    );
}

/// Recursively collect every file under `dir`.
fn all_files(dir: &Path, out: &mut Vec<PathBuf>) {
    for entry in fs::read_dir(dir).expect("read dir") {
        let entry = entry.expect("dir entry");
        let path = entry.path();
        if path.is_dir() {
            all_files(&path, out);
        } else if path.is_file() {
            out.push(path);
        }
    }
}

#[test]
fn scaffold_produces_a_ready_repo() {
    let source = repo_root();
    assert!(
        source
            .join("skills/using-forge-anything/SKILL.md")
            .is_file(),
        "source checkout has the using-forge-anything skill"
    );
    let tmp = TempDir::new("ready");
    let target = tmp.path.join("my-project");

    let out = run_scaffold(&source, &target);
    assert!(
        out.status.success(),
        "scaffold failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    let stdout = String::from_utf8_lossy(&out.stdout);
    assert!(
        stdout.contains("scaffolded test-project"),
        "stdout: {stdout}"
    );

    // Top-level docs.
    assert_file(&target.join("README.md"));
    assert_file(&target.join("AGENTS.md"));
    assert_file(&target.join("WORKFLOW.md"));
    assert_file(&target.join(".gitignore"));
    assert_file(&target.join("skills.json"));

    // Curated skills, whole directories with their SKILL.md.
    for skill in curated::CURATED_SKILLS {
        assert_file(&target.join("skills").join(skill).join("SKILL.md"));
    }

    // Curated agents.
    for agent in curated::CURATED_AGENTS {
        assert_file(&target.join("agents").join(agent).join("SOUL.md"));
    }

    // All slash commands.
    let commands: Vec<_> = fs::read_dir(target.join("commands"))
        .expect("read commands")
        .collect();
    assert_eq!(commands.len(), 31, "all 31 commands copied");

    // Docs structure + departments.
    for d in ["specs", "plans", "reports", "templates", "design"] {
        assert_dir(&target.join("docs").join(d));
    }
    for dept in curated::DEPARTMENTS {
        let dept_dir = target.join("docs/departments").join(dept);
        assert_file(&dept_dir.join("README.md"));
        if let Some(template) = curated::audit_template_for(dept) {
            assert_file(&dept_dir.join(template));
        }
    }
    assert_file(
        &target
            .join("docs/reports")
            .join(curated::DECISION_LOG_TEMPLATE),
    );
    // At least one design spec seeded.
    let design_specs: Vec<_> = fs::read_dir(target.join("docs/design"))
        .expect("read design")
        .collect();
    assert!(!design_specs.is_empty(), "design specs seeded");

    // No per-host copies or manifests: skills/ and agents/ are read
    // straight from the project folder.
    assert!(
        !target.join(".claude-plugin").exists(),
        "no host manifest is scaffolded"
    );
    assert!(
        !target.join(".cursor").exists(),
        "no Cursor rules are scaffolded"
    );
    assert!(
        !target.join("gemini-extension.json").exists(),
        "no host manifest is scaffolded"
    );

    // The scaffolded README names the project and points at the rules.
    let readme = fs::read_to_string(target.join("README.md")).expect("read README");
    assert!(readme.contains("# test-project"));
    assert!(readme.contains("AGENTS.md"));

    // skills.json is a manifest of exactly the curated skills.
    let manifest = fs::read_to_string(target.join("skills.json")).expect("read skills.json");
    for skill in curated::CURATED_SKILLS {
        assert!(
            manifest.contains(&format!("\"{skill}\": \"skills/{skill}/SKILL.md\"")),
            "skills.json lists {skill}"
        );
    }

    // No "Galyarder Framework" product name anywhere in the output.
    // (The company name "Galyarder Labs" is fine and expected in footers.)
    let mut files = Vec::new();
    all_files(&target, &mut files);
    assert!(!files.is_empty());
    for file in files {
        let contents = fs::read_to_string(&file).unwrap_or_default();
        let lower = contents.to_lowercase();
        assert!(
            !lower.contains("galyarder framework") && !lower.contains("galyarder-framework"),
            "scaffolded file {} still names the old product",
            file.display()
        );
    }
}

#[test]
fn scaffold_refuses_a_nonempty_target_without_force() {
    let source = repo_root();
    let tmp = TempDir::new("nonempty");
    let target = tmp.path.join("existing");
    fs::create_dir_all(&target).expect("create target");
    fs::write(target.join("keep.txt"), "do not clobber").expect("write keep.txt");

    let bin = env!("CARGO_BIN_EXE_forge-scaffold");
    let out = Command::new(bin)
        .arg("--source")
        .arg(&source)
        .arg(&target)
        .output()
        .expect("run forge-scaffold");
    assert!(!out.status.success(), "should refuse a non-empty target");
    assert!(target.join("keep.txt").is_file(), "existing file untouched");

    // --force scaffolds into it.
    let out = Command::new(bin)
        .arg("--source")
        .arg(&source)
        .arg("--force")
        .arg(&target)
        .output()
        .expect("run forge-scaffold --force");
    assert!(
        out.status.success(),
        "--force should succeed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    assert!(target.join("README.md").is_file());
    assert!(target.join("keep.txt").is_file(), "existing file kept");
}

#[test]
fn curated_lists_all_exist_in_source() {
    let source = repo_root();
    for skill in curated::CURATED_SKILLS {
        assert!(
            source.join("skills").join(skill).join("SKILL.md").is_file(),
            "curated skill missing from source: {skill}"
        );
    }
    for agent in curated::CURATED_AGENTS {
        assert!(
            source.join("agents").join(agent).join("SOUL.md").is_file(),
            "curated agent missing from source: {agent}"
        );
    }
    for dept in curated::DEPARTMENTS {
        let template = curated::audit_template_for(dept)
            .unwrap_or_else(|| panic!("no audit template for {dept}"));
        assert!(
            source.join("docs/templates").join(template).is_file(),
            "audit template missing from source: {template}"
        );
    }
}
