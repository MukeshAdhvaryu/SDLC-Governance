# Best Engineering Policy

## Purpose

This policy records the engineering standards that apply to all code in
this repository. These rules are not aspirational - they are enforced during review
and refactoring.

## Constants

No magic strings or magic numbers. Use named constants at the entity level when
private scope is sufficient.

If constants must be shared within a project or namespace, place them in a separate
`Constants` file and keep visibility no broader than needed, usually `internal`.

## Nesting Depth

Maximum nesting depth is three levels. Prefer guard clauses, early returns,
extraction, and small helper methods to keep nesting minimal.

## SOLID Principles

SOLID principles must be followed: single responsibility, open/closed design,
substitutable contracts, focused interfaces, and dependency inversion through
abstractions where appropriate.

See [SOLIDE-DESIGN-POLICY.md](SOLIDE-DESIGN-POLICY.md) for an extended discussion
of where SOLID falls short and how to apply it honestly.

## MVP to Production-Grade Transition

MVP-era names and structures are born under pressure - the priority is something
that compiles and runs, and naming is a second-class concern. They accumulate as
the system grows around them until the mismatch between a name and its actual role
becomes friction for every new contributor and every new decision.

The crossing point is when the architecture stabilizes enough that you can see the
full shape. Once that shape is visible, old names stop being good enough and start
being actively misleading.

When that point arrives, rename and restructure. The test of whether the
architecture was sound is whether the refactoring is mechanical - find-replace,
folder move, build passes. If it is, the structure was already right; the names
just needed to catch up to the reality that was already there.

Apply this principle to namespaces, folder hierarchies, type names, and method
names alike. A name that described intent at MVP time may misrepresent role at
production scale. Rename early enough that the wrong name has not propagated into
too many dependents.
