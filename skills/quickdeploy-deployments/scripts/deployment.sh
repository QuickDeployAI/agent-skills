#!/bin/sh
# QuickDeploy Control-Plane deployment helper.
# Usage:
#   deployment.sh create <manifest-json-file>
#   deployment.sh get <deployment-id>
#   deployment.sh action <deployment-id> <pause|resume|promote|rollback|quarantine|delete>
#   deployment.sh logs <deployment-id>
#   deployment.sh environments
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
  create)
    [ $# -eq 2 ] || { echo "Usage: $0 create <manifest-json-file>" >&2; exit 2; }
    auth_curl -X POST --data @"$2" "${API_BASE}/v1/deployments"
    ;;
  get)
    [ $# -eq 2 ] || { echo "Usage: $0 get <deployment-id>" >&2; exit 2; }
    auth_curl "${API_BASE}/v1/deployments/$2"
    ;;
  action)
    [ $# -eq 3 ] || { echo "Usage: $0 action <deployment-id> <action>" >&2; exit 2; }
    case "$3" in
      pause|resume|promote|rollback|quarantine|delete) ;;
      *) echo "Invalid action '$3' (pause|resume|promote|rollback|quarantine|delete)" >&2; exit 2 ;;
    esac
    auth_curl -X POST "${API_BASE}/v1/deployments/$2/actions/$3"
    ;;
  logs)
    [ $# -eq 2 ] || { echo "Usage: $0 logs <deployment-id>" >&2; exit 2; }
    auth_curl "${API_BASE}/v1/deployments/$2/logs"
    ;;
  environments)
    auth_curl "${API_BASE}/v1/environments"
    ;;
  *)
    sed -n '2,8p' "$0" >&2
    exit 2
    ;;
esac
