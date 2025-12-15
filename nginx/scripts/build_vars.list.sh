#!/usr/bin/env bash
set -euo pipefail

INPUT_FILE="./nginx.template.conf"
OUTPUT_FILE="./vars.list"

grep -oE '\$\{[A-Za-z_][A-Za-z0-9_]*\}' "$INPUT_FILE" \
  | sed 's/[${}]//g' \
  | sort -u \
  > "$OUTPUT_FILE"

echo "Saved variables to $OUTPUT_FILE"
