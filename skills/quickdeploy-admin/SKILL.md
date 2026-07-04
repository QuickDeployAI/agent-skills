---
name: quickdeploy-admin
description: >-
  Administer QuickDeploy AI org and enterprise governance through the
  Control-Plane API: list and evaluate policies, review and decide approval
  requests, and manage cost budgets and caps. Use when a user asks to check
  effective policy, approve or deny a pending request, set a spend cap, or
  audit governance events. Triggers: policy, approval, budget, cost cap,
  governance, quickdeploy admin, org config.
license: MIT
compatibility: "Requires a QuickDeploy service-account token (QDAI_API_TOKEN) with policies/approvals/costs scopes"
metadata:
  category: tools
  publisher: QuickDeploy AI
allowed-tools: "Bash"
---

# QuickDeploy Admin (Policies, Approvals, Costs)

Governance operations for org and enterprise admins against
`https://api.quickdeploy.ai/v1`. Requires `QDAI_API_TOKEN` (service-account
bearer token; see `https://api.quickdeploy.ai/auth.md`).

| Task                             | How                                                   | Scope             |
| -------------------------------- | ----------------------------------------------------- | ----------------- |
| List effective policy rules      | `scripts/admin.sh policies`                           | `policies:read`   |
| Evaluate an action against policy| `scripts/admin.sh evaluate <request-json-file>`       | `policies:read`   |
| List approval requests           | `scripts/admin.sh approvals`                          | `approvals:read`  |
| Decide an approval               | `scripts/admin.sh decide <approval-id> <decision>`    | `approvals:write` |
| Read cost ledger / forecast      | `scripts/admin.sh costs`                              | `costs:read`      |
| Set a budget rule / cap          | `scripts/admin.sh budget <budget-json-file>`          | `costs:write`     |
| Page audit events                | `scripts/admin.sh events`                             | `events:read`     |

Valid approval decisions: `approve`, `deny`, `request_changes`.

## Rules

- Policy effects are `allow`, `deny`, `require_approval`, or `quarantine`.
  Always run `evaluate` before telling a user an action will succeed.
- Approval decisions are audited; include a reason in the conversation and
  never decide an approval the user has not explicitly confirmed.
- Budget caps with `pause_on_cap` stop running deployments — treat setting
  them like a destructive action and confirm first.
- See [references/governance.md](references/governance.md) for the endpoint
  and event-type reference.
