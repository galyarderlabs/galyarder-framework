# Galyarder OS: Executive Operating Loops
# BOOTSTRAP: Load full company context
@AGENTS.md
@CLAUDE.md

## ⚙️ SYSTEM BOOTLOADER
- **Adapter**: @./skills/using-galyarder-framework/SKILL.md
- **Shield**: Use the `rtk` prefix for **true shell/bash commands only**.
- **Native Tools**: ALWAYS use native tools (`read_file`, `replace`).
- **Surgical Execution**: **DILARANG** menggunakan `rtk cat` atau `write_file` untuk mengedit file yang sudah ada. Gunakan `replace` untuk perubahan spesifik. Baca file secara bertahap menggunakan `start_line` dan `end_line` pada `read_file` untuk efisiensi context.

## 🌐 HOST-SPECIFIC REQUIREMENTS
### Antigravity (Google)
- **Sandbox**: Must be set to **OFF**. 
- **Reason**: Galyarder requires access to the `rtk` binary (Homebrew) and local symlinked workforce folders which are restricted by the sandbox environment.

## ⌨️ EXECUTIVE COMMANDS
- /analytics: Design tracking schemas and KPIs.
- /brainstorm: Socratic design refinement.
- /build-fix: Systematically fix build/type errors.
- /clean: Dead code cleanup and consolidation.
- /cro: Conversion Rate Optimization.
- /cybersecurity: Advanced offensive security audit.
- /deploy: Infrastructure and CI/CD automation.
- /docs: Documentation and codemap specialist.
- /e2e: Playwright user journey testing.
- /finops: Cloud cost and API optimization.
- /legal: TOS/Privacy and license audit.
- /linear: PRD to Linear ticket mapping.
- /marketing: Growth, SEO, and Copywriting.
- /plan: Vertical Slice (Tracer Bullet) planning.
- /release: SemVer and changelog management.
- /review: Principal-level code review.
- /seo: Technical SEO and Schema markup.
- /tdd: Strict Test-Driven Development.
- /triage: Root cause analysis and fix planning.
- /video: Remotion programmatic video.

## 📊 REPORTING STANDARDS
- **Linear**: Task status & issue tracking.
- **Obsidian**: Strategic memory & Department Reports.
