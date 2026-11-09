# DFR-003: Layer Rules Ratified in ADR-003 but No Architecture Test Exists

**Date:** 2026-02-16
**Status:** In Progress
**Kind:** Non-implementation
**Area:** Tests - architecture rules
**Owner:** Platform team
**Approved by:** Technical lead (Platform team)

---

> **Status legend:** [x] Shipped - [ ] Not done - [~] Partial - [*] WIP - [.] Deferred - [!] Cancelled

## Status

| ID | Status | Task | Owner | Evidence |
|----|--------|------|-------|----------|
| DFR-003-T01 | Done | Choose the architecture-test tool and record it in ADR-003. | Platform team | ADR-003 amended: ArchUnitNET selected. `c3d4e5f` |
| DFR-003-T02 | Done | Write a test asserting that `src/Core` has no reference to `src/Infrastructure`. | Platform team | `tests/Architecture/LayerRuleTests.cs` - `Core_Does_Not_Reference_Infrastructure`. `c3d4e5f` |
| DFR-003-T03 | [*] | Add a second rule: only `src/API` may reference `src/Infrastructure`. | Platform team | Test written; fails on `ReportController` (see Current behavior). |
| DFR-003-T04 | [ ] | Run the architecture tests in the CI pipeline as a required check. | DevOps | Not started. |
| DFR-003-T05 | [ ] | Update the ADR-003 status row to Shipped, citing the test names. | Platform team | Pending T03 and T04. |

---

## Drift

ADR-003 ratified two rules: Core must not reference Infrastructure, and
dependencies flow inward only. The ADR's own status table lists a fourth item,
"Architecture test enforcing layer rules", as not done.

Nothing is broken today. The rules are met by the code as it stands. But the
decision promises that the rules are enforced, and nothing enforces them. The
next developer to add an Infrastructure reference to Core will get no failure
and no warning. This is a **non-implementation**: ratified design with no
implementation behind part of it.

---

## Intended Design

Per ADR-003, layer rules are checked by an automated architecture test that fails
the build when a forbidden reference appears. A rule that exists only in a
document and in reviewers' memory is not enforced.

---

## Current Behavior

- `tests/Architecture/` did not exist when this DFR was filed.
- The ADR-003 status row for the architecture test reads `[ ]`.
- While writing the second rule (T03), the test found a real violation:
  `ReportController` in `src/API` instantiates `SqlOrderRepository` directly. That
  is a defect, and it is tracked as a separate DFR rather than hidden here.

---

## Root Cause

The ADR was accepted with its enforcement item deferred to "later", and no work
item was created for it. Nobody owned "later".

---

## Decision

**Implement the ratified design.** Build the architecture tests and make them a
required CI check. The defect found along the way is filed as its own DFR.

---

## Journey Log

```
2026-02-16 - Filed by a developer on the Platform team after noticing the open
             row in ADR-003. Approved by the technical lead the same day.
2026-02-17 - T01 and T02 complete. ArchUnitNET chosen; first rule passing.
2026-02-18 - T03 started. Second rule fails on ReportController; new defect DFR
             to be filed for it. T03 stays in progress until that DFR closes.
```

---

## References

- ADR: [ADR-003-Layered-Architecture.md](../ADRs/ADR-003-Layered-Architecture.md)
- Roadmap: [RDMP-Core.md](../Roadmap/RDMP-Core.md) (known gap: architecture enforcement test)
- Affected files: `tests/Architecture/LayerRuleTests.cs`
