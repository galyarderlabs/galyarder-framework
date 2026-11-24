# Import a company package

`forge company import` copies an agent-company package into a project, so the company runs in Forge Anything.

## What a company package is

A company package is a directory that follows the Agent Companies specification (agentcompanies/v1). It holds a company structure: the company itself, its teams, its agents, its projects, its tasks, and its skills. The company-creator skill (`skills/company-creator/`) builds these packages, either from scratch (it interviews you first) or from an existing git repo or skills collection. The skill creates the package; this command imports it into a project.

The normative spec is at https://agentcompanies.io/specification. The local reference is `skills/company-creator/references/companies-spec.md`.

## Package format

```
company-package/
  COMPANY.md
  agents/
    <slug>/AGENTS.md
  teams/
    <slug>/TEAM.md
  projects/
    <slug>/
      PROJECT.md
      tasks/
        <slug>/TASK.md
  tasks/
    <slug>/TASK.md
  skills/
    <slug>/SKILL.md
  assets/
  scripts/
  references/
  .forge.yaml          (optional vendor extension)
```

`COMPANY.md` is the root entrypoint. Its frontmatter must have:

```yaml
name: Company Name
description: What this company does
slug: company-slug
schema: agentcompanies/v1
```

Optional fields: `version`, `license`, `authors`, `goals`, `includes`, `requirements.secrets`. The slug must be URL-safe: lowercase letters, digits, and hyphens only.

Each agent (`agents/<slug>/AGENTS.md`) has a name, a title, who it reports to, and the skills it uses (by shortname, resolved to `skills/<shortname>/SKILL.md`). The body of the file is the agent's default instructions. Each team (`teams/<slug>/TEAM.md`) groups agents and skills. Each project (`projects/<slug>/PROJECT.md`) groups planned work, with tasks under `tasks/`. A task (`tasks/<slug>/TASK.md`) is a portable starter task with an assignee and a project.

## The command

```
forge company import --from <path> [dir] [--force]
```

- `--from <path>` (required): the company package directory to import. `--from=<path>` works too.
- `[dir]` (optional): the target project directory. No dir means the current directory.
- `--force` / `-f`: overwrite the company if it is already imported.

The package lands in `<dir>/company/<slug>/`, self-contained. Its skills are not copied into the project's root `skills/` and its agents are not copied into the project's root `agents/`. That is deliberate: the package stays whole under `company/<slug>/`, so the company is one unit you can read, update, or remove.

`forge company` with no action, `forge company help`, and `forge company import --help` print help. An unknown action prints an error and the help, and exits 1.

## Validation

Before copying anything, the command checks the package:

- `--from` must be a directory.
- `COMPANY.md` must exist at the package root.
- `COMPANY.md` must have a frontmatter block with `schema: agentcompanies/v1` and non-empty `name`, `description`, and `slug`.
- The slug must be URL-safe (lowercase letters, digits, and hyphens only).
- The destination must not be the package itself or inside it (the command never imports a package into itself).

Any failed check stops the import with an error that names the problem, and exits 1. Nothing is copied on a failed check.

## Re-import

If the company is already imported at `<dir>/company/<slug>/`, a second import without `--force` fails:

```
forge: company import: company 'lean-dev-shop' is already imported at /projects/my-project/company/lean-dev-shop (use --force to overwrite)
```

With `--force`, the previous import is removed first, then the package is copied again.

## Worked example

Import the Lean Dev Shop example (slug `lean-dev-shop`: 3 agents, 1 team, 1 project, 1 task, 1 skill). The example package is in `skills/company-creator/references/example-company.md`.

```bash
forge company import --from ./lean-dev-shop /projects/my-project
```

Output:

```
Imported Lean Dev Shop (lean-dev-shop) into /projects/my-project/company/lean-dev-shop: 3 agents, 1 teams, 1 projects, 1 tasks, 1 skills.
```

Resulting layout:

```
my-project/
  company/
    lean-dev-shop/
      COMPANY.md
      agents/
        ceo/AGENTS.md
        cto/AGENTS.md
        engineer/AGENTS.md
      teams/
        engineering/TEAM.md
      projects/
        q2-launch/
          PROJECT.md
          tasks/
            monday-review/TASK.md
      skills/
        code-review/SKILL.md
```

## How it relates to the company-creator skill

The company-creator skill creates the package. `forge company import` brings it into a project. The skill does not import, and the CLI does not create: the skill writes the package, the CLI copies it into `company/<slug>/`. If you have a package already (made by the skill or by hand, following the spec), import it with this command. To make a new company, use the skill first.
