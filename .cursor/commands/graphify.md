# Graphify

Maintain and query the knowledge graph in `graphify-out/` using the `graphify` CLI
(installed at `~/.local/bin/graphify`). Works for any language — the CLI's extractor
is language-agnostic.

## Enable/disable flag

The flag file `.cursor/graphify.disabled` controls whether graph updates run:

- `/graphify off` → create the flag file (`touch .cursor/graphify.disabled`) and confirm updates are paused.
- `/graphify on` → remove the flag file (`rm -f .cursor/graphify.disabled`) and confirm updates are active.
- Before any update, check the flag: if `.cursor/graphify.disabled` exists, skip the update and tell the user it is disabled.

## Updating the graph

When asked to refresh/update the graph (and the flag allows it):

```bash
graphify update .
```

- Use `graphify update . --force` only after refactors that deleted code (rebuild has fewer nodes).
- Regenerates `graphify-out/graph.json` — graph-only refresh; never move, rename, delete, or reorganize project files.
- `graphify-out/` is gitignored; do not commit it.

## Querying the graph

Prefer these over raw file searches when exploring the project:

```bash
graphify query "<question>"        # BFS traversal answering a question
graphify explain "<node>"          # plain-language explanation of a node and its neighbors
graphify path "<A>" "<B>"          # shortest path between two nodes
graphify affected "<node>"         # what is impacted by changing a node
```

All read from `graphify-out/graph.json` by default.
