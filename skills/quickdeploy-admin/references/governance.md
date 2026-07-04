# Governance reference

Control-Plane API v1 · object version `2026-05-28.control-plane-v1`

## Endpoints

| Method | Path                                        | Scope             |
| ------ | ------------------------------------------- | ----------------- |
| GET    | `/v1/policies`                              | `policies:read`   |
| POST   | `/v1/policies/evaluate`                     | `policies:read`   |
| GET    | `/v1/approvals`                             | `approvals:read`  |
| POST   | `/v1/approvals/:approvalId/actions/:decision` | `approvals:write` |
| GET    | `/v1/costs`                                 | `costs:read`      |
| POST   | `/v1/costs/budgets`                         | `costs:write`     |
| GET    | `/v1/events`                                | `events:read`     |
| POST   | `/v1/event-subscriptions`                   | `events:subscribe` |

## Policy rules

A `QDAIPolicyRule` has an `effect` (`allow | deny | require_approval |
quarantine`) and a `condition` over connectors, scopes, environments, risk,
or cost. Effective policy is inherited — always read `/v1/policies` for the
specific actor/environment rather than assuming org-level rules.

## Approvals

Approval requests carry `requestedDecision` and accumulate `auditNotes`.
Decisions post to `/v1/approvals/:id/actions/:decision` with optional audit
notes in the body: `{"note": "..."}`.

## Costs

Cost ledger entries are credit-denominated against a versioned rate card.
Budget rules support thresholds (notify), caps (`pause_on_cap`), and
notification routing. Crossing a threshold emits `cost.threshold.crossed`.

## Events

Signed envelopes (`QDAIEventEnvelope`) support audit and replay. Webhook
deliveries are HMAC-SHA256 signed over timestamp, event id, and body, and
retry with exponential backoff for 24 hours.
