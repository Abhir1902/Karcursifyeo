#!/bin/bash
# postToolUse hook: if the agent just ran a git pull/merge, remind it to
# refresh the knowledge graph in graphify-out/ via the graphify CLI.
input=$(cat)

# Respect the enable/disable flag (toggled via /graphify on|off).
if [ -f ".cursor/graphify.disabled" ]; then
  echo '{}'
  exit 0
fi

if echo "$input" | grep -Eq 'git (pull|merge)'; then
  echo '{ "additional_context": "Incoming git changes were just integrated. Per the project rules, refresh the knowledge graph now by running: graphify update .  (graph-only refresh of graphify-out/; see .cursor/commands/graphify.md). Skip if .cursor/graphify.disabled exists." }'
else
  echo '{}'
fi
exit 0
