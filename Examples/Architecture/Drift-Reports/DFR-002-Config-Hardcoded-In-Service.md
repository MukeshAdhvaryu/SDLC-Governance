# DFR-002: Configuration Values Hardcoded in UserService

**Date:** 2026-02-10
**Status:** In Progress
**Area:** src/Core - UserService
**Owner:** Platform team

---

> **Status legend:** [x] Shipped - [ ] Not done - [~] Partial - [*] WIP - [.] Deferred - [!] Cancelled

## Status

| ID | Status | Task | Owner | Evidence |
|----|--------|------|-------|----------|
| DFR-002-T01 | Done | Extract JWT expiry, max login attempts, and role names to Constants.cs. | Platform team | `src/Core/Constants.cs` - UserConstants class added. `a2b3c4d` |
| DFR-002-T02 | Done | Remove all string literals from UserService that represent role names. | Platform team | `src/Core/UserService.cs` - "admin", "editor", "viewer" replaced with UserConstants.Role.* | `a2b3c4d` |
| DFR-002-T03 | [*] | Audit remaining services for undiscovered magic values. | Platform team | Grep run; 3 files pending review. |
| DFR-002-T04 | [ ] | Add linter check for string literals in service files to CI pipeline. | DevOps | Not started. |

---

## Drift

`UserService` contained the following inline literals:

```
if (user.Role == "admin") { ... }
if (loginAttempts > 5) { ... }
var token = GenerateJwt(expiresInMinutes: 60);
```

This violates ADR-002: no magic strings or numbers. The role names appear in three
separate files with inconsistent casing ("admin", "Admin", "ADMIN"). The login
attempt limit of `5` and JWT expiry of `60` minutes have no explanation and no
single place of ownership.

---

## Intended Design

Per ADR-002, all string and numeric literals representing business rules, limits,
identifiers, or configuration must be extracted to named constants. Constants
private to one class stay in that class; constants shared across the project go
in `src/Core/Constants.cs`.

---

## Current Behavior at Discovery

- `"admin"` as a role string appeared in `UserService.cs`, `AuthMiddleware.cs`, and
  `ReportController.cs` with three different casings.
- Login attempt limit `5` appeared in `UserService.cs` with no comment.
- JWT expiry `60` appeared in `TokenService.cs` with no comment.

When the role casing was standardised to lowercase in one file, the other two
files did not match and a permission check silently failed in production for two days.

---

## Root Cause

The codebase predated ADR-002. There was no enforcement mechanism beyond code review,
and reviewers did not consistently flag magic values in the early sprints.

---

## Decision

Correct the implementation. All magic values are extracted to named constants.
A CI linter check will be added to prevent regression (T04).

---

## Journey Log

```
2026-02-10 - Drift discovered after production permission bug traced to role name
             casing mismatch.
2026-02-11 - T01 and T02 complete. UserConstants.Role.Admin / Editor / Viewer added.
             UserService updated. Login attempt limit and JWT expiry extracted.
2026-02-12 - T03 started. Audit grep found 3 more files with literal role names.
             Review in progress.
2026-02-13 - T04 not started. DevOps capacity deferred to next sprint.
```

---

## References

- ADR: [ADR-002-No-Magic-Values.md](../ADRs/ADR-002-No-Magic-Values.md)
- Policy: [BEST-ENGINEERING-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/BEST-ENGINEERING-POLICY.md)
- Affected files: `src/Core/UserService.cs`, `src/Core/Constants.cs`
