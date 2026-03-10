#!/bin/bash
# Pre-tool guard: block dangerous operations
INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.toolName // empty')
ARGS=$(echo "$INPUT" | jq -r '.toolArgs // empty')

# Block removing lib/ or test/ directories
if [[ "$TOOL" == "bash" ]] && echo "$ARGS" | grep -qE 'rm\s+-rf\s+(lib|test)/'; then
  echo '{"permissionDecision":"deny","reason":"Cannot delete lib/ or test/ directories"}'
  exit 1
fi

exit 0
