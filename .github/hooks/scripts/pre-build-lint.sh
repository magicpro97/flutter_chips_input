#!/bin/bash
# Pre-build hook: run flutter analyze before any build/test command.
# If lint fails, the build is blocked.
INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.toolName // empty')
ARGS=$(echo "$INPUT" | jq -r '.toolArgs // empty')

# Only intercept bash commands that look like flutter build/test/run
if [[ "$TOOL" != "bash" ]]; then
  exit 0
fi

IS_BUILD=$(echo "$ARGS" | grep -cE 'flutter\s+(build|run|test)')
if [[ "$IS_BUILD" -eq 0 ]]; then
  exit 0
fi

echo "🔍 Running flutter analyze before build..." >&2
if ! flutter analyze --no-pub 2>&1; then
  echo '{"permissionDecision":"deny","reason":"flutter analyze failed — fix lint errors before building"}'
  exit 1
fi

echo "✅ Lint passed, proceeding with build." >&2
exit 0
