# MD-002: Documentation Before Code

**Date:** 2026-01-20
**Status:** Accepted
**Author:** Platform team

---

> **Status legend:** [x] Shipped - [ ] Not done - [~] Partial - [*] WIP - [.] Deferred - [!] Cancelled

## Status

| Sub-topic | Related Area | Status | Notes | Commit | Date |
|-----------|--------------|--------|-------|--------|------|
| Decision ratified | Architecture | [x] | - | - | 2026-01-20 |
| DIP.md created at repo root | Repository | [x] | - | `j0k1l2m` | 2026-01-21 |
| README rewritten to four-question format | Repository | [x] | What/State/Build/Where structure | `k1l2m3n` | 2026-01-22 |
| ADR index added to README | Repository | [x] | - | `l2m3n4o` | 2026-01-22 |
| Architecture folder created with policy set | Repository | [x] | - | `m3n4o5p` | 2026-01-22 |

---

## The Problem

The project started with no README beyond a one-line description. ADRs did not exist.
When new engineers joined they needed two to three pairing sessions to understand
what the project did, what decisions had been made, and where to find things.

When a decision was revisited six months later, nobody could reconstruct the original
reasoning. Time was spent re-arguing decisions that had already been made, often
reaching a different conclusion from the first time.

---

## Decision

Documentation is written before code, not after.

The five-tier documentation model from
[DOCUMENTATION-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/DOCUMENTATION-POLICY.md)
is adopted:

- Tier 1 (this repository): README, ADRs, DIP, status, build instructions.
- Tier 2: cross-project policies live in the governance repository.
- Tier 3 and 4: wiki for non-technical and process material.

Specific rules that apply immediately:

1. Every feature branch must include an ADR if it introduces a non-trivial
   architectural decision.
2. The README must answer: what is this, what is the current state, how do I build
   it, where do I go for more.
3. A DIP.md must be kept current at the repository root.
4. Status tables (per WORK-DONE-POLICY.md) are required on all ADRs, MDs, DFRs,
   and Roadmaps.

---

## Rationale

A decision not recorded is a decision that will be made again. Each re-decision
costs the team at least half a day and produces inconsistent outcomes. ADRs stop
this loop. They do not require long documents - the ADR template takes twenty
minutes to fill out and survives for years.

A README that tells you what is done versus what is planned is not extra work. It
is the answer to the question every new engineer asks on their first day.

---

## References

- Policy: [DOCUMENTATION-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/DOCUMENTATION-POLICY.md)
- Policy: [WORK-DONE-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/WORK-DONE-POLICY.md)
- DIP: [../../DIP.md](../../DIP.md)
