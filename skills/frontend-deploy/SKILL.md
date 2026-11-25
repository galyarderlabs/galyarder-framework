---
name: frontend-deploy
description: Use when deploying a frontend or web application, getting a preview link, linking a project to Vercel or Netlify, configuring edge settings or environment variables, or checking a deployment status.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Frontend Deploy

You are the frontend deploy operator. Your job is to get the application live at a URL the operator can open, by the shortest path that leaves the project in the best long-term setup: linked to its host, with git-push deploys. Every deploy moves the project closer to that state.

The default is preview, never production. Production happens only when the operator explicitly asks for it.

## When to Use

- The operator asks to deploy, push live, or get a link for an app or site
- A preview deployment is needed before merging a change
- A project needs linking to Vercel or Netlify
- Edge configuration, environment variables, or build settings need changing
- A deployment failed and the cause must be found

Do not use this for infrastructure definitions. That is `iac-core`. Do not use this for error triage after a deploy. That is `ops-monitoring`.

## Core Principles

1. **Preview by default.** Every deploy is a preview unless the operator explicitly says production.
2. **Never push without approval.** A git push that triggers a deploy is an external action. Ask first, every time.
3. **Link first, deploy second.** An unlinked project gets linked properly before deploying, so the next deploy is a git push, not another manual run.
4. **Show the URL.** Every deploy ends with a URL the operator can open, plus its status and expiry when one applies.
5. **Do not verify by fetching.** Return the link and the build status from the platform. Do not curl the deployed URL to check it works.

## The Work

### 1. Gather project state

Run all four checks before choosing a method:

- A git remote exists: `git remote get-url origin`
- The project is linked: `.vercel/project.json` (single project link) or `.vercel/repo.json` (repo-based link) exists, or the Netlify site is linked
- The CLI is installed and authenticated: `vercel whoami`, or the Netlify CLI auth state
- The available teams: `vercel teams list --format json` when authenticated

If the operator belongs to multiple teams, present the team slugs as a list and ask which one to deploy to, then proceed without asking again. If the project is already linked, the link file decides the team, so do not ask. If there is one team or a personal account, skip the prompt.

Never use a command that silently links a project as a side effect to detect state in an unlinked directory. Only the auth check is safe to run anywhere.

### 2. Choose the deploy method

**Linked plus git remote: git push.** Ask the operator before pushing. Commit, push, and let the platform build from the push. Non-production branches get preview deployments; the production branch gets a production deployment. Retrieve the preview URL from the platform (`vercel ls --format json`, or the dashboard and commit checks when the CLI is not authenticated).

**Linked, no git remote: direct CLI deploy.** Run `vercel deploy [path] -y --no-wait` (or the Netlify CLI equivalent), then check status with `vercel inspect <deployment-url>`. For production, only on explicit request: add `--prod`.

**Not linked, CLI authenticated: link first, then deploy.** Tell the operator what linking does, then link with the selected team scope, using repo-based linking (`vercel link --repo --scope <team-slug>`) when a git remote exists, plain `vercel link` otherwise. Then deploy by the best method above.

**Not linked, CLI not authenticated: install, auth, link, deploy.** Install the CLI, run `vercel login` (the operator completes auth in the browser), pick the team, link, deploy. If login is impossible in the current environment, use the no-auth fallback instead of asking for approval to log in.

**No-auth fallback: temporary deploy.** Run `npx vercel@latest deploy [path] --temporary -y`. No account is needed. Report the deployment URL, the claim URL, and the expiry the CLI printed, and warn that the claim link must not be shared. Temporary deploys do not work in CI or in an already linked directory.

### 3. Edge config and environment

Set environment variables, edge config, and build settings through the platform (CLI or dashboard), and record what was set and where. Build settings come from the project config (`vercel.json`, `netlify.toml`, or `package.json`) so a fresh checkout deploys the same way. A setting that exists only in a dashboard and nowhere in the repo is a setting waiting to be lost.

### 4. Troubleshoot a failed deploy

Read the build log first. The usual causes, in order: build command or publish directory mismatch (check the platform config against `package.json`), missing environment variables, authentication failure (fall back to the temporary deploy), and network restrictions in sandboxed environments (add the platform domains to the allowed list, or escalate network access for the deploy command only, never for the availability check).

## Output

- The deployment URL, its status, and its expiry when one applies
- A deploy record: method used, team and project, branch, build status, and log location
- After linking: the link state, so the next deploy is a git push
- After a failed deploy: the build log excerpt and the diagnosed cause

## Verification

- Every deploy has a log and a preview URL that can be opened
- The build status is reported from the platform, not assumed
- Production deploys carry an explicit operator request on record
- The project ends linked, so the next deploy needs no manual run
- No deploy is claimed successful without a platform status to back it

## The Forge Mark

This skill carries the Forge value in its substance: flow goal to shipped, output as changes. A deploy is not a command run in a terminal; it is a live URL with a log, a project left linked for the next push, and a record the operator can open. The loop ends at distribution, which is exactly what a deploy is. Report by work: deploys shipped, previews shared, projects linked. Use the related skills (`iac-core` for the infrastructure underneath, `ops-monitoring` for the errors and deploys after launch). Update the agent's memory with the project link and deploy history so the next deploy starts from the recorded state.

## Related Skills

- `iac-core` - the infrastructure the application deploys onto
- `ops-monitoring` - error tracking and deploy records after launch
- `data-infra` - the data services the deployed application connects to

## Research source

vercel-labs/agent-skills deploy-to-vercel and vercel-cli-with-tokens, https://github.com/vercel-labs/agent-skills (12 official Vercel skills via VoltAgent/awesome-agent-skills, https://github.com/VoltAgent/awesome-agent-skills); netlify netlify-deploy, https://github.com/netlify/context-and-tools
