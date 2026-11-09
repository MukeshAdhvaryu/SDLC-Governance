# Agent skills policy

> An AI coding agent knows only what you put in front of it. A skill file is where you put it.

## Purpose

This policy governs the instruction documents ("skill files") that AI coding agents
read at the start of a session, and how those files connect to the project's
governance policies and tooling.

It answers four questions:

1. What is a skill file, and what belongs in it?
2. Which policies must it link to?
3. How do agents reach project tooling (MCP servers, CLIs) in a controlled way?
4. How are multi-agent task assignment and model routing configured?

The generic rules come first. One project's setup is given at the end, strictly as
an example. Other projects may have no use for its details.

---

## What a skill file is

A skill file is a markdown document an agent reads before it works. Each tool has its
own name for it:

| Agent | Typical entry file | Notes |
|-------|--------------------|-------|
| Claude Code | `CLAUDE.md` at the repository root | Read automatically at session start. |
| Codex | `AGENTS.md` at the repository root | Often a short pointer to a fuller skill file. |
| Others | Tool-specific | Same pattern: a file the agent is told to read first. |

A skill file is **code for the agent**. It has an author, it is reviewed, it is
versioned with the repository, and it goes stale. Treat it that way.

---

## Rules

### 1. Link policies, do not copy them

The skill file points at the policy documents. It does not paste their text.

- The policies are the authoritative source. The skill file says so, and says that
  on any conflict the policy wins.
- Copied text drifts. A link cannot.
- Add a short "when to apply" note per link, so the agent knows which policy to open
  for which task.

### 2. Link the policies that govern how work is done

At minimum, link these (or their equivalents in your project):

| Policy | What it governs | Tell the agent to apply it when |
|--------|-----------------|---------------------------------|
| [WORK-DONE-POLICY.md](WORK-DONE-POLICY.md) | Decision flow, status tables, what "done" means, commit-to-decision traceability | Closing any task, feature or milestone; writing any commit |
| [DRIFT-RESOLUTION-POLICY.md](DRIFT-RESOLUTION-POLICY.md) | The DFR as the unit of work; defects and non-implementations; approval | Starting, updating or closing any work item |
| [SOLIDE-DESIGN-POLICY.md](SOLIDE-DESIGN-POLICY.md) | Single-role constructs, substitutability, explicit extension | Designing any interface, contract or capability |
| [BEST-ENGINEERING-POLICY.md](BEST-ENGINEERING-POLICY.md) | Constants, nesting depth, SOLID basics | Any code change |
| [TESTING-STANDARDS-POLICY.md](TESTING-STANDARDS-POLICY.md) | Contract-first testing, anti-patterns | Writing, reviewing or extending any test |
| [NAMING-CONVENTION-POLICY.md](NAMING-CONVENTION-POLICY.md) | Naming and namespace alignment | Any new symbol, file or project |
| [DOCUMENTATION-POLICY.md](DOCUMENTATION-POLICY.md) | Documentation tiers, index pages, cross-references | Any new ADR, spec, roadmap or policy |

The work-done policy comes first in the list on purpose. It defines the chain from
decision to commit to test, and the traceability rule that every commit can be traced
back to its original decision.

### 2a. Make the commit rule explicit

Do not rely on the agent inferring the commit convention. State in the skill file:

- the commit message format,
- that the message names the work item (DFR task) and its backing decision,
- whether the agent may commit on its own or must show the message and wait for a yes.

### 3. Use a small entry file that forces the read

If the skill file is long, keep the entry file (`AGENTS.md`) to a few lines that say:

1. read the skill file before doing anything else,
2. treat it as mandatory,
3. if it cannot be read, stop and report the blocker.

This removes the most common failure: an agent that starts work without the rules.

### 4. Name the official tool for each task

For every kind of task that has an official tool (a CLI, an MCP server), say which
tool to use, and what to do first and last.

- State a discovery order, for example: semantic tool first, index documents second,
  text search last.
- Say what the agent must never do, for example: use text search to locate symbols
  when a semantic tool exists.
- List the tool commands the agent may run without asking. Keep the list read-only
  where possible.

### 5. Put the hard rules in the file

Rules the agent must never break belong in the skill file, not in conversation.
Typical hard rules:

- branch policy and who may merge,
- no push until told,
- no spawning of other agents, if cost or context is a concern,
- encoding and formatting rules that tools silently break,
- session-length guidance (when to start a fresh session),
- prohibited actions and output rules.

### 6. Describe roles, not just rules

If more than one agent works on the project, give each a working name and a role.
State who reviews whose work. A reviewer agent's findings must be addressed or
explicitly declined with a reason.

### 7. Tool access goes through MCP or a CLI facade

Agents reach project tooling through a controlled interface:

- **MCP server.** A local server exposes tools (code search, references, analysis).
  The project registers it in a checked-in config file so every agent session gets
  the same servers.
- **CLI facade.** A single command-line tool fronts the server, so every agent, in
  any shell, uses the same plain commands. The CLI is then the contract; agents do
  not need to know how the server is wired.

Pick one as the contract and document it. Do not let each agent invent its own route.

### 8. Orchestration is configuration, not conversation

When several models or agents share work, task assignment is written down in a
config file, not decided per session. The config defines:

| Part | Purpose |
|------|---------|
| Models | Named models with provider, model id, limits and a note on strengths. |
| Routing | Task type (reasoning, refactor, implementation, tests, analysis, search, summary) mapped to a model. |
| Fallback | What to use when a model is rate-limited or unavailable. |
| Overrides | Phrases the user can say ("use the reasoning model") that beat the routing. |

Rules for the config:

- **JSON, checked in.** Reviewed like code.
- **One source of truth.** The config is authoritative. Prose tables in the skill file
  describe it; they do not duplicate it. If they disagree, fix the prose.
- **Secrets stay out.** API keys live in a separate file that is git-ignored. Never
  in the routing config, never in a skill file.
- **Announce the route.** The skill file tells the agent to state which model it
  selected before spending effort, so the user can correct it.
- **Verify at startup.** Give the agent one command that prints the active routing
  table. If it fails, the agent stops and reports.
- **Isolate parallel agents.** Give each parallel session its own context key so
  sessions do not collide on shared server state.

### 9. Test the skill file

After editing a skill file, start a fresh session and check:

- the agent can state the rules that matter most,
- the verify command passes,
- a deliberately forbidden request is refused or flagged.

A skill file that was never tested is a guess.

### 10. Keep it current

- Review the skill file whenever a policy or tool changes.
- Remove rules that no longer apply. A stale rule teaches the agent to ignore rules.
- Rebuild or restart any local server after its code changes, or the agent will query
  a stale binary and trust wrong answers.

### 11. Security and access

- Grant the narrowest permissions that work. Prefer an allowlist of specific commands.
- Run agents in a sandbox where the tool supports it.
- Never place secrets, tokens or personal data in a skill file or a committed config.

---

## Applied and violated

| Rule | Applied | Violated |
|------|---------|----------|
| 1. Link, do not copy | "Work-done rules: see WORK-DONE-POLICY. On conflict, the policy wins." | Half the work-done policy pasted into the skill file, two months out of date. |
| 3. Entry file forces the read | `AGENTS.md`: "Read the skill file first. If you cannot, stop and report." | No entry file. The agent starts editing before it has seen any rule. |
| 4. Name the tool | "Find symbols with the semantic tool. Use text search only if it does not apply." | "Search the code for the function." The agent greps and misses overloads. |
| 8. Config, not conversation | Routing in a checked-in JSON file; the skill file says "announce the model". | "Use the best model for the job." Each session picks differently. |
| 8. Secrets stay out | Keys in a git-ignored file; routing config contains no keys. | An API key pasted into the routing config and committed. |

---

## Skeleton for a skill file

A tool-agnostic outline. Keep each section short and link out.

```text
# <Project> agent skill

Startup            - what to run or read first; the verify command
Obedience          - policies are authoritative; policy wins on conflict
Governing policies - table: policy, what it governs, when to apply
Roles              - agent names, who reviews whom
Tools              - official tool per task; discovery order; forbidden shortcuts
Hard rules         - branch, push, encoding, prohibited actions
Commit rule        - format; names DFR task and backing decision; confirm first?
Verification       - the chain from WORK-DONE-POLICY; what counts as done
Orchestration      - where the routing config lives; announce the route
Session length     - when to start fresh
```

---

## Example: how one project did it

This section is **strictly an example**. MachineEnglish (ME) is the author's own
research project, a programming language with a C# compiler. Its setup suits that
project. Other projects may have no use for the specifics, and should apply only the
rules above.

### The files

| File | Role |
|------|------|
| `CLAUDE.md` | Skill file for Claude. Read automatically. Holds the governing-policy table, tool rules, branch and commit rules, and routing guidance. |
| `AGENTS.md` | Entry file for Codex. A few lines: read `Codex-Skill.md` first, treat it as mandatory, stop and report if unreadable. |
| `Codex-Skill.md` | Skill file for Codex. Numbered sections: startup, no subagents, governing policies, working names, tool rules, workflow, prohibited actions, model routing, commit rule, verification flow. |
| `.vscode/.mcp.json` | Registers the MCP servers. |
| `.vscode/me-mcp.config.json` | The orchestration config: models, routing, fallback, overrides. |
| `.vscode/me.mcp.keys.json` | API keys. Git-ignored. |
| `.claude/settings.json` | Permission allowlist and sandbox switch. |

### MCP server registration

A server is registered by name, with its transport, command and arguments. Aliases let
a user say "the compiler solution" instead of a path.

```json
{
  "mcpServers": {
    "roslyn": {
      "type": "stdio",
      "command": "<path>/ME.MCP.exe",
      "args": ["--input", "<path>/ME.CS.slnx"]
    }
  },
  "solutionAliases": {
    "me": "<path>/ME.CS.slnx"
  }
}
```

The server wraps a Roslyn workspace, so agents can ask semantic questions about C#
code: symbol definitions, references, call graphs, summaries.

### The CLI facade

ME fronts the MCP server with its own command-line tool, `me-tools`. The skill file
declares it mandatory and names the contract: "the CLI is the contract".

```text
agent -> me-tools roslyn <tool> --key value -> ME.MCP daemon -> Roslyn workspace
```

- The daemon auto-starts on the first call and stays warm for every agent.
- Flag names match the server tool's parameter names.
- `me-tools` also fronts the project's other tasks (compile, format, grammar
  regeneration, migration), so agents do not call raw compilers or scripts.
- The skill file sets a discovery order: Roslyn first for C# symbols, the document
  index pages second for repository paths, text search last.
- Each parallel agent session uses its own context key, so two agents do not share
  one daemon pipe by accident.
- After C# changes the daemon binary is stale. The skill file requires a restart
  script before relying on its answers (rule 10).

### Permissions

The allowlist lets the agent run read-only and build commands without prompting,
inside a sandbox:

```json
{
  "sandbox": { "enabled": true },
  "permissions": {
    "allow": [
      "Bash(dotnet build *)",
      "Bash(dotnet test *)",
      "Bash(me-tools roslyn *)"
    ]
  }
}
```

### The orchestration config

Task types map to models. Models have notes on their strengths. A fallback chain
covers rate limits. Overrides let the user force a model by phrase. Trimmed:

```json
{
  "default_model": "<fast-general-model>",
  "models": {
    "reasoning_model": { "provider": "<p>", "model": "<id>", "note": "architecture, design" },
    "code_model":      { "provider": "<p>", "model": "<id>", "note": "implementation, test fixes" },
    "fast_model":      { "provider": "<p>", "model": "<id>", "note": "analysis, search, summaries" }
  },
  "routing": {
    "reasoning": "reasoning_model",
    "refactor": "reasoning_model",
    "implementation": "code_model",
    "fix_tests": "code_model",
    "analysis": "fast_model",
    "search": "fast_model",
    "summaries": "fast_model"
  },
  "fallback": { "reasoning_model": "fast_model", "code_model": "fast_model" },
  "overrides": { "use the reasoning model": "reasoning_model" }
}
```

The skill files add three behaviours on top of the config:

1. **Announce the model before acting.** The agent prints which model it selected
   for the task, so the user can correct the route before effort is spent.
2. **Verify at startup.** One command (`me-tools roslyn route_info`) prints the
   routing table. If it does not print, the agent stops.
3. **Explicit override wins.** If the user names a model, it beats keyword routing.

### Roles

The two agents have working names. One does the implementation work. The other
reviews it and rarely edits code; its findings must be addressed or declined with a
reason (rule 6).

### What generalises

The parts worth copying are the pattern, not the details:

- an entry file that forces the read,
- links to the policies, with "when to apply",
- one CLI or MCP route to the tools, with a discovery order,
- routing and fallback in a checked-in JSON file, secrets in a separate ignored file,
- announce the route, verify at startup, restart after changes.

Everything else in this example (the language, the solution layout, the daemon, the
specific models) is incidental.
