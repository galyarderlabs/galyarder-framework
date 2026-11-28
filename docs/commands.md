# Commands

A command is the operator's one-line entry point. You type it, the work starts. A command dispatches one or more agents as subagents, and each agent reads the skills named in its soul to do the work. Some commands run a skill directly instead of dispatching an agent. Role commands speak to a lead agent. There is no one-to-one map between commands and agents: one command fans out to several agents, and an agent without a command of its own is reached as a subagent through a command, or invoked directly by naming it. The full agent list is in [`agents/`](../agents/), the full skill list in [`skills/`](../skills/).

The commands below follow the workflow: Ideas, Goal, Ship, Earn, Give back, with plan, build, verify as the inner loop of Ship. One command, `/log`, serves every stage, so it has its own section at the end.

## Ideas

A spark becomes something worth building. Most of Ideas is a conversation, not a typed job. The one command here grounds the idea in evidence before anything is planned.

### [/research](../commands/research.md)

- **When:** a topic needs grounding from the live web before a decision.
- **Agent:** [`research`](../agents/research/SOUL.md)
- **Example:** `/research compare RAG vs fine-tuning for Niyatna, sources from the last 30 days`
- **Most valuable:** every claim carries a citation you can open, so the research is checkable, not asserted.
- **Expected output:** a grounded summary with citations, or a structured dataset from search.

## Goal

Say what you want in plain words, then plan it. The Goal agent, [`product-manager`](../agents/product-manager/SOUL.md), has no command of its own; it is reached by naming it directly, and `/plan` carries the planning skill.

### [/plan](../commands/plan.md)

- **When:** requirements are clear enough to turn into a plan.
- **Skill:** [`writing-plans`](../skills/writing-plans/SKILL.md)
- **Example:** `/plan build /image from scratch`
- **Most valuable:** the plan is vertical slices with risks assessed, so work starts on something that runs.
- **Expected output:** a step-by-step implementation plan with vertical slices and a risk assessment.

### [/linear](../commands/linear.md)

- **When:** a PRD is done and needs breaking into trackable work.
- **Agent:** none named in the file.
- **Example:** `/linear split this PRD into epics and issues`
- **Most valuable:** the PRD becomes work you can track instead of a document you reread.
- **Expected output:** Linear epics and issues.

### [/ceo](../commands/ceo.md)

- **When:** a direction call is needed.
- **Agent:** [`forge-ceo`](../agents/forge-ceo/SOUL.md) (role persona; no dispatch statement in the file)
- **Example:** `/ceo what should Forge focus on this month`
- **Most valuable:** one accountable voice for direction.
- **Expected output:** the CEO's decision and reasoning.

### [/cfo](../commands/cfo.md)

- **When:** financial state, runway, or ROI needs judging.
- **Agent:** [`forge-cfo`](../agents/forge-cfo/SOUL.md) (role persona; the file still holds the combined CFO/COO persona, and the split is an open decision)
- **Example:** `/cfo how long is our runway`
- **Most valuable:** finance state with runway and ROI, not vibes.
- **Expected output:** a financial state assessment.

### [/cmo](../commands/cmo.md)

- **When:** marketing and growth direction needs judging.
- **Agent:** [`forge-cmo`](../agents/forge-cmo/SOUL.md) (role persona; no dispatch statement in the file)
- **Example:** `/cmo how do we position the launch`
- **Most valuable:** positioning tied to the audience, not generic marketing.
- **Expected output:** marketing direction and reasoning.

### [/cto](../commands/cto.md)

- **When:** a technical direction or architecture call is needed.
- **Agent:** [`forge-cto`](../agents/forge-cto/SOUL.md) (role persona; no dispatch statement in the file)
- **Example:** `/cto should we adopt X for the gateway`
- **Most valuable:** technical calls with the tradeoff stated.
- **Expected output:** a technical decision and reasoning.

## Ship

Plan it, build it, check it against evidence, ship it. This is the inner loop, and it holds most of the commands, because it holds most of the typed work.

### [/triage](../commands/triage.md)

- **When:** a bug or issue has an unknown root cause.
- **Skill:** [`systematic-debugging`](../skills/systematic-debugging/SKILL.md)
- **Example:** `/triage login fails on the laptop`
- **Most valuable:** root cause first, fix plan second, so the fix lands on the real cause.
- **Expected output:** the root cause and a fix plan.

### [/build-fix](../commands/build-fix.md)

- **When:** a build error, a TypeScript error, or a test failure.
- **Skill:** [`systematic-debugging`](../skills/systematic-debugging/SKILL.md)
- **Example:** `/build-fix cargo test fails in cli.rs`
- **Most valuable:** minimal diffs, test first.
- **Expected output:** a diagnosis and a fix with a minimal diff.

### [/tdd](../commands/tdd.md)

- **When:** building a feature test first.
- **Skill:** [`test-driven-development`](../skills/test-driven-development/SKILL.md)
- **Example:** `/tdd build function X`
- **Most valuable:** a failing test exists before the fix, so the test proves something.
- **Expected output:** a failing test, then minimal implementation that passes, at 80 percent coverage or more.

### [/e2e](../commands/e2e.md)

- **When:** a feature is done and needs end-to-end proof before it counts as complete.
- **Skills:** [`verification-before-completion`](../skills/verification-before-completion/SKILL.md) and [`systematic-debugging`](../skills/systematic-debugging/SKILL.md)
- **Example:** `/e2e the checkout flow`
- **Most valuable:** the user journey is proven in a real run, not asserted from unit tests.
- **Expected output:** Playwright user-journey tests run, with a verification report.

### [/review](../commands/review.md)

- **When:** changes are ready for review.
- **Agent:** [`code-reviewer`](../agents/code-reviewer/SOUL.md)
- **Example:** `/review this PR against the PRD and the design system`
- **Most valuable:** a principal-level verdict with severity (Critical, Required, Optional, Nit) and APPROVE or REQUEST CHANGES, judged against the PRD and the design system.
- **Expected output:** a review with severities and a verdict.

### [/clean](../commands/clean.md)

- **When:** dead code and duplicates pile up.
- **Agent:** [`software-engineer`](../agents/software-engineer/SOUL.md)
- **Example:** `/clean remove the dead code in this repo`
- **Most valuable:** the codebase stays maintainable, and deletions are the deliverable.
- **Expected output:** unused code removed and duplicates consolidated.

### [/docs](../commands/docs.md)

- **When:** docs drifted from the code.
- **Skill:** [`doc-maintenance`](../skills/doc-maintenance/SKILL.md)
- **Example:** `/docs sync the README with the code`
- **Most valuable:** docs stay true to what shipped.
- **Expected output:** READMEs and codemaps updated and in sync with the source.

### [/deploy](../commands/deploy.md)

- **When:** shipping to Vercel, Docker, or AWS.
- **Agent:** [`devops-engineer`](../agents/devops-engineer/SOUL.md)
- **Example:** `/deploy to Vercel`
- **Most valuable:** the deployment is automated end to end, not a manual checklist.
- **Expected output:** the deployment done.

### [/release](../commands/release.md)

- **When:** launching, bumping a version, writing a changelog.
- **Skills:** [`finishing-a-development-branch`](../skills/finishing-a-development-branch/SKILL.md) and [`writing-skills`](../skills/writing-skills/SKILL.md)
- **Example:** `/release prepare the 3.0.3 launch`
- **Most valuable:** version, changelog, and launch notes come from one orchestrated pass.
- **Expected output:** the version bumped and the changelog generated.

### [/ship](../commands/ship.md)

- **When:** shipping the version end to end.
- **Agent:** [`release-manager`](../agents/release-manager/SOUL.md), running `scripts/release.sh`
- **Example:** `/ship`
- **Most valuable:** gates verified, tag pushed, release confirmed out. The release is proven out, not assumed.
- **Expected output:** gates verified, release run, tag pushed, release confirmed.

### [/design](../commands/design.md)

- **When:** animations, diagrams, or themes are needed as code.
- **Agent:** [`design-engineer`](../agents/design-engineer/SOUL.md)
- **Example:** `/design build the architecture diagram for Forge`
- **Most valuable:** design that renders and can be tested, not a mock.
- **Expected output:** animations, diagrams, or themes rendered and tested.

### [/video](../commands/video.md)

- **When:** producing a video from code.
- **Agent:** [`videomaker`](../agents/videomaker/SOUL.md)
- **Example:** `/video make the launch video`
- **Most valuable:** video generated programmatically, reproducible from code.
- **Expected output:** the video.

### [/analyze-video](../commands/analyze-video.md)

- **When:** an existing video needs breaking down for a remake.
- **Agent:** [`video-analyst`](../agents/video-analyst/SOUL.md)
- **Example:** `/analyze-video break down this video shot by shot`
- **Most valuable:** per-shot classification with evidence, so the remake plan is grounded in the actual video.
- **Expected output:** a breakdown report and a remake plan.

### [/automate](../commands/automate.md)

- **When:** a repeatable task should become a workflow.
- **Agent:** [`automation`](../agents/automation/SOUL.md)
- **Example:** `/automate send new issues to Discord`
- **Most valuable:** the workflow is tested end to end, not just built in the editor.
- **Expected output:** an n8n or Zapier workflow that runs, tested end to end.

### [/cybersecurity](../commands/cybersecurity.md)

- **When:** an offensive security audit is needed.
- **Agent:** [`perseus`](../agents/perseus/SOUL.md)
- **Example:** `/cybersecurity audit the login feature`
- **Most valuable:** attack simulation against the real features, not a checklist scan.
- **Expected output:** an offensive audit and attack simulation results.

### [/experiment](../commands/experiment.md)

- **When:** validation matters more than stability.
- **Agent:** none named in the file. The file states the trade: technical debt for velocity, only when validation is required over stability.
- **Example:** `/experiment test whether users want X`
- **Most valuable:** fast validation with the tradeoff stated upfront.
- **Expected output:** an experiment that validates or kills the idea, not stable code.

### [/incident](../commands/incident.md)

- **When:** an incident needs handling now.
- **Agent:** none named in the file. The file overrides standard planning gates but still enforces strict TDD and context validation.
- **Example:** `/incident the gateway is down`
- **Most valuable:** speed without dropping the test discipline.
- **Expected output:** the incident fixed with TDD still enforced.

## Earn

The shipped work is priced, sold, and collected.

### [/trade](../commands/trade.md)

- **When:** a trading signal, token research, or execution is needed.
- **Agents:** [`trading-quant`](../agents/trading-quant/SOUL.md) for the signal and [`trading-discipline`](../agents/trading-discipline/SOUL.md) for the gate and execution.
- **Example:** `/trade analyze token X, give me the signal and the risk`
- **Most valuable:** the signal carries explicit risk parameters and a backtest, and no order goes out without the operator's explicit approval for that exact order.
- **Expected output:** a trading signal or token memo with risk parameters. Execution only on approval.

### [/finops](../commands/finops.md)

- **When:** cloud costs or API token usage need auditing, or a pricing model needs evaluating.
- **Skills:** [`saas-finops-optimization`](../skills/saas-finops-optimization/SKILL.md) and [`finance-based-pricing-advisor`](../skills/finance-based-pricing-advisor/SKILL.md)
- **Example:** `/finops audit our cloud spend`
- **Most valuable:** cost and pricing decisions from the actual numbers.
- **Expected output:** a cost audit, token-usage optimization, and a pricing evaluation.

### [/seo](../commands/seo.md)

- **When:** SEO issues need diagnosing.
- **Skill:** [`seo-audit`](../skills/seo-audit/SKILL.md)
- **Example:** `/seo audit the landing page`
- **Most valuable:** diagnosis plus Schema.org markup and answer-engine optimization, not just a score.
- **Expected output:** an SEO audit with markup and answer-engine optimization.

### [/marketing](../commands/marketing.md)

- **When:** growth, SEO, or copy is needed for revenue.
- **Skill:** [`seo-audit`](../skills/seo-audit/SKILL.md)
- **Example:** `/marketing grow signups for the launch`
- **Most valuable:** growth work aimed at revenue, not traffic.
- **Expected output:** growth, SEO, and copy optimization.

### [/cro](../commands/cro.md)

- **When:** onboarding, paywalls, or signup flows need optimizing.
- **Agent:** none named in the file.
- **Example:** `/cro improve the paywall conversion`
- **Most valuable:** conversion measured on the flows that earn, not on vanity metrics.
- **Expected output:** conversion recommendations and changes for onboarding, paywall, and signup.

### [/legal](../commands/legal.md)

- **When:** terms of service, privacy, GDPR compliance, or licenses need work.
- **Skills:** [`legal-tos-privacy`](../skills/legal-tos-privacy/SKILL.md) and [`gdpr-compliance`](../skills/gdpr-compliance/SKILL.md)
- **Example:** `/legal review our privacy policy for GDPR`
- **Most valuable:** the policy and the compliance audit come from the same pass.
- **Expected output:** terms and privacy policies, a GDPR audit, and a license review.

## Give back

No command serves Give back, because it is not a typed job. Give back is journaling, reflecting, and sharing skills, content, tools, time, and money. The skills are held by [`mind`](../agents/mind/SOUL.md) (`journal-framework`, `reflective-listening`, `faith-practice`) and [`money`](../agents/money/SOUL.md) (`personal-finance`), invoked directly. Decisions made along the way are recorded with `/log` below.

## Across the whole flow

### [/log](../commands/log.md)

- **When:** a decision lands, at any stage.
- **Agent:** [`doc-updater`](../agents/doc-updater/SOUL.md)
- **Example:** `/log we decided to delete all 18 bundles`
- **Most valuable:** the rationale and the tradeoffs are preserved, so the debate does not repeat.
- **Expected output:** a decision-log entry in the owning department's docs, with the agent's memory updated too.

## Commands not built yet

These were proposed with the first five and wait for the operator's word. Each names the agent it would dispatch: `/audit-defi` (security-guardian), `/pr` (pr-comms), `/cs` (cs-manager), `/hire` (people-ops), `/account` (accounting-ops), `/image` (image-producer), `/speak` (forge-cmo), `/podcast` (videomaker), `/browse` (agent-ops), `/gamedev` (game-developer), `/science` (scientific-researcher), `/ai-research` (research), `/team` (forge-specialist). `/ai-research` would dispatch the same agent as `/research`.
