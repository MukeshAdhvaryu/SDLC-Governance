# Testing Standards Policy

**Status:** Accepted

---

## Goal

Define the testing standard for any software project: tests must protect product
contracts, system semantics, and user-visible behaviour with minimal coupling
to implementation mechanics.

The goal is not simply to have tests. The goal is to have tests that make the
system safer to change.

---

## Decision

This project adopts a strict testing policy:

1. Tests validate contracts and observable behaviour.
2. Test scaffolding must not define production architecture by accident.
3. Production abstractions introduced for tests must be legitimate product
   abstractions.
4. Test suites must be organized for long-term extension, not short-term
   convenience.
5. Implementation details should be tested indirectly unless they are promoted
   into intentional contracts.

---

## Principles

### Contract First

Tests must be written against the contract that matters.

Examples:

- Backend tests target the service interface, not a specific database implementation.
- Compiler or parser tests target diagnostics and result shape, not parser internals.
- API handler tests should target request/response behaviour, not private routing mechanics.
- CLI tool tests should target command behaviour and filesystem effects, not
  incidental control flow.

If the contract is unclear, tests should force the contract to be named.

### Public Behaviour Over Private Mechanics

A passing test suite should mean the product still behaves correctly. It should
not mean that a private helper still happens to arrange its loops the same way.

Tests may use focused fixtures and test doubles, but the assertion target must be
observable behaviour or an intentional contract.

### Test Pressure Is Design Feedback

Hard-to-test code is a signal. The response must be architectural thought, not
visibility bypasses or test-only hooks.

Acceptable responses include:

- extract a real interface or value object
- test at a higher integration level
- split an oversized component into product-meaningful pieces
- clarify the public contract
- leave incidental implementation covered through caller behaviour

Unacceptable responses include:

- friend assemblies or package-private bypasses for test access
- public APIs that exist only for tests
- test-only production flags
- assertions that lock down incidental implementation order
- mock-heavy tests that prove the mock setup rather than product behaviour

---

## Organization

When the same behavioural contract must be proven against more than one
implementation, prefer one abstract contract suite with one concrete fixture per
implementation over duplicated test logic.

Examples:

- database contract suites across different storage backends
- platform contract suites across OS abstractions
- service contract suites across different transport or host environments

The file system may organize test concerns. The type system should only encode
semantic distinctions.

---

## Test Categories

### Contract Tests

Contract tests validate interfaces and defined service boundaries. They should be
reusable across implementations without duplicating test logic.

### Semantic Tests

Semantic tests validate system meaning: types, rules, flow, module behaviour, and
processing results. These tests should be stable across internal representation changes
unless the contract itself changes.

### Integration Tests

Integration tests validate collaboration between real components: full pipelines,
handler chains, tools, filesystem layout, and package/runtime behaviour.
They are appropriate when correctness emerges from the interaction.

### Regression Tests

Every fixed bug that could plausibly return should leave a regression test at the
lowest level that still exercises the real contract.

### Golden Tests

Golden or snapshot-style tests are allowed only when the output is a true product
artifact whose full shape matters. They must not become a substitute for semantic
assertions.

---

## Anti-Patterns

The following are prohibited or strongly discouraged:

- privileged access mechanisms (friend assemblies, reflection hacks) for tests
- test-only production APIs
- public setters or mutable state added only for tests
- mocking the unit under test's direct implementation details
- tests that assert private method sequencing
- duplicate suites per implementation when a shared contract suite is possible
- broad snapshot tests for outputs where only a few semantic properties matter
- brittle line/column assertions unless source location is the feature under test
- relying on test execution order

---

## Review Standard

New tests should answer these questions:

- What product contract or observable behaviour does this protect?
- Would a real consumer care if this test failed?
- Can the implementation be refactored without rewriting the test?
- Is the test at the lowest level that still preserves honest coverage?
- Does any new abstraction exist for production reasons?

If the answer is unclear, the test design should be revisited.

---

## Consequences

- Test projects should mirror product contracts, not implementation folders by
  reflex.
- New implementation variants should reuse contract suites rather than fork them.
- Test helper abstractions must remain small and honest.
- Production code must not grow testing backdoors.
- Refactors that improve testability by clarifying real boundaries are preferred
  over privileged access or brittle assertions.
- Coverage percentage is secondary to contract coverage and regression value.
