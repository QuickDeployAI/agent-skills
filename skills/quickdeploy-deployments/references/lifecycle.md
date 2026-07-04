# Deployment lifecycle reference

Control-Plane API v1 · object version `2026-05-28.control-plane-v1`

## States

`pending → running ⇄ paused`, plus `failed`, `quarantined`, and terminal
`deleted`.

## Endpoints

| Method | Path                                          | Scope                |
| ------ | --------------------------------------------- | -------------------- |
| POST   | `/v1/deployments`                             | `deployments:write`  |
| GET    | `/v1/deployments/:deploymentId`               | `deployments:read`   |
| POST   | `/v1/deployments/:deploymentId/actions/:action` | `deployments:write` |
| GET    | `/v1/deployments/:deploymentId/logs`          | `observability:read` |
| GET    | `/v1/deployments/:deploymentId/traces`        | `observability:read` |
| GET    | `/v1/deployments/:deploymentId/metrics`       | `observability:read` |
| GET    | `/v1/environments`                            | `environments:read`  |
| POST   | `/v1/environments/:environmentId/bindings`    | `environments:write` |

## Destructive-action checklist

Before `rollback`, `quarantine`, or `delete`:

1. `get` the deployment and confirm its `lifecycleState` and `environment`
   with the user.
2. Check for pending approvals — policy may require sign-off
   (`require_approval` effect) before the action takes effect.
3. `rollback` targets the previous manifest version; confirm which version
   that is via the deployment's workflow state.
4. `delete` is terminal. Prefer `pause` or `quarantine` when investigating.

## Events

Lifecycle changes emit signed events (`deployment.lifecycle.updated`,
`deployment.health.changed`) consumable via `GET /v1/events` or webhook
subscriptions at `POST /v1/event-subscriptions`.
