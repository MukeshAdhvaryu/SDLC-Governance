# MD-001: Atomic Interface Decomposition

**Date:** 2026-01-20
**Status:** Accepted
**Author:** Platform team, in deliberation with architecture group

---

> **Status legend:** [x] Shipped - [ ] Not done - [~] Partial - [*] WIP - [.] Deferred - [!] Cancelled

## Status

| Sub-topic | Related Area | Status | Notes | Commit | Date |
|-----------|--------------|--------|-------|--------|------|
| Decision ratified | Architecture | [x] | - | - | 2026-01-20 |
| Fat IRepository<T> replaced with atomic contracts | src/Core/Interfaces | [x] | IReadable, IWritable, IDeletable separated | `g7h8i9j` | 2026-02-05 |
| Existing implementations updated | src/Infrastructure | [x] | SqlUserRepository now implements only contracts it actually supports | `h8i9j0k` | 2026-02-06 |
| Documentation updated | DIP.md | [x] | - | `i9j0k1l` | 2026-02-06 |

---

## The Problem

The codebase originally defined one `IRepository<T>` interface with methods for
reading, writing, querying, and deleting. Every repository - including read-only
reporting repositories - was required to implement all of it. The read-only
reporting repositories threw `NotImplementedException` on the write methods.

This is the same design failure as `System.Array : IList<T>` in the .NET standard
library. The interface promises more than the implementor can deliver, and the lie
shows up at runtime.

---

## Why the Standard Approach Falls Short

The conventional advice - "use a fat base interface and throw NotImplementedException
on the parts you don't support" - creates two distinct problems:

1. **Callers cannot trust the contract.** Code that accepts `IRepository<User>` and
   calls `.Save()` has no compile-time guarantee that Save is supported. It may
   throw at runtime.

2. **The interface cannot grow honestly.** When a new capability (e.g. bulk insert)
   is needed for some repositories but not all, it gets added to the fat interface
   and every existing implementor gets a new `throw NotImplementedException()`.

The root cause is that one interface is doing the job of several.

---

## The Correct Design

Split the capabilities into minimal atomic contracts:

```
IReadable<T>   - GetById(id), Exists(id)
IQueryable<T>  - Find(predicate), List()
IWritable<T>   - Save(entity)
IDeletable<T>  - Delete(id)
```

Each repository declares exactly which capabilities it supports:

```
SqlUserRepository   : IReadable<User>, IWritable<User>, IDeletable<User>
ReportRepository    : IReadable<Order>, IQueryable<Order>
AuditLogRepository  : IWritable<AuditEntry>
```

No method can throw `NotImplementedException` because no repository implements a
contract it cannot honour.

---

## Positions

### Architecture team's position

The fat `IRepository<T>` pattern is convenient to introduce and expensive to live
with. The atomic split adds a small upfront cost at design time and eliminates an
entire category of runtime surprises. We have already hit two `NotImplementedException`
failures in production from the reporting repository. This decision prevents a third.

### Dissenting view considered

One engineer argued that the atomic approach produces more interface types to manage.
The counter: more small interfaces is better than fewer interfaces that lie. The
compiler enforces what the interface claims. That enforcement is worth the extra
type names.

---

## Decision

Replace `IRepository<T>` with atomic capability contracts: `IReadable<T>`,
`IQueryable<T>`, `IWritable<T>`, `IDeletable<T>`. Repositories implement only the
contracts they can honestly satisfy. No `NotImplementedException` is permitted in
any interface implementation.

---

## References

- Policy: [SOLIDE-DESIGN-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/SOLIDE-DESIGN-POLICY.md) - I and L principles
- ADR: [ADR-003-Layered-Architecture.md](../ADRs/ADR-003-Layered-Architecture.md)
- Interfaces: `src/Core/Interfaces/`
