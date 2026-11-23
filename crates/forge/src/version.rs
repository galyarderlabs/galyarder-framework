//! The Forge Anything version the CLI reports.
//!
//! The source of truth is the `package.json` in the Forge Anything source
//! checkout (the same file the JS CLI read). The CLI resolves the source the
//! same way the scaffold does, and falls back to the crate version when no
//! `package.json` can be found, so `--help` and `--version` still work for a
//! standalone binary.

use forge_scaffold::source;
use std::env;
use std::fs;
use std::path::Path;

/// The version to report (e.g. "3.0.2").
pub fn version() -> String {
    // 1. The source checkout's package.json.
    if let Ok(src) = source::resolve(None) {
        if let Some(v) = read_package_version(&src.join("package.json")) {
            return v;
        }
    }

    // 2. Next to the executable (installed layouts).
    if let Ok(exe) = env::current_exe() {
        if let Some(exe_dir) = exe.parent() {
            for candidate in [
                exe_dir.join("../package.json"),
                exe_dir.join("../../package.json"),
            ] {
                if let Some(v) = read_package_version(&candidate) {
                    return v;
                }
            }
        }
    }

    // 3. Fallback: the crate version (kept in sync with package.json).
    env!("CARGO_PKG_VERSION").to_string()
}

/// Read the top-level `"version"` string from a package.json file.
/// Returns None when the file cannot be read or has no version string.
fn read_package_version(path: &Path) -> Option<String> {
    let text = fs::read_to_string(path).ok()?;
    extract_version(&text)
}

/// Extract the first `"version": "<string>"` value from JSON text.
/// The top-level version comes before any nested ones in a package.json.
fn extract_version(text: &str) -> Option<String> {
    let key = "\"version\"";
    let mut rest = text;
    loop {
        let at = rest.find(key)?;
        rest = &rest[at + key.len()..];
        // Skip whitespace, expect ':'.
        let after_colon = rest.trim_start().strip_prefix(':')?;
        // Skip whitespace, expect an opening quote.
        let after_quote = after_colon.trim_start().strip_prefix('"')?;
        // Read until the closing quote (versions are plain semver, no escapes).
        let end = after_quote.find('"')?;
        let value = &after_quote[..end];
        if !value.is_empty() {
            return Some(value.to_string());
        }
        // An empty version string is not the one we want; keep looking.
        rest = &after_quote[end + 1..];
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn extracts_a_plain_version() {
        let json = "{\n  \"name\": \"forge-anything\",\n  \"version\": \"3.0.2\",\n  \"license\": \"GPL-3.0-or-later\"\n}\n";
        assert_eq!(extract_version(json), Some("3.0.2".to_string()));
    }

    #[test]
    fn extracts_the_first_version_when_nested_ones_follow() {
        let json = "{\"version\": \"3.0.2\", \"dependencies\": {\"x\": {\"version\": \"1.0.0\"}}}";
        assert_eq!(extract_version(json), Some("3.0.2".to_string()));
    }

    #[test]
    fn returns_none_without_a_version() {
        assert_eq!(extract_version("{\"name\": \"x\"}"), None);
    }

    #[test]
    fn version_is_a_semver_shape() {
        let v = version();
        assert!(v.split('.').count() >= 2, "version: {v}");
    }
}
