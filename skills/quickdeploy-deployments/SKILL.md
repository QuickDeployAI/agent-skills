---
name: quickdeploy-deployments
description: >-
  Manage QuickDeploy AI tenant deployments through the Control-Plane API:
  create deployments from manifests, read lifecycle and health state, and run
  pause, resume, promote, rollback, quarantine, or delete actions. Use when a
  user asks to deploy a capability, check deployment status, roll back a bad
  release, or inspect deployment logs. Triggers: deploy, deployment status,
  rollback, pause deployment, promote, quickdeploy control plane.
license: MIT
compatibility: "Requires a QuickDeploy service-account token (QDAI_API_TOKEN) with deployments scopes"
metadata:
  category: tools
  publisher: QuickDeploy AI
allowed-tools: "Bash"
---

# QuickDeploy Deployments (Control Plane)

Drive the QuickDeploy Control-Plane API (`https://api.quickdeploy.ai/v1`)
instead of clicking through the dashboard. All calls need a service-account
bearer token in `QDAI_API_TOKEN` (mint one via the `client_credentials` grant
at `/v1/oauth/token`; see `https://api.quickdeploy.ai/auth.md`).

| Task                        | How                                                            | Scope               |
| --------------------------- | -------------------------------------------------------------- | ------------------- |
| Create a deployment         | `scripts/deployment.sh create <manifest-json-file>`            | `deployments:write` |
| Read deployment state       | `scripts/deployment.sh get <deployment-id>`                    | `deployments:read`  |
| Lifecycle action            | `scripts/deployment.sh action <deployment-id> <action>`        | `deployments:write` |
| Read sanitized runtime logs | `scripts/deployment.sh logs <deployment-id>`                   | `observability:read`|
| List target environments    | `scripts/deployment.sh environments`                           | `environments:read` |

Valid lifecycle actions: `pause`, `resume`, `promote`, `rollback`,
`quarantine`, `delete`.

## Rules

- Never pass raw secret values in manifests or bindings — the API rejects
  them. Use secret references (`keyvault:`, `supabase-vault:`,
  `external-secret:` prefixes) only.
- Risky actions may return `202` with a pending approval; surface the
  approval id to the user instead of retrying (approvals are handled by the
  `quickdeploy-admin` skill).
- Read [references/lifecycle.md](references/lifecycle.md) before running
  destructive actions (`rollback`, `quarantine`, `delete`).
