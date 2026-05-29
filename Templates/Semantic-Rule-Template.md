# Semantic Rule Writing Guide

A semantic document translates human-readable specifications into machine-checkable
rules. Where a specification says "what the system must do", a semantic rule says
"exactly when a rule is satisfied and what error code fires when it is not".

This guide explains how to write semantic rules that are precise, testable, and
stable.

---

## When to Write Semantic Rules

Write a semantic document when:

- A specification section is ambiguous enough that two engineers might implement it
  differently.
- A rule produces a diagnostic (error, warning, or info) that must be consistently
  reproducible.
- A behaviour is tested and the test needs a named rule to assert against.
- A deliberation in an ADR or Major Decision produced a binding constraint that the
  implementation must check.

Do not write semantic rules for:
- Prose explanations that belong in the specification.
- Implementation details (how the check is performed, not what it checks).
- Rules that are already enforced by the type system or grammar without custom logic.

---

## Document Structure

A semantic document covers one area of the system (one file per area). Each rule
entry in the document follows this format:

```
RULE-ID

Description:
  One or two sentences. Exactly what condition this rule checks.

Applies to:
  The construct, declaration, statement, or operation this rule governs.

Condition:
  Precise statement of when the rule fires. Use "if ... then ..." form.
  State the check, not the implementation.

Error/Warning code:
  AREA-NNN

Message:
  The exact user-facing message text, or a template with placeholders.

Example (violation):
  Minimal code or configuration that triggers this rule.

Example (valid):
  Minimal code or configuration that satisfies this rule.

References:
  - Spec section: Spc-AreaName.md section N.N
  - ADR: ADR-NNN - Title
  - Related rule: RULE-ID
```

---

## Rule ID Convention

Rule IDs are short, uppercase, area-prefixed codes:

```
AREA-NNN
```

Where:
- `AREA` is a 2-4 letter abbreviation for the system area (e.g. `USR`, `ORD`, `CFG`, `API`).
- `NNN` is a three-digit number, assigned sequentially within the area.

Examples: `USR-001`, `ORD-042`, `CFG-007`, `API-019`.

Once assigned, a rule ID is permanent. If the rule is retired, mark it `Deprecated`
in the document - do not reuse the ID.

---

## Writing Conditions

The condition is the most important part of a semantic rule. It must be:

- **Binary** - either satisfied or not. No gradients.
- **Observable** - determinable from the inputs alone, without running the system.
- **Complete** - covers all sub-cases, including edge cases.

Good condition form:

```
If a User entity is saved with an EmailAddress field that contains no @ character,
then USR-003 fires.
```

Bad condition form:

```
Emails should be valid.
```

The bad form cannot be turned into a test. The good form can be turned into a test
in one step.

---

## Error Code Conventions

Assign one code per distinct failure mode, not one code per rule. A single rule may
produce different codes for different sub-violations.

| Code type | Format | When to use |
|-----------|--------|-------------|
| Error | `AREA-NNN` | The system cannot proceed. The operation must be rejected. |
| Warning | `AREA-NNNw` | The system can proceed but the configuration is questionable. |
| Info | `AREA-NNNi` | The system is reporting a state change that may be useful. |

Error messages must:
- State what went wrong, not what the user should do.
- Name the offending construct, value, or location.
- Be deterministic - the same input always produces the same message text.

Error messages must not:
- Contain internal file paths, class names, or stack traces.
- Give advice that may be wrong in edge cases.
- Be conditional on environmental state.

---

## Stability Rules

Once a semantic rule is published and referenced by tests:

1. **The rule ID is frozen.** Renaming it breaks every test that cites it.
2. **The condition may be narrowed** (fewer things trigger the rule) without breaking
   callers.
3. **The condition must not be widened** (more things trigger the rule) without a
   versioned change and a migration note.
4. **The error code is frozen** once it appears in a user-facing message.
5. **Message text may change** as long as the error code is stable.

---

## Example - Fully Specified Rule

```
USR-004

Description:
  A user account cannot be activated if its email address has not been verified.

Applies to:
  User.Activate() operation.

Condition:
  If User.EmailVerified is false at the time User.Activate() is called,
  then USR-004 fires and the activation is rejected.

Error code:
  USR-004

Message:
  "Cannot activate account for '{email}': email address has not been verified."

Example (violation):
  user = new User(email: "alice@example.com", emailVerified: false)
  user.Activate()  // fires USR-004

Example (valid):
  user = new User(email: "alice@example.com", emailVerified: true)
  user.Activate()  // succeeds

References:
  - Spec section: Spc-Domain.md section 3.4 (Account Lifecycle)
  - ADR: ADR-005 - Email Verification Required Before Activation
  - Related rule: USR-003 (email format validation)
```

---

## Checklist Before Committing a Semantic Rule

- [ ] Rule ID is unique within the area document.
- [ ] Condition is binary and testable in one step.
- [ ] At least one violation example and one valid example are present.
- [ ] Error code is assigned and not reused.
- [ ] Message text is deterministic and contains no internal paths.
- [ ] Spec section reference is accurate.
- [ ] Related ADR or Major Decision is linked if the rule came from a design decision.
