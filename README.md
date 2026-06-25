# Karcursifyeo — Cursor AI Toolkit for Smarter, Cheaper Agent Coding

**Karcursifyeo** is an open-source starter kit for [Cursor](https://cursor.com) that combines three proven layers of AI coding guidance:

1. **[Karpathy behavioral guidelines](#karpathy-behavioral-guidelines)** — rules that reduce over-engineering and wasted LLM turns
2. **[Graphify](#graphify-knowledge-graph)** — a code knowledge graph so agents explore your repo without reading every file
3. **[Agentic SEO Skill](#agentic-seo-skill)** — LLM-first SEO audits for websites, blog posts, and GitHub repositories

Use this repository as a **drop-in `.cursor/` configuration** for any project. Teams report up to **65% lower token usage** when agents query a knowledge graph instead of scanning the full codebase on every request.

> **Who is this for?** Developers and teams using Cursor Agent who want safer edits, faster codebase navigation, and built-in SEO tooling — without writing custom prompts from scratch.

---

## Table of Contents

- [Why Karcursifyeo](#why-karcursifyeo)
- [What's Included](#whats-included)
- [Prerequisites](#prerequisites)
- [Quick Start — Use in Your Project](#quick-start--use-in-your-project)
- [Step-by-Step Setup Guide](#step-by-step-setup-guide)
- [Karpathy Behavioral Guidelines](#karpathy-behavioral-guidelines)
- [Graphify Knowledge Graph](#graphify-knowledge-graph)
- [Agentic SEO Skill](#agentic-seo-skill)
- [Repository Structure](#repository-structure)
- [Example Prompts](#example-prompts)
- [GitHub Repository SEO Tips](#github-repository-seo-tips)
- [Credits & License](#credits--license)
- [Contributing](#contributing)

---

## Why Karcursifyeo

| Problem | How Karcursifyeo helps |
|---------|----------------------|
| Agents over-edit, refactor unrelated code, or add speculative features | Karpathy rules enforce surgical, goal-driven changes |
| Every chat re-reads dozens of files, burning tokens | Graphify maps code relationships; agents query the graph first |
| SEO audits require separate tools and manual checklists | Agentic SEO Skill bundles 16 sub-skills, 10 agents, and 89 evidence scripts |
| Cursor config is scattered across docs and gists | One `.cursor/` folder you copy into any repo and commit |

---

## What's Included

```
.cursor/
├── rules/
│   ├── kaprpathy-guidelines.mdc   # Always-on Karpathy coding rules (+ Graphify workflow)
│   └── seo.mdc                    # SEO skill trigger rule
├── skills/seo/                    # Full Agentic SEO Skill (scripts, agents, references)
├── commands/graphify.md           # /graphify slash command docs
└── hooks/                         # Auto-sync graph after edits & git pulls
    ├── graphify-after-edit.sh
    ├── graphify-query-reminder.sh
    └── graphify-sync.sh
```

| Component | Source | Purpose |
|-----------|--------|---------|
| Karpathy guidelines | Inspired by [Andrej Karpathy's LLM coding principles](https://x.com/karpathy) | Think before coding, simplicity first, surgical diffs, verifiable goals |
| Graphify | [safi-shamsi/graphify](https://github.com/safishamsi/graphify) | AST-based knowledge graph (`graphify-out/graph.json`) for `query`, `explain`, `path`, `affected` |
| Agentic SEO Skill | [Bhanunamikaze/Agentic-SEO-Skill](https://github.com/Bhanunamikaze/Agentic-SEO-Skill) | Technical SEO, schema, Core Web Vitals, E-E-A-T, GEO, AEO, GitHub repo SEO |

---

## Prerequisites

| Requirement | Notes |
|-------------|-------|
| [Cursor](https://cursor.com) | Desktop IDE with Agent mode |
| [Graphify CLI](https://github.com/safishamsi/graphify) | Installed via `pip install graphifyy` (CLI command: `graphify`) |
| Python 3.8+ | Optional — only needed for SEO skill scripts |
| `requests`, `beautifulsoup4` | Optional — `pip install requests beautifulsoup4` for SEO evidence scripts |
| Playwright | Optional — visual SEO analysis (`pip install playwright && playwright install chromium`) |

---

## Quick Start — Use in Your Project

Copy the Cursor configuration into an existing repository and build the knowledge graph:

```bash
# 1. Clone Karcursifyeo (or add as a submodule)
git clone https://github.com/Abhir1902/Karcursify.git karcursifyeo

# 2. Copy .cursor/ into your project root
cp -R karcursifyeo/.cursor /path/to/your-project/

# 3. Open your project in Cursor and build the graph
cd /path/to/your-project
graphify update .

# 4. Open Cursor Agent and ask a graph-first question
#    e.g. "What calls the auth middleware?"
```

Commit `.cursor/` to share the setup with your team. Do **not** commit `graphify-out/` — it is regenerated locally.

---

## Step-by-Step Setup Guide

Follow these steps to adopt Karcursifyeo in a new or existing project.

### Step 1 — Install Graphify

Install the Graphify CLI so agents can build and query the knowledge graph:

```bash
# Requires Python 3.10+
pip install graphifyy
graphify install --platform cursor

# Verify installation
graphify --help
which graphify
```

For full installation options across 20+ AI coding assistants, see the [Graphify documentation](https://graphify.net/).

### Step 2 — Copy the `.cursor/` Directory

```bash
git clone https://github.com/Abhir1902/Karcursify.git /tmp/karcursifyeo
cp -R /tmp/karcursifyeo/.cursor ./your-project/
```

Alternatively, fork Karcursifyeo and use it as your project template.

### Step 3 — Open the Project in Cursor

Open the project folder in Cursor. The bundled configuration activates automatically:

- **`kaprpathy-guidelines.mdc`** — always applied to every Agent session
- **`seo.mdc`** — activates when you mention SEO-related tasks
- **Hooks** — keep the graph in sync after file edits and remind agents to query the graph first

### Step 4 — Build the Knowledge Graph

From your project root:

```bash
graphify update .
```

This generates `graphify-out/graph.json` (local only, do not commit). Re-run after large refactors or `git pull`:

```bash
graphify update .          # normal refresh
graphify update . --force  # after deletions / major restructures
```

### Step 5 — Verify Graphify in Cursor Agent

In Cursor chat, type `/graphify` or ask:

```
What is the main entry point of this project?
```

The agent should consult `graphify query` before raw file searches. Try these CLI commands yourself:

```bash
graphify query "What handles authentication?"
graphify explain "main"
graphify path "login" "database"
graphify affected "UserService"
```

### Step 6 — Toggle Graphify On or Off

Use the `/graphify` command in Cursor:

| Command | Effect |
|---------|--------|
| `/graphify off` | Creates `.cursor/graphify.disabled` — pauses graph updates and graph-first reminders |
| `/graphify on` | Removes the flag — re-enables graph sync hooks |

Or manually:

```bash
touch .cursor/graphify.disabled   # disable
rm -f .cursor/graphify.disabled   # enable
```

### Step 7 — (Optional) Install SEO Script Dependencies

For full SEO evidence collection (PageSpeed, crawl audits, schema validation):

```bash
pip install requests beautifulsoup4

# Optional: visual / screenshot analysis
pip install playwright && playwright install chromium
```

Copy `.env.example` from the [Agentic SEO Skill repo](https://github.com/Bhanunamikaze/Agentic-SEO-Skill) if you need API keys (PageSpeed, GitHub token, GSC credentials).

### Step 8 — Commit and Share with Your Team

```bash
git add .cursor/
git commit -m "Add Karcursifyeo Cursor toolkit (Karpathy rules, Graphify, SEO skill)"
git push
```

Each teammate runs `graphify update .` once after cloning.

### Step 9 — Daily Workflow

1. **Before asking the agent to explore code** — ensure the graph is current (`graphify update .` after pulls).
2. **When implementing features** — Karpathy rules keep diffs minimal and goal-driven.
3. **When auditing SEO** — ask naturally: *"Run an SEO audit on example.com"* or *"Optimize this repo for GitHub search"*.
4. **After git pull/merge** — hooks remind the agent to refresh the graph; run `graphify update .` if needed.

---

## Karpathy Behavioral Guidelines

Located at `.cursor/rules/kaprpathy-guidelines.mdc` and set to **always apply**.

These six principles guide every Agent session:

1. **Think before coding** — state assumptions, surface tradeoffs, ask when unclear
2. **Simplicity first** — minimum code that solves the problem; no speculative abstractions
3. **Surgical changes** — touch only what the request requires; match existing style
4. **Goal-driven execution** — define verifiable success criteria before implementing
5. **Use Graphify for codebase queries** — query the graph before raw file reads
6. **Keep the graph in sync with git** — refresh after pulls and merges

These rules reduce common LLM mistakes: unnecessary refactors, scope creep, and expensive full-repo scans.

---

## Graphify Knowledge Graph

Graphify builds a language-agnostic AST graph of your codebase in `graphify-out/`.

### Cursor Integration

| Feature | Location | Behavior |
|---------|----------|----------|
| Slash command | `.cursor/commands/graphify.md` | Document `/graphify on\|off` and update instructions |
| Query reminder | `hooks/graphify-query-reminder.sh` | Injects graph-first context on every prompt |
| Auto-update on edit | `hooks/graphify-after-edit.sh` | Runs `graphify update .` after agent file edits |
| Post git pull reminder | `hooks/graphify-sync.sh` | Reminds agent to refresh graph after `git pull` / `git merge` |

### CLI Reference

```bash
graphify update .                              # rebuild graph
graphify query "What is the payment flow?"     # BFS traversal Q&A
graphify explain "AuthService"                   # node + neighbors
graphify path "login" "database"               # shortest dependency path
graphify affected "UserRepository"             # downstream impact
```

**Tip:** Set `GEMINI_API_KEY` or `GOOGLE_API_KEY` for optional semantic extraction during graph builds.

---

## Agentic SEO Skill

Bundled from [Agentic-SEO-Skill](https://github.com/Bhanunamikaze/Agentic-SEO-Skill) — an LLM-first SEO analysis toolkit for agent IDEs.

### Capabilities

| Area | Sub-skills |
|------|------------|
| Site audits | Full audit, single page, article, technical, content, sitemap, images |
| Advanced SEO | Schema, hreflang, links, programmatic SEO, competitor pages |
| AI search | GEO (Generative Engine Optimization), AEO (Answer Engine Optimization) |
| GitHub | Repo metadata, README quality, topics, community health, search benchmarking |
| Strategy | Topical clusters, industry templates (SaaS, e-commerce, local, publisher) |

### How It Activates in Cursor

The SEO skill auto-triggers when you mention SEO-related keywords. Examples:

- *"Run an SEO audit on https://example.com"*
- *"Check schema markup on my homepage"*
- *"Analyze Core Web Vitals for my site"*
- *"Run GitHub SEO analysis for owner/repo"*
- *"Create an SEO plan for my SaaS product"*

### Specialist Agents

Technical SEO · Content Quality · Performance · Schema Markup · Sitemap · Visual Analysis · GitHub Analyst · GitHub Benchmark · GitHub Data · Verifier

### Key Scripts (89 total)

| Script | Purpose |
|--------|---------|
| `audit_runner.py` | One-command full audit → JSON, HTML, `FULL-AUDIT-REPORT.md`, `ACTION-PLAN.md` |
| `generate_report.py` | Shareable HTML SEO dashboard |
| `github_seo_report.py` | GitHub repo SEO report + action plan |
| `pagespeed.py` | Core Web Vitals via PageSpeed Insights |
| `parse_html.py` | Extract titles, meta, headings, links, schema |
| `robots_checker.py` | Crawler policy and AI bot access |

Run from `.cursor/skills/seo/scripts/` or let the Agent invoke them during audits.

For full documentation, example prompts, and installer options, see the [Agentic SEO Skill Wiki](https://github.com/Bhanunamikaze/Agentic-SEO-Skill).

---

## Repository Structure

```
Karcursifyeo/
├── .cursor/
│   ├── rules/              # Cursor rules (Karpathy + SEO trigger)
│   ├── skills/seo/         # Agentic SEO Skill (SKILL.md, scripts, agents, references)
│   ├── commands/           # Cursor slash command definitions
│   └── hooks/              # Graphify sync & query reminder hooks
├── graphify-out/           # Generated knowledge graph (gitignored, local only)
├── LICENSE                 # MIT
└── README.md               # This file
```

Karcursifyeo is intentionally **configuration-only** — no application runtime. Copy `.cursor/` into any language or framework.

---

## Example Prompts

### Codebase exploration (Graphify-first)

```
What modules depend on the database layer?
```

```
If I change the auth middleware, what files are affected?
```

### Feature development (Karpathy-guided)

```
Add email validation to the signup form. Keep the diff minimal and match existing patterns.
```

### SEO audits

```
Run a full SEO audit for https://example.com and prioritize fixes by impact.
```

```
Analyze technical SEO for https://example.com — robots, crawlability, canonicals, Core Web Vitals.
```

```
Run GitHub SEO analysis for Abhir1902/Karcursify and suggest topics and README improvements.
```

---

## GitHub Repository SEO Tips

Recommended **About** description for this repo:

```
Open-source Cursor AI toolkit (Karcursifyeo): Karpathy coding rules, Graphify knowledge graph, and Agentic SEO Skill — reduce LLM token usage and ship safer agent-assisted code.
```

Suggested **Topics**:

```
cursor, cursor-ai, ai-coding, karpathy, graphify, knowledge-graph, llm, seo, karcursifyeo, technical-seo, agentic-seo, cursor-rules, cursor-skills, developer-tools, token-optimization
```

Audit your own README anytime:

```
Run GitHub SEO analysis for this repository and lint the README.
```

---

## Credits & License

| Component | Credit |
|-----------|--------|
| Karcursifyeo | [Abhir Mirikar](https://github.com/Abhir1902) — MIT License |
| Karpathy guidelines | Inspired by [Andrej Karpathy's](https://x.com/karpathy) LLM coding best practices |
| Agentic SEO Skill | [Bhanunamikaze/Agentic-SEO-Skill](https://github.com/Bhanunamikaze/Agentic-SEO-Skill) — MIT License |
| Graphify | [safi-shamsi/graphify](https://github.com/safishamsi/graphify) — MIT License |

Licensed under the [MIT License](LICENSE).

---

## Contributing

Contributions are welcome. To improve Karcursifyeo:

1. Fork the repository
2. Create a feature branch (`git checkout -b improve-docs`)
3. Make focused changes — match the surgical-change philosophy
4. Open a pull request with a clear description of what changed and why

**Report issues:** [GitHub Issues](https://github.com/Abhir1902/Karcursify/issues)

**Upstream SEO skill updates:** Re-install or sync from [Agentic-SEO-Skill](https://github.com/Bhanunamikaze/Agentic-SEO-Skill) using their installer:

```bash
curl -fsSL https://raw.githubusercontent.com/Bhanunamikaze/Agentic-SEO-Skill/main/install.sh | bash -s -- --online --target cursor --project-dir /path/to/your/project
```

---

<p align="center">
  <strong>Karcursifyeo</strong> — smarter Cursor agents, fewer tokens, built-in SEO.<br>
  <a href="https://github.com/Abhir1902/Karcursify">github.com/Abhir1902/Karcursify</a>
</p>
