# ADR-002: No Magic Strings or Numbers

**Date:** 2026-01-15
**Status:** Accepted
**Author:** Platform team

---

> **Status legend:** [x] Shipped - [ ] Not done - [~] Partial - [*] WIP - [.] Deferred - [!] Cancelled

## Status

| Sub-topic | Related Area | Status | Notes | Commit | Date |
|-----------|--------------|--------|-------|--------|------|
| Decision ratified | Architecture | [x] | - | - | 2026-01-15 |
| UserService magic strings removed | src/Core | [x] | JWT expiry and role names extracted to constants | `b2c3d4e` | 2026-01-18 |
| OrderService magic numbers removed | src/Core | [x] | Max line items, retry counts extracted | `c3d4e5f` | 2026-01-19 |
| Linter rule added to CI | CI | [~] | String literals flagged; number check not yet wired | `d4e5f6g` | 2026-02-01 |

---

## Context

The codebase contains scattered string literals and numeric literals that represent
business rules. Examples found during audit:

- `if (user.Role == "admin")` in three different files with inconsistent casing
- `if (order.LineItems.Count > 50)` with no indication that 50 is a business limit
- `Thread.Sleep(3000)` with no explanation of why 3 seconds

When a value changes, engineers must grep for it and hope they found all instances.
When a value is wrong, it is not obvious where it came from or who owns it.

---

## Decision

No magic strings or numbers anywhere in the production codebase.

- String and numeric literals that represent business rules, limits, configuration,
  or identifiers must be extracted to named constants.
- Constants private to a class stay in that class. Constants shared across a project
  go in a dedicated `Constants.cs` file with the narrowest visibility that works.
- Exceptions: trivial literals like `0`, `1`, empty string `""`, and `null` in
  idiomatic positions do not require constants.

---

## Rationale

A named constant is self-documenting. `MaxOrderLineItems` communicates intent.
`50` does not. When `MaxOrderLineItems` changes, the change happens in one place
and every caller sees it automatically.

Role name strings are a particular risk: a single typo in one place means a
security check silently fails without any compile-time or runtime error.

---

## Consequences

### Positive

- Business rule values have single, findable homes.
- Type safety is possible when combined with enums for categorical values.
- Changes to limits and identifiers are mechanical and safe.

### Negative

- Some boilerplate: extracting a constant takes more lines than inlining it.
- Engineers must agree on where shared constants live.

---

## References

- Policy: [BEST-ENGINEERING-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/BEST-ENGINEERING-POLICY.md)
- Constants file: `src/Core/Constants.cs`
