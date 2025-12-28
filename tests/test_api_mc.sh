#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-https://localhost:9000/zdrav/mc}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


PAYLOAD_FILE="$SCRIPT_DIR/test-mc.json"


RESPONSE=$(curl -k -s -w "\n%{http_code}" \
  -X POST "$TARGET" \
  -H "Content-Type: application/json" \
  --data-binary @"$PAYLOAD_FILE"
)

BODY=$(echo "$RESPONSE" | head -n1)
STATUS=$(echo "$RESPONSE" | tail -n1)

if [[ "$STATUS" != "200" ]]; then
  echo "❌ HTTP status $STATUS"
  exit 1
fi

if [[ "$BODY" != '{"status":"ok"}' ]]; then
  echo "❌ Unexpected response: $BODY"
  exit 1
fi

echo "✅ OK"
