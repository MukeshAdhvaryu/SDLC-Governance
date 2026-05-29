# ADR-003: Layered Architecture - Core Must Not Reference Infrastructure

**Date:** 2026-01-15
**Status:** Accepted
**Author:** Platform team

---

> **Status legend:** [x] Shipped - [ ] Not done - [~] Partial - [*] WIP - [.] Deferred - [!] Cancelled

## Status

| Sub-topic | Related Area | Status | Notes | Commit | Date |
|-----------|--------------|--------|-------|--------|------|
| Decision ratified | Architecture | [x] | - | - | 2026-01-15 |
| Core project references Infrastructure removed | src/Core | [x] | SqlOrderRepository reference removed from OrderService | `e5f6g7h` | 2026-01-25 |
| Dependency injection wired at entry point | src/API | [x] | All repositories injected via IServiceCollection | `f6g7h8i` | 2026-01-25 |
| Architecture test enforcing layer rules | Tests | [ ] | ArchUnit or equivalent check not yet added | - | - |

---

## Context

`OrderService` in `src/Core` was importing `SqlOrderRepository` from
`src/Infrastructure/Persistence` directly. This means the business logic layer
has a compile-time dependency on the database technology. Swapping the database
requires changes in Core, which is supposed to be the stable layer.

The same issue exists in a smaller form in `UserService`, which references
`PasswordHasher` from Infrastructure.

---

## Decision

Dependencies flow inward only. Core is the innermost layer.

Layer rules:
- `src/Domain` - no references outside Domain. Pure business objects.
- `src/Core` - may reference Domain. Must not reference Infrastructure or Platform.
- `src/Infrastructure` - may reference Core and Domain. Implements the interfaces Core defines.
- `src/API` (or `src/CLI`, etc.) - may reference any layer. Owns the composition root.

All infrastructure implementations are injected via the interfaces defined in
`src/Core/Interfaces`. Core never knows the concrete type.

---

## Rationale

A Core layer that references Infrastructure cannot be tested without the
infrastructure. It cannot be deployed without it. It cannot be reasoned about
independently. The interface boundary is what makes substitution, testing, and
long-term refactoring possible.

This is Dependency Inversion (the D in SOLID) applied at the project level.

---

## Consequences

### Positive

- Core is testable without a running database, message broker, or external API.
- Infrastructure can be swapped without touching Core.
- The architecture is legible: where a class lives tells you what it is allowed to depend on.

### Negative

- Requires a composition root (typically the API project) that wires everything together.
- Interfaces must be defined before implementations, which adds a small upfront cost.

### Neutral

- A failing build is the enforcement mechanism for the layer rule until an
  architecture test is added.

---

## References

- Policy: [BEST-ENGINEERING-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/BEST-ENGINEERING-POLICY.md)
- Policy: [SOLIDE-DESIGN-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/SOLIDE-DESIGN-POLICY.md) - D principle
- Interfaces: `src/Core/Interfaces/`
