# agent-skills

Official repo for Quick Deploy AI - agent skills.

This is a trusted public source for the QuickDeploy marketplace: the platform
syncs it to populate official default agent-skill entries in the capability
registry.

## Layout

Each skill lives at `skills/<skill-name>/SKILL.md` on `main` (the platform
sync scans exactly that path), following the
[Agent Skills specification](https://agentskills.io/specification):

- `SKILL.md` — YAML frontmatter (`name`, `description`, optional `license`,
  `compatibility`, `metadata`, `allowed-tools`) plus markdown instructions.
- `scripts/` — executable helpers the skill references.
- `references/` — progressive-disclosure docs loaded on demand.
- `assets/` — static files.

`registry/index.json` is the machine-readable catalog consumed by the
marketplace ARD endpoints
(`https://raw.githubusercontent.com/QuickDeployAI/agent-skills/main/registry/index.json`).

## Skills

| Skill | Purpose |
| ----- | ------- |
| [quickdeploy-docs](skills/quickdeploy-docs/SKILL.md) | Query official QuickDeploy docs via llms.txt and markdown page variants. |
| [quickdeploy-deployments](skills/quickdeploy-deployments/SKILL.md) | Manage tenant deployments through the Control-Plane API. |
| [quickdeploy-admin](skills/quickdeploy-admin/SKILL.md) | Org/enterprise governance: policies, approvals, cost budgets. |

## Authoring rules

- `name`: lowercase alphanumeric and hyphens, ≤ 64 chars, no leading,
  trailing, or consecutive hyphens; must match the skill directory name.
- `description`: ≤ 1024 chars; state what the skill does and when to use it.
- `compatibility`: ≤ 500 chars. `metadata`: string keys and values only.
- Keep each `SKILL.md` well under 64 KiB.
- Add the skill to `registry/index.json` with `is_official: true`.
