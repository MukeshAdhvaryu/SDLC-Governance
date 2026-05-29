# Contributing to SDLC-Governance

This repository contains engineering policies, document templates, and project
structure guidelines. Contributions are welcome.

---

## What Belongs Here

**Yes:**
- Policies that apply to any project regardless of language or platform
- Improvements to existing policies that fix gaps or remove ambiguity
- New document templates that address a real workflow need
- Example documents that demonstrate templates in use
- Tooling that enforces the policies mechanically

**No:**
- Language-specific or framework-specific rules (those belong in the project that needs them)
- Policies that reflect one team's preferences rather than sound engineering principles
- Governance theatre - rules that sound professional but have no enforcement path

---

## Versioning Model

This repository uses semantic versioning. Tags follow `vMAJOR.MINOR.PATCH`.

| Change type | Version bump | Examples |
|-------------|-------------|---------|
| Breaking | MAJOR | Removing a rule, changing a required table column, renaming a policy file |
| Additive | MINOR | New policy, new template, new example document |
| Clarification | PATCH | Fixing a typo, improving an example, adding a note |

Projects that adopt these policies should pin to a version tag rather than
following `main`. This prevents unreviewed changes from silently affecting
in-flight work.

```
# In your project README or DIP, note which version you adopted:
# Governance: https://github.com/MukeshAdhvaryu/SDLC-Governance @ v1.2.0
```

---

## Proposing a New Policy

1. Open an issue describing the problem the policy solves. State:
   - What goes wrong without the policy
   - Why existing policies do not cover it
   - Whether you have applied this policy in a real project

2. If the issue is accepted, write the policy following the style guide below
   and open a pull request.

3. The policy must include:
   - A clear **Purpose** section stating what it governs
   - Concrete **rules** (not suggestions)
   - At least one **example** of the rule applied and violated
   - No language-specific code in the primary text (code examples go in a
     language-agnostic pseudocode block or a separate section)

---

## Proposing a Change to an Existing Policy

1. Open an issue citing the specific rule you want to change and the reason.
2. If the change removes or weakens a rule, explain what problem that rule
   was causing in practice.
3. If the change adds or strengthens a rule, explain what the policy was
   missing and provide evidence.
4. Open a pull request referencing the issue.

Breaking changes (see versioning above) require stronger justification than
clarifications. A rule that has been in use for over a year should not be
changed without evidence that it is causing more harm than good.

---

## Style Guide

These rules apply to all documents in this repository.

- **No em dashes.** Use a hyphen (`-`) instead of `—` everywhere.
- **Status tables use ASCII symbols** `[x]` `[ ]` `[~]` `[*]` `[.]` `[!]`.
  See [WORK-DONE-POLICY.md](Policies/WORK-DONE-POLICY.md).
- **Short sentences.** A sentence that needs a semicolon probably needs to be
  two sentences.
- **Tables over prose** for lists of rules, options, or comparisons.
- **Headers use sentence case**, not title case. "Why this exists" not
  "Why This Exists".

---

## Tooling Contributions

The `Tools/` folder contains validation scripts that enforce policies mechanically.

When adding a new check to the validator:
1. Add it to both `validate-governance.ps1` (PowerShell) and
   `validate-governance.sh` (Bash) so the check works on all platforms.
2. New checks that produce errors must have a corresponding policy or rule that
   justifies them. Add the policy reference in the script comment.
3. New checks that are judgment calls (ambiguous, style-dependent) must be
   `--strict` mode only, not default.
4. Update the `README.md` check list if the new check is user-visible.

---

## Pull Request Checklist

Before opening a pull request:

- [ ] No em dashes in any modified file
- [ ] Status tables use ASCII symbols only
- [ ] All links in modified files resolve
- [ ] If adding a new policy: Purpose, rules, and examples are all present
- [ ] If adding a new template: instructions explain every section
- [ ] If adding an example document: it is filled out, not skeleton
- [ ] `Tools/validate-governance.ps1` passes on the Examples/ folder
