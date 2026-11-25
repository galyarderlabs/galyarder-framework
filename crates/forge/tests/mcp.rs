//! End-to-end tests for the `forge mcp` stdio server.
//!
//! Drives the real binary over stdin/stdout with a full MCP session:
//! initialize, tools/list, tools/call for every tool, ping, an unknown
//! method, and a notification. Asserts on the JSON-RPC shapes and on the
//! actual skill content returned (read_skill `using-forge-anything` must
//! return that skill's real SKILL.md text).

use std::fs;
use std::io::{BufRead, BufReader, Write};
use std::path::PathBuf;
use std::process::{Command, Stdio};

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

/// Run one MCP session: write each request line, close stdin, collect the
/// response lines (one JSON object per line).
fn run_session(requests: &[&str]) -> Vec<String> {
    let mut child = Command::new(forge_bin())
        .arg("mcp")
        .current_dir(repo_root())
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .expect("spawn forge mcp");
    {
        let mut stdin = child.stdin.take().expect("child stdin");
        for req in requests {
            writeln!(stdin, "{req}").expect("write request");
        }
    }
    let stdout = child.stdout.take().expect("child stdout");
    let lines: Vec<String> = BufReader::new(stdout)
        .lines()
        .map(|l| l.expect("read response line"))
        .collect();
    let status = child.wait().expect("wait for forge mcp");
    assert!(status.success(), "forge mcp must exit 0 on stdin EOF");
    lines
}

fn tool_call(id: u32, name: &str, args: &str) -> String {
    format!(
        "{{\"jsonrpc\":\"2.0\",\"id\":{id},\"method\":\"tools/call\",\"params\":{{\"name\":\"{name}\",\"arguments\":{args}}}}}"
    )
}

#[test]
fn mcp_session_answers_initialize_list_and_calls() {
    let scaffold_tmp = std::env::temp_dir().join(format!("forge-mcp-e2e-{}", std::process::id()));
    let _ = fs::remove_dir_all(&scaffold_tmp);
    let target = scaffold_tmp.join("scaffolded");
    let target_json = target.to_string_lossy().replace('\\', "\\\\");

    let requests = vec![
        "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"initialize\",\"params\":{\"protocolVersion\":\"2025-06-18\",\"capabilities\":{},\"clientInfo\":{\"name\":\"test\",\"version\":\"0\"}}}".to_string(),
        "{\"jsonrpc\":\"2.0\",\"method\":\"notifications/initialized\"}".to_string(),
        "{\"jsonrpc\":\"2.0\",\"id\":2,\"method\":\"tools/list\"}".to_string(),
        tool_call(3, "list_skills", "{}"),
        tool_call(4, "read_skill", "{\"name\":\"using-forge-anything\"}"),
        tool_call(5, "read_skill", "{\"name\":\"no-such-skill\"}"),
        tool_call(6, "read_agent", "{\"name\":\"forge-ceo\"}"),
        tool_call(7, "read_command", "{\"name\":\"plan\"}"),
        tool_call(8, "scaffold", &format!("{{\"target\":\"{target_json}\",\"name\":\"mcp-probe\"}}")),
        "{\"jsonrpc\":\"2.0\",\"id\":9,\"method\":\"ping\"}".to_string(),
        "{\"jsonrpc\":\"2.0\",\"id\":10,\"method\":\"bogus/method\"}".to_string(),
    ];
    let req_refs: Vec<&str> = requests.iter().map(String::as_str).collect();
    let lines = run_session(&req_refs);

    // The notification gets no reply: 11 requests -> 10 responses.
    assert_eq!(
        lines.len(),
        10,
        "one response per request except the notification"
    );

    // initialize: serverInfo + protocol version + tools capability.
    assert!(lines[0].contains("\"id\":1"), "init id: {}", lines[0]);
    assert!(
        lines[0].contains("\"name\":\"forge-anything\""),
        "init serverInfo: {}",
        lines[0]
    );
    assert!(
        lines[0].contains("\"protocolVersion\":\"2025-06-18\""),
        "init protocol: {}",
        lines[0]
    );
    assert!(
        lines[0].contains("\"tools\":{}"),
        "init tools capability: {}",
        lines[0]
    );

    // tools/list: all five tools.
    for tool in [
        "list_skills",
        "read_skill",
        "read_agent",
        "read_command",
        "scaffold",
    ] {
        assert!(
            lines[1].contains(&format!("\"name\":\"{tool}\"")),
            "tools/list has {tool}: {}",
            lines[1]
        );
    }

    // list_skills: the real skill inventory (175 skills, incl.
    // using-forge-anything). The inner JSON array is a text string, so it
    // arrives backslash-escaped.
    assert!(
        lines[2].contains("\\\"name\\\":\\\"using-forge-anything\\\""),
        "list_skills has using-forge-anything: {}",
        &lines[2][..300]
    );
    assert!(
        lines[2].contains("Use when starting any conversation"),
        "list_skills description: {}",
        lines[2]
    );

    // read_skill using-forge-anything: the skill's actual SKILL.md text, not a summary.
    let skill_md = fs::read_to_string(repo_root().join("skills/using-forge-anything/SKILL.md"))
        .expect("read using-forge-anything SKILL.md");
    let first_line = skill_md.lines().nth(4).unwrap_or("").trim();
    assert!(
        !first_line.is_empty(),
        "using-forge-anything SKILL.md has content past the frontmatter"
    );
    assert!(
        lines[3].contains(first_line),
        "read_skill returns SKILL.md: {}",
        &lines[3][..200.min(lines[3].len())]
    );
    assert!(
        lines[3].contains("\"isError\":false"),
        "read_skill succeeds: {}",
        &lines[3][..200.min(lines[3].len())]
    );

    // read_skill for a missing skill: a clear tool error, not a crash.
    assert!(
        lines[4].contains("\"isError\":true"),
        "missing skill isError: {}",
        lines[4]
    );
    assert!(
        lines[4].contains("skill 'no-such-skill' not found"),
        "missing skill message: {}",
        lines[4]
    );

    // read_agent / read_command return the real file contents.
    assert!(
        lines[5].contains("forge-ceo"),
        "read_agent content: {}",
        &lines[5][..200.min(lines[5].len())]
    );
    assert!(
        lines[5].contains("Chief Executive Officer"),
        "read_agent description: {}",
        &lines[5][..300.min(lines[5].len())]
    );
    assert!(
        lines[6].contains("Restate requirements"),
        "read_command content: {}",
        &lines[6][..300.min(lines[6].len())]
    );

    // scaffold via the MCP tool produced a ready repo (library path, no subprocess).
    assert!(
        lines[7].contains("\"isError\":false"),
        "scaffold succeeds: {}",
        lines[7]
    );
    assert!(
        target
            .join("skills/using-forge-anything/SKILL.md")
            .is_file(),
        "scaffolded skills land"
    );
    assert!(
        target.join("agents/forge-ceo.md").is_file(),
        "scaffolded agents land"
    );
    assert!(
        target.join("commands/plan.md").is_file(),
        "scaffolded commands land"
    );

    // ping answers with an empty result; unknown method is -32601.
    assert!(lines[8].contains("\"id\":9"), "ping id: {}", lines[8]);
    assert!(
        lines[8].contains("\"result\":{}"),
        "ping result: {}",
        lines[8]
    );
    assert!(
        lines[9].contains("\"code\":-32601"),
        "unknown method code: {}",
        lines[9]
    );
    assert!(
        lines[9].contains("method not found"),
        "unknown method message: {}",
        lines[9]
    );

    let _ = fs::remove_dir_all(&scaffold_tmp);
}

#[test]
fn mcp_without_a_source_reports_it_instead_of_crashing() {
    // A temp dir with no checkout markers, pinned via FORGE_SOURCE: the
    // server still answers initialize, and tools report the missing source
    // clearly. (FORGE_SOURCE to a non-source dir makes resolve() fail, so
    // the exe-dir walk-up is not consulted — that is the scaffold's own
    // resolution rule, reused here.)
    let empty = std::env::temp_dir().join(format!("forge-mcp-nosrc-{}", std::process::id()));
    let _ = fs::remove_dir_all(&empty);
    fs::create_dir_all(&empty).expect("make empty dir");
    let mut child = Command::new(forge_bin())
        .arg("mcp")
        .current_dir(&empty)
        .env("FORGE_SOURCE", &empty)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .expect("spawn forge mcp");
    {
        let mut stdin = child.stdin.take().expect("child stdin");
        writeln!(
            stdin,
            "{{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"initialize\",\"params\":{{}}}}"
        )
        .expect("write init");
        writeln!(stdin, "{}", tool_call(2, "list_skills", "{}")).expect("write list_skills");
    }
    let stdout = child.stdout.take().expect("child stdout");
    let lines: Vec<String> = BufReader::new(stdout)
        .lines()
        .map(|l| l.expect("read response line"))
        .collect();
    let status = child.wait().expect("wait for forge mcp");
    assert!(status.success(), "server exits 0 even without a source");
    assert_eq!(lines.len(), 2, "both requests answered");
    assert!(
        lines[0].contains("\"name\":\"forge-anything\""),
        "init still works: {}",
        lines[0]
    );
    assert!(
        lines[1].contains("\"isError\":true"),
        "list_skills errors: {}",
        lines[1]
    );
    assert!(
        lines[1].contains("no Forge Anything source checkout found"),
        "missing-source message: {}",
        lines[1]
    );
    let _ = fs::remove_dir_all(&empty);
}

#[test]
fn mcp_help_lists_the_server() {
    let out = Command::new(forge_bin())
        .args(["mcp", "--help"])
        .current_dir(repo_root())
        .output()
        .expect("run forge mcp --help");
    assert!(out.status.success());
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.contains("forge mcp"));
    assert!(text.contains("list_skills"));
}
