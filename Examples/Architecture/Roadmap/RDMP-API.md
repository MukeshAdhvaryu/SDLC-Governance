# RDMP-API: REST API Delivery

> Tracks delivery of the REST API surface, authentication middleware, rate limiting,
> and API documentation.

---

## Where We Are

The API project exists and handles HTTP requests. Basic routing and controller
structure are in place. Authentication middleware is partially implemented.
Rate limiting and API documentation are not started.

---

> **Status legend:** [x] Shipped - [ ] Not done - [~] Partial - [*] WIP - [.] Deferred - [!] Cancelled

## Status

| Sub-topic | Related Area | Status | Notes | Commit | Date |
|-----------|--------------|--------|-------|--------|------|
| Controller structure and routing | src/API | [x] | User, Order, Product controllers; versioned routes | `u1v2w3x` | 2026-02-01 |
| DI composition root | src/API | [x] | All Core interfaces wired to Infrastructure implementations | `v2w3x4y` | 2026-02-01 |
| JWT authentication middleware | src/API | [x] | Token validation; role-based claims extraction | `w3x4y5z` | 2026-02-08 |
| Refresh token endpoint | src/API | [x] | - | `x4y5z6a` | 2026-02-09 |
| Rate limiting (per-route) | src/API | [ ] | No design yet | - | - |
| OpenAPI / Swagger documentation | src/API | [~] | Controller-level docs added; model schema annotations missing | `y5z6a7b` | 2026-02-10 |
| Integration test suite for API endpoints | Tests/Integration | [.] | Deferred - needs contract suite coverage complete first | - | - |

---

## Progress Tracker

> Last updated: 2026-02-13

| Phase | Item | Status | Notes |
|-------|------|--------|-------|
| 1.1 | Controller and routing structure | [x] Done | RESTful routes for all three domains |
| 1.2 | DI composition root | [x] Done | All repositories and services wired |
| 2.1 | JWT authentication middleware | [x] Done | Validates tokens; extracts claims |
| 2.2 | Refresh token flow | [x] Done | 7-day rolling refresh window |
| 2.3 | Rate limiting | [ ] Not started | - |
| 3.1 | OpenAPI annotations - models | [*] In progress | Controllers done; request/response models pending |
| 3.2 | Integration test suite | [.] Deferred | Starts after RDMP-Core contract suites are complete |

---

## Known Gaps

| Gap | Priority | Notes |
|-----|----------|-------|
| Rate limiting | High | No per-route or per-user throttle in place |
| Request model validation | High | No consistent validation pipeline; controllers validate ad-hoc |
| Integration test suite | Medium | Deferred until Core contract coverage is complete |

---

## Priority Order Summary

| # | What | Why |
|---|------|-----|
| 1 | Request model validation pipeline | Inconsistent validation is a correctness and security risk |
| 2 | Rate limiting | Required before public launch |
| 3 | OpenAPI model annotations | Needed for consumer SDK generation |
| 4 | Integration test suite | Closes end-to-end coverage gap |
