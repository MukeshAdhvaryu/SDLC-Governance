# ADR-001: Contract-Based Testing

**Date:** 2026-01-15
**Status:** Accepted
**Author:** Platform team

---

> **Status legend:** [x] Shipped - [ ] Not done - [~] Partial - [*] WIP - [.] Deferred - [!] Cancelled

## Status

| Sub-topic | Related Area | Status | Notes | Commit | Date |
|-----------|--------------|--------|-------|--------|------|
| Decision ratified | Architecture | [x] | Accepted and enforced at review | - | 2026-01-15 |
| Existing UserService tests refactored | Tests | [x] | Moved from SqlUserRepository to IUserRepository contract | `a1b2c3d` | 2026-01-20 |
| Existing OrderService tests refactored | Tests | [x] | - | `e4f5g6h` | 2026-01-22 |
| Contract suite for IProductRepository | Tests | [ ] | Not yet started | - | - |

---

## Context

The team has been writing tests that directly instantiate `SqlUserRepository` and
`SqlOrderRepository`. This means tests break whenever the SQL schema changes, even
if the service behaviour has not changed. It also means we cannot run the test suite
without a live database connection.

When a second persistence backend was proposed (for testing and for a lighter
deployment option), we had no way to verify it satisfies the same contracts as
the SQL implementation without duplicating all the tests.

---

## Decision

All tests that validate service or repository behaviour must target the public
interface contract, not the concrete implementation class.

- Tests for persistence behaviour target `IUserRepository`, `IOrderRepository`,
  `IProductRepository` - not `SqlUserRepository`, `MongoUserRepository`, or any
  concrete class.
- Contract test suites are abstract. One concrete fixture per backend wires the
  suite to a specific implementation.
- New backends prove they satisfy contracts by passing the existing abstract suite
  without adding new test logic.

---

## Rationale

- A test that can only run against one implementation is not a contract test - it
  is an implementation test.
- Duplicate test logic across backends is a maintenance liability. A shared
  abstract suite eliminates it.
- Hard-coding the concrete class in a test makes refactoring expensive and hides
  the actual contract the code is supposed to satisfy.

---

## Consequences

### Positive

- Tests can run without a live database by substituting an in-memory fixture.
- Adding a new backend requires only a new fixture, not new test logic.
- The interface becomes the specification; any divergence shows up as a test failure.

### Negative

- Writing the first abstract suite takes longer than writing a single direct test.
- Engineers unfamiliar with this pattern need a short onboarding step.

---

## References

- Policy: [TESTING-STANDARDS-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/TESTING-STANDARDS-POLICY.md)
- Interfaces: `src/Core/Interfaces/IUserRepository.cs`, `IOrderRepository.cs`
- Abstract suites: `Tests/Abstractions/IUserRepositoryContractTests.cs`
