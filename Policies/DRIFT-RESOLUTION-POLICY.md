# Drift Resolution Policy

A drift is a gap between the ratified design and what the repository currently
holds: behavior, implementation, tests, or documentation. A drift takes one of
two forms:

1. **Defect (divergence).** Something exists and contradicts the ratified
   design: a bug, a wrong behavior, a test that asserts the wrong model, a
   document that says the wrong thing.
2. **Non-implementation (absence).** The design is ratified and the
   implementation is missing or only partly there. Nothing is wrong yet; what
   the design promises is not delivered. An unimplemented decision is drift
   exactly as a mis-implemented one is, because the repository and the design
   disagree.

Both forms are recorded as DFRs. A DFR is not only a list of holes in what was
built; it also records what was decided and not built.

Drifts are more serious than ordinary defects because they can normalize the
wrong model over time (defects), or leave a ratified decision looking delivered
when it is not (non-implementation). Each drift record must preserve the journey
from discovery to closure.

---

## The DFR is the unit of work

The DFR is the **unit of work (UOW)**. Every piece of work that moves the
repository toward the ratified design is tracked as a DFR, whether it fixes a
defect or builds what is missing.

### Three altitudes, three audiences

The roles below are roles, not job titles. One person can fill several.

| Document | Created by | Read by / used in |
|----------|------------|-------------------|
| **ADR, MD** (architecture decisions) | Architects and principal engineers | Technical leads and senior engineers, who implement from them. They carry the decision and its rationale. |
| **RDMP** (roadmap) | Technical leads and senior engineers | Presented in higher-level group meetings and sprint planning (what ships, in what order, why). Read downstream by the dev teams that deliver it. |
| **DFR** (drift fix report) | Any member of the dev team | The dev team's daily material and stand-ups: what is being done today, what is blocked, what is the evidence. |

The architecture documents say what was decided and why. The roadmap says what
was committed. The DFR says how it is being delivered.

### Rules

- **Approval.** A DFR created by a team member is proposed until the technical
  lead, lead developer or senior engineer in charge approves it. Record the
  approver in the `Approved by` header line. No work starts before approval.
- **One address.** Pending roadmap rows are recorded in a DFR. An umbrella DFR
  per roadmap is acceptable while no focused DFR exists.
- **One status.** Where a DFR covers a roadmap row, the DFR task row is where
  status moves first. The roadmap row mirrors it and cites the DFR and task id,
  so a roadmap row's status is the roll-up of its DFR tasks.
- **Umbrella and focused DFRs.** An umbrella DFR is a ledger for many rows and
  makes no claim that each is a defect. When work starts on a task or cluster,
  file a focused DFR, reference it from the umbrella row, and update status in
  the DFR first.
- **No work without a DFR.** Work does not start until a DFR (or an ADR/MD that
  a DFR will carry) exists.

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
**Kind:** Defect | Non-implementation | Both (optional; no Kind means Defect)
**Area:** Short subsystem name
**Owner:** Person or role
**Approved by:** Technical lead, lead developer or senior engineer in charge (required before work starts)

---

## Drift

State the observed gap: either behavior that contradicts the ratified design
(defect), or ratified design that is not implemented (non-implementation).

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
2. The implementation follows the design (for a non-implementation, the
   implementation exists and follows it).
3. Regression tests protect the behavior.
4. Obsolete contradictory wording or code paths are removed or marked superseded.
5. The journey log records the final verification.

An umbrella DFR closes only when every task is done, deferred with a recorded
trigger, or cancelled with a recorded reason.
