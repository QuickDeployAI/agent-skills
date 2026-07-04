#!/bin/sh
# Search the QuickDeploy docs llms.txt index for a keyword.
# Usage: search-docs.sh <keyword> [domain]
set -eu

if [ $# -lt 1 ]; then
  echo "Usage: $0 <keyword> [domain]" >&2
  exit 2
fi

KEYWORD=$1
DOMAIN=${2:-docs.quickdeploy.ai}

curl -sf "https://${DOMAIN}/llms.txt" | grep -i -- "$KEYWORD" || {
  echo "No entries matching '$KEYWORD' in https://${DOMAIN}/llms.txt" >&2
  exit 1
}
