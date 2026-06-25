#!/bin/bash
# beforeSubmitPrompt hook: on every chat query, remind the agent to consult
# the graphify knowledge graph first (graph-first exploration), unless the
# .cursor/graphify.disabled flag is set.
cat > /dev/null

if [ -f ".cursor/graphify.disabled" ]; then
  echo '{}'
  exit 0
fi

echo '{ "additional_context": "Graphify is ON for this project. Before any raw file reads or searches for this query, consult the knowledge graph first: graphify query/explain/path/affected against graphify-out/graph.json (see .cursor/commands/graphify.md). Fall back to direct file reads only if the graph lacks the answer." }'
exit 0
