#!/bin/bash
# afterFileEdit hook: keep the knowledge graph in sync with agent file edits.
# Skips graphify-out/ and .cursor/ changes, and respects the disable flag.
input=$(cat)

if [ -f ".cursor/graphify.disabled" ]; then
  echo '{}'
  exit 0
fi

# Ignore edits to the graph output itself or to .cursor config files.
if echo "$input" | grep -Eq '"file_path"[^,]*(graphify-out/|\.cursor/)'; then
  echo '{}'
  exit 0
fi

graphify update . > /dev/null 2>&1
echo '{}'
exit 0
