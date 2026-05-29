# RDMP-Core: Core Domain Delivery

> Tracks delivery of the user management, order processing, and product catalog
> domain layers.

---

## Where We Are

The project has a working layered architecture (ADR-003) with Core isolated from
Infrastructure. Repository interfaces are defined (MD-001). Contract test suites
cover user and order repositories. The product catalog repository suite is pending.

---

> **Status legend:** [x] Shipped - [ ] Not done - [~] Partial - [*] WIP - [.] Deferred - [!] Cancelled

## Status

| Sub-topic | Related Area | Status | Notes | Commit | Date |
|-----------|--------------|--------|-------|--------|------|
| Layered architecture established | src/ | [x] | Core/Domain/Infrastructure/API separation in place | `n4o5p6q` | 2026-01-25 |
| IUserRepository + contract suite | src/Core, Tests | [x] | 12 contract tests; SQL and in-memory fixtures both pass | `o5p6q7r` | 2026-01-28 |
| IOrderRepository + contract suite | src/Core, Tests | [x] | 9 contract tests; SQL fixture passes | `p6q7r8s` | 2026-02-03 |
| IProductRepository + contract suite | src/Core, Tests | [~] | Interface defined; contract suite not yet written | `q7r8s9t` | 2026-02-08 |
| UserService - authentication flow | src/Core | [x] | Register, login, JWT issue, refresh | `r8s9t0u` | 2026-02-10 |
| UserService - account lifecycle | src/Core | [*] | Activate/deactivate working; deletion flow in progress | - | - |
| OrderService - create and validate | src/Core | [x] | Line item validation, pricing, stock check | `s9t0u1v` | 2026-02-12 |
| OrderService - fulfilment dispatch | src/Core | [ ] | Depends on messaging integration | - | - |
| ProductCatalog - listing and search | src/Core | [ ] | Not started | - | - |
| DFR-001 resolved (layer bypass) | src/Core | [x] | OrderService now uses constructor injection | `t0u1v2w` | 2026-02-12 |
| DFR-002 in progress (magic values) | src/Core | [~] | UserService done; audit of remaining services ongoing | - | - |

---

## Progress Tracker

> Last updated: 2026-02-13

| Phase | Item | Status | Notes |
|-------|------|--------|-------|
| 1.1 | Project structure and layer separation | [x] Done | Core, Domain, Infrastructure, API |
| 1.2 | Interface definitions for all repositories | [x] Done | IUserRepository, IOrderRepository, IProductRepository |
| 1.3 | Abstract contract test suites | [~] Partial | User and Order done; Product pending |
| 2.1 | UserService - full authentication flow | [x] Done | Register, login, JWT, refresh, logout |
| 2.2 | UserService - account lifecycle | [*] In progress | Activate/deactivate done; delete flow pending |
| 2.3 | OrderService - create and validate | [x] Done | ADR-002 constants applied |
| 2.4 | OrderService - fulfilment dispatch | [ ] Not started | Blocked on Phase 3 messaging work |
| 3.1 | ProductCatalog - listing and search | [ ] Not started | - |
| 3.2 | ProductCatalog - availability management | [ ] Not started | - |

---

## Known Gaps

| Gap | Priority | Notes |
|-----|----------|-------|
| IProductRepository contract suite | High | Interface exists; no test coverage yet |
| OrderService fulfilment dispatch | Medium | Depends on messaging infrastructure (Phase 3) |
| Architecture enforcement test | Medium | Automated layer check not yet in CI |

---

## Priority Order Summary

| # | What | Why |
|---|------|-----|
| 1 | IProductRepository contract suite | Closes the test gap; needed before ProductCatalog work starts |
| 2 | UserService account deletion | Completes the account lifecycle; blocked DFR cannot close without it |
| 3 | Architecture enforcement test in CI | Prevents future layer bypass drifts automatically |
| 4 | ProductCatalog listing and search | Unblocks frontend work |
