# Work Done Policy

> A document without a status table is a document that cannot answer the question: "Is this actually done?"

Every ADR, MD, DFR, Spec, and Roadmap in this repository must carry a **status table**
that records what shipped, what did not, what is in flight, and the exact commit where
each state was established. The table is the document's ground truth - not its prose,
not its headings, not its author's memory.

---

## Why This Exists

Architecture documents accumulate stale content. A decision is made, partially
implemented, then the scope changes - but nobody updates the document. Six months
later a new contributor reads "Done" in a heading and trusts it. The code disagrees.

The status table solves this by making staleness visible:

- Every item has an explicit state symbol, not a prose claim.
- Every shipped item has a commit SHA - if no commit exists, it is not shipped.
- Every date is absolute, not relative ("last week", "recently").
- Partial and WIP states are first-class - they are not omitted out of embarrassment.

---

## Status Symbols

| Symbol | Meaning | When to use |
|--------|---------|-------------|
| `[x]` | **Shipped** | Complete, tested, in the build or runtime. A commit SHA is mandatory. |
| `[ ]` | **Not done** | Not started. No design, no code, no tests. |
| `[~]` | **Partial** | Some sub-items shipped, some have not. Notes must state what is missing. |
| `[*]` | **WIP** | Actively in progress this cycle. Expected to become `[x]` or `[~]` soon. |
| `[.]` | **Deferred** | Intentionally postponed. Notes must state the blocker or trigger condition. |
| `[!]` | **Cancelled** | Decided against. Notes must state why - do not delete the row. |

**Rules:**
- `[x]` without a commit SHA is invalid. Fill the commit or downgrade to `[~]`.
- `[*]` without an owner or active branch is invalid. Downgrade to `[ ]` or `[.]`.
- Never delete a row. `[!]` preserves the decision trail.

---

## Standard Status Table

Every covered document must include a section named **Status** containing this table.
Add it immediately after the document's opening summary or decision block.

```markdown
## Status

| Sub-topic | Related Area | Status | Notes | Commit | Date |
|-----------|--------------|--------|-------|--------|------|
| Brief label for this item | Component / layer this touches | [x] / [ ] / [~] / [*] / [.] / [!] | One line: caveat, blocker, or "-" | `abc1234` or - | YYYY-MM-DD |
```

### Column definitions

| Column | Type | Rules |
|--------|------|-------|
| **Sub-topic** | Short label | Match the heading or rule ID where possible. No prose. |
| **Related Area** | Component name | Name the system layer, module, or tool. |
| **Status** | Symbol | One of the six symbols above. No free-text status. |
| **Notes** | One sentence | State the exception, blocker, or sub-item gap. Use `-` if none. |
| **Commit** | Short SHA | The commit that shipped this item. Format: inline code `abc1234`. Use `-` if not yet shipped. |
| **Date** | ISO 8601 | Date of the commit, or date the status was last reviewed. Format: `YYYY-MM-DD`. |

---

## Document-Type Rules

### ADR (Architecture Decision Records)

The status table records the **implementation items** implied by the decision, not the
decision itself (the decision is captured in the ADR body). Each row is one concrete
deliverable the decision requires.

Example:

```markdown
## Status

| Sub-topic | Related Area | Status | Notes | Commit | Date |
|-----------|--------------|--------|-------|--------|------|
| Schema migration added | Database | [x] | - | `3fa9c21` | 2026-04-10 |
| Service layer updated | UserService | [x] | - | `7bd0e44` | 2026-04-12 |
| Integration tests | Tests.Integration | [~] | Auth path pending | `7bd0e44` | 2026-04-12 |
| Load test coverage | Tests.Performance | [ ] | Blocked on infra setup | - | - |
```

### MD (Major Decisions)

The status table records whether the **design decision itself** has been ratified and
whether its downstream consequences have been acted on. One row per consequence.

### DFR (Drift Reports)

The status table records each **drift item** identified in the report. Status reflects
whether the drift has been resolved, is being resolved, or is accepted as intentional.

```markdown
| Sub-topic | Related Area | Status | Notes | Commit | Date |
|-----------|--------------|--------|-------|--------|------|
| DFR-001: CatalogPath mismatch | ModuleLocator | [x] | Resolved in resolver rewrite | `d2901bc` | 2026-05-15 |
| DFR-002: Namespace casing | Core.Text | [*] | In progress | - | - |
```

### Roadmap (RDMP)

The status table is the **tracker** for the roadmap's deliverables. Each phase or named
item gets a row. The roadmap body may contain narrative, but the table is the canonical
state of play.

```markdown
| Sub-topic | Related Area | Status | Notes | Commit | Date |
|-----------|--------------|--------|-------|--------|------|
| Authentication pipeline | Core.Auth | [x] | JWT + refresh token; 42 tests green | `2bce630` | 2026-05-29 |
| Rate limiting | API.Gateway | [~] | Per-route config missing | `a91f3d2` | 2026-05-10 |
| Admin dashboard | Frontend | [ ] | No design yet | - | - |
```

---

## Maintenance Rules

1. **Update on merge, not on plan.** Change a row's status when the commit lands on
   the integration branch, not when the task is started.

2. **One row per atomic deliverable.** If a row would need two commits and two dates, it
   is two rows.

3. **The table owns the state. The prose does not.** If the body says "Done" but the
   table says `[ ]`, the table is authoritative and the prose must be corrected.

4. **Deferred rows must carry a trigger.** `[.]` without a condition ("blocked until
   feature X ships", "deferred until Phase 2 is complete") is not allowed.

5. **Commits are immutable evidence.** A SHA in the Commit column is a permanent
   record. Do not remove it, even if the row is later cancelled (`[!]`).

6. **Review cadence.** At the start of any session that touches a document, scan its
   status table. If any `[*]` row has had no commit for more than two weeks without an
   explanation, downgrade it to `[.]` and add a note.

---

## Legend Block (copy-paste for document headers)

Every document that carries a status table should include this legend directly above
the table:

```markdown
> **Status legend:** [x] Shipped - [ ] Not done - [~] Partial - [*] WIP - [.] Deferred - [!] Cancelled
```
