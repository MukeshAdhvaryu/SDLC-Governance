# Drift Resolution Policy

Drifts are architectural bugs. A drift records a gap between intended design
and the behavior, implementation, tests, or documentation currently present in
the repository.

Drifts are more serious than ordinary defects because they can normalize the
wrong model over time. Each drift record must preserve the journey from discovery
to closure.

---

## File Naming

Use this format:

```text
DFR-###-Short-Drift-Name.md
```

Examples:

```text
DFR-001-Module-Resolution-Drift.md
DFR-002-Visibility-Boundary-Drift.md
```

---

## Required Sections

Each DFR file uses this structure:

```md
# DFR-###: Title

**Date:** YYYY-MM-DD
**Status:** Open | In Progress | Blocked | Resolved | Superseded
**Area:** Short subsystem name
**Owner:** Person or role

---

## Drift

State the observed design/behavior shift.

## Intended Design

State the canonical behavior the system must preserve.

## Current Behavior

Point to implementation, docs, tests, or commits that show the drift.

## Decision

State the resolution direction.

## Resolution Tasks

Use a status-aware task table.

## Journey Log

Append dated notes as work proceeds.

## References

List files, ADRs, specs, tests, commits, or discussions.
```

---

## Status Values

Use only these task statuses:

| Status | Meaning |
|--------|---------|
| `Not Started` | Known work, no implementation begun. |
| `In Progress` | Actively being changed. |
| `Blocked` | Cannot proceed until another decision or task completes. |
| `Review` | Implemented and awaiting review. |
| `Done` | Completed and verified. |
| `Superseded` | No longer needed because another decision replaced it. |

The DFR top-level status follows the same lifecycle, but uses `Open`,
`In Progress`, `Blocked`, `Resolved`, or `Superseded`.

---

## Task Table Format

Use this table shape:

| ID | Status | Task | Owner | Evidence |
|----|--------|------|-------|----------|
| DFR-###-T01 | Not Started | Concrete action. | Role/person | File, test, commit, or pending proof. |

Evidence should become concrete before a task moves to `Done`.

---

## Closure Criteria

A drift can be marked `Resolved` only when:

1. The canonical design is documented.
2. The implementation follows the design.
3. Regression tests protect the behavior.
4. Obsolete contradictory wording or code paths are removed or marked superseded.
5. The journey log records the final verification.
