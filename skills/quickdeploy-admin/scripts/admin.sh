#!/bin/sh
# QuickDeploy Control-Plane governance helper.
# Usage:
#   admin.sh policies
#   admin.sh evaluate <request-json-file>
#   admin.sh approvals
#   admin.sh decide <approval-id> <approve|deny|request_changes>
#   admin.sh costs
#   admin.sh budget <budget-json-file>
#   admin.sh events
set -eu

API_BASE=${QDAI_API_BASE:-https://api.quickdeploy.ai}

if [ -z "${QDAI_API_TOKEN:-}" ]; then
  echo "QDAI_API_TOKEN is not set. Mint a service-account token first (see https://api.quickdeploy.ai/auth.md)." >&2
  exit 2
fi

auth_curl() {
  curl -sf -H "Authorization: Bearer ${QDAI_API_TOKEN}" -H "Content-Type: application/json" "$@"
}

CMD=${1:-help}
case "$CMD" in
  policies)
    auth_curl "${API_BASE}/v1/policies"
    ;;
  evaluate)
    [ $# -eq 2 ] || { echo "Usage: $0 evaluate <request-json-file>" >&2; exit 2; }
    auth_curl -X POST --data @"$2" "${API_BASE}/v1/policies/evaluate"
    ;;
  approvals)
    auth_curl "${API_BASE}/v1/approvals"
    ;;
  decide)
    [ $# -eq 3 ] || { echo "Usage: $0 decide <approval-id> <decision>" >&2; exit 2; }
    case "$3" in
      approve|deny|request_changes) ;;
      *) echo "Invalid decision '$3' (approve|deny|request_changes)" >&2; exit 2 ;;
    esac
    auth_curl -X POST "${API_BASE}/v1/approvals/$2/actions/$3"
    ;;
  costs)
    auth_curl "${API_BASE}/v1/costs"
    ;;
  budget)
    [ $# -eq 2 ] || { echo "Usage: $0 budget <budget-json-file>" >&2; exit 2; }
    auth_curl -X POST --data @"$2" "${API_BASE}/v1/costs/budgets"
    ;;
  events)
    auth_curl "${API_BASE}/v1/events"
    ;;
  *)
    sed -n '2,10p' "$0" >&2
    exit 2
    ;;
esac
