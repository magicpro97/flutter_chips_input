#!/bin/bash
# Post-tool hook: auto-format Dart files after edits
INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.toolName // empty')

if [[ "$TOOL" == "edit" || "$TOOL" == "create" ]]; then
  dart format . --quiet 2>/dev/null || true
fi

exit 0
