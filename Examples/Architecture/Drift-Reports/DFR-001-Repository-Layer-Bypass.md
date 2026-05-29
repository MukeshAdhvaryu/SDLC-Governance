# DFR-001: Service Layer Bypassing Repository Interface

**Date:** 2026-02-10
**Status:** Resolved
**Area:** src/Core - OrderService
**Owner:** Platform team

---

> **Status legend:** [x] Shipped - [ ] Not done - [~] Partial - [*] WIP - [.] Deferred - [!] Cancelled

## Status

| ID | Status | Task | Owner | Evidence |
|----|--------|------|-------|----------|
| DFR-001-T01 | Done | Remove direct SqlOrderRepository instantiation from OrderService. | Platform team | `src/Core/OrderService.cs` - constructor injection added. |
| DFR-001-T02 | Done | Wire IOrderRepository in the DI container. | Platform team | `src/API/Program.cs` - `AddScoped<IOrderRepository, SqlOrderRepository>()` added. |
| DFR-001-T03 | Done | Add regression test confirming OrderService receives injected IOrderRepository. | Platform team | `Tests/Integration/OrderServiceDependencyTests.cs` |
| DFR-001-T04 | Done | Update DIP.md to reflect corrected dependency direction. | Platform team | DIP.md OrderService entry updated. |

---

## Drift

`OrderService` in `src/Core` directly instantiated `SqlOrderRepository` from
`src/Infrastructure/Persistence` inside its constructor:

```
public OrderService()
{
    _repository = new SqlOrderRepository(connectionString);
}
```

This violates ADR-003: Core must not reference Infrastructure. It also means
OrderService cannot be tested without a live SQL connection.

---

## Intended Design

Per ADR-003, all infrastructure dependencies are injected through the interfaces
defined in `src/Core/Interfaces`. Core never instantiates concrete infrastructure
classes. The composition root in `src/API` is the only place where concrete types
are bound to interfaces.

`OrderService` must receive `IOrderRepository` via constructor injection.

---

## Current Behavior

At the time of discovery:
- `OrderService` constructor took no parameters and created its own `SqlOrderRepository`.
- `connectionString` was read directly from `Environment.GetEnvironmentVariable("DB_CONNECTION")`.
- The `Tests/Core/OrderServiceTests.cs` test suite could not run without a database.

---

## Root Cause

The initial implementation predated ADR-003. The developer was not aware of the
layering rule when writing OrderService, and the issue was not caught at review
because the review checklist did not include layer compliance at that time.

The governance validation script added in this work cycle (see Tools/) would have
caught this automatically.

---

## Decision

Correct the implementation. OrderService receives `IOrderRepository` via constructor
injection. The direct instantiation is removed. The DI wiring is added in the
composition root.

---

## Journey Log

```
2026-02-10 - Drift discovered during architecture review. OrderService found to
             import SqlOrderRepository directly.
2026-02-11 - T01 complete. Constructor parameter added; SqlOrderRepository reference
             removed from Core project.
2026-02-11 - T02 complete. DI container wired in Program.cs.
2026-02-12 - T03 complete. Regression test added. OrderService test suite now runs
             without a database connection.
2026-02-12 - T04 complete. DIP.md updated. DFR marked Resolved.
```

---

## References

- ADR: [ADR-003-Layered-Architecture.md](../ADRs/ADR-003-Layered-Architecture.md)
- ADR: [ADR-001-Contract-Based-Testing.md](../ADRs/ADR-001-Contract-Based-Testing.md)
- Affected file: `src/Core/OrderService.cs`
- Composition root: `src/API/Program.cs`
