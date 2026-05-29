# Specification Writing Guide

A specification document is the human-readable contract for one area of the system.
It says what the system must do, under what conditions, and what the boundaries are.
It is not a design document (that is an ADR or Major Decision). It is not a rule
checker (that is a semantic rule). It is the statement of intent that both of those
downstream artifacts derive from.

---

## When to Write a Specification

Write a specification when:

- A feature or area is complex enough that two engineers would implement it
  differently without written guidance.
- An ADR or Major Decision produces concrete behavioural requirements that need to
  be stated in precise, user-visible terms.
- Tests need a specification to verify correctness against, not just implementation
  coverage.
- A new contributor needs to understand the system contract without reading the code.

Do not write a specification for:
- Implementation choices that do not affect observable behaviour.
- Things already captured in ADRs (the spec is the "what", the ADR is the "why").
- Internal helper functions or utilities not part of any user-facing contract.

---

## Document Structure

Each specification covers one area of the system. Use numbered sections so that
rules can be referenced precisely (e.g. "see Spc-Domain.md section 3.4").

```markdown
# Spc-AreaName: Area Title

**Version:** N.N
**Status:** Draft | Accepted | Superseded
**Owner:** Name or role

---

## Table of Contents

## 1. Overview
## 2. Constructs
## 3. Rules
## 4. Error Codes
## 5. Examples
## 6. References
```

---

## Section 1 - Overview

One to three paragraphs. State:

- What this area of the system is responsible for.
- What it is not responsible for (the boundary).
- The key invariant that the rest of the specification enforces.

Example:

```
Section 1.0 - Overview

The user management area is responsible for the lifecycle of user accounts: creation,
verification, activation, deactivation, and deletion. It is not responsible for
authentication (see Spc-Auth.md) or authorisation (see Spc-Permissions.md).

The key invariant: a user account that is marked Active must have a verified email
address. This invariant is enforced at the service boundary and cannot be bypassed
through the repository layer.
```

---

## Section 2 - Constructs

List the named entities, value types, and contracts this area defines.

For each construct:
- State its purpose in one sentence.
- List its required fields or members.
- State any invariants that must hold on the construct itself (not at operation time).

Use a table for brevity when there are many constructs.

```
| Construct | Kind | Description |
|-----------|------|-------------|
| User | Entity | Represents a registered account with identity, contact, and state fields. |
| EmailAddress | Value type | A validated email string. Must contain exactly one @ character. |
| AccountStatus | Enum | One of: Pending, Active, Suspended, Deleted. |
```

---

## Section 3 - Rules

This is the core of the specification. List every rule as a numbered entry.

Rule format:

```
3.N Rule Name

Condition: If ... then ...
Enforced at: service boundary | repository boundary | construct construction | compile time
Error code: AREA-NNN (see Section 4)
Note: optional clarification or edge case
```

Group related rules under sub-sections (3.1, 3.2, etc.).

Example:

```
3.1 Account Activation Rules

3.1.1 Email Verified Before Activation
Condition: If User.Activate() is called and User.EmailVerified is false, the
           operation is rejected.
Enforced at: service boundary
Error code: USR-004
Note: Activation via administrative override is out of scope for this specification.

3.1.2 No Re-Activation of Deleted Accounts
Condition: If User.Activate() is called on a User with AccountStatus = Deleted,
           the operation is rejected.
Enforced at: service boundary
Error code: USR-005
```

---

## Section 4 - Error Codes

List every error and warning code this area can produce.

```
| Code | Type | Trigger |
|------|------|---------|
| USR-001 | Error | Email address contains no @ character. |
| USR-002 | Error | Username is empty or exceeds 64 characters. |
| USR-003 | Warning | Account has been inactive for more than 90 days. |
| USR-004 | Error | Activate() called before email verification. |
| USR-005 | Error | Activate() called on a Deleted account. |
```

For message text templates, see the semantic rule document for this area.

---

## Section 5 - Examples

Provide at least one valid example and one violation example per major rule group.

Keep examples minimal. The smallest input that demonstrates the rule is the best
example. Annotate each example with the rule it illustrates.

```
Example - Valid activation:
  User is created with email "alice@example.com".
  Verification email is sent; user clicks link; EmailVerified is set to true.
  User.Activate() is called. AccountStatus transitions to Active.
  Rule satisfied: 3.1.1, 3.1.2.

Example - Activation rejected (USR-004):
  User is created with email "alice@example.com".
  User.Activate() is called before verification.
  USR-004 fires. AccountStatus remains Pending.
```

---

## Section 6 - References

Link every decision that produced a rule in this specification.

```
- ADR-005 - Email Verification Required Before Activation
- MD-001 - Account Lifecycle Model
- Semantic rules: Sem-UserManagement.md
- Related specs: Spc-Auth.md (authentication), Spc-Permissions.md (authorisation)
```

---

## Writing Rules Precisely

The most common specification failure is a rule that cannot be turned into a test.

Test this by asking: given only the rule text and an example input, can a new
engineer write the test without asking anyone a question?

If yes, the rule is precise enough.
If no, add the missing constraint, boundary condition, or definition.

Common failures:

| Vague form | Precise form |
|------------|--------------|
| "Email must be valid" | "Email must contain exactly one @ character and at least one . after the @" |
| "Name cannot be too long" | "Name must be between 1 and 64 characters inclusive" |
| "Status must be correct" | "Status must be one of: Pending, Active, Suspended, Deleted" |
| "User must be authorised" | "User must have the Admin role to call DeleteAccount()" |

---

## Checklist Before Committing a Specification Section

- [ ] Every rule has a number that can be cited in tests, ADRs, and semantic rules.
- [ ] Every rule states a condition in "if ... then ..." form.
- [ ] Every rule names its error code.
- [ ] Every construct lists its invariants.
- [ ] At least one valid and one violation example exist per rule group.
- [ ] All referenced ADRs and Major Decisions exist and link to this spec.
- [ ] The semantic rule document for this area has a matching entry for each rule.
