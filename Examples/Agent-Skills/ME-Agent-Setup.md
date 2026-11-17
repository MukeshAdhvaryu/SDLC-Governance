# Example: how one project set up its agent skills

This document is **strictly an example** for [AGENT-SKILLS-POLICY.md](../../Policies/AGENT-SKILLS-POLICY.md). MachineEnglish (ME) is the author's own
research project, a programming language with a C# compiler. Its setup suits that
project. Other projects may have no use for the specifics, and should apply only the
rules in the policy.

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
