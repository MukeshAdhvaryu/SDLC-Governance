# SOLIDE Design Policy

## The Indictment

The software industry has been lying to you.

Not through malice. Through comfort. Through the slow institutional amnesia that sets
in when a wrong decision becomes old enough to be called a convention.

For two decades, the industry has taught SOLID as gospel. Interface Segregation.
Liskov Substitution. Contracts, not implementations. Every bootcamp. Every
certification. Every design patterns book written since 2003.

And for that same two decades, every major language - including the one that helped
popularise SOLID - has quietly, systematically violated those principles, added
features to paper over the violations, and continued teaching SOLID with a straight
face.

## Exhibit A: System.Array

This is not a fringe case. This is not a legacy codebase from a team that didn't
know better. This is `System.Array` - the most fundamental collection type in the
entire .NET runtime, written by the people who built C#, used in every .NET program
ever written.

```csharp
// This compiles. The type system says this is valid.
IList<int> list = new int[] { 1, 2, 3 };

// This also compiles. The type system says this is valid.
list.Add(4);

// This is what actually happens at runtime:
// System.NotSupportedException: Collection was of a fixed size.
```

`System.Array` implements `IList<T>`. `IList<T>` declares `Add`, `Remove`,
`Insert`, `Clear`. Arrays cannot grow. Arrays cannot shrink. They never could.
Everyone knows this.

And yet `Array` implements `IList<T>` and throws `NotSupportedException` at runtime
when you call the methods the interface promises are there.

That is not an interface. That is a lie the type system agreed to tell.

It violates Liskov: you cannot substitute `Array` wherever `IList<T>` is expected
without the risk of runtime failure. That is the textbook definition of an LSP
violation.

It violates Interface Segregation: `IList<T>` is too fat. It bundled read capability
and write capability into one contract, then forced fixed-size collections to
implement the write half as a runtime exception.

Microsoft's official guidance? Check `IsFixedSize` before calling mutation methods.
That is an admission of guilt dressed as documentation.

And then - and this is where the hypocrisy becomes architectural - Microsoft knew the
correct design. In .NET 4.5 (2012), they introduced `IReadOnlyList<T>` and
`IReadOnlyCollection<T>`. That was them saying, in public: the original design was
wrong and here is the correct split. But they left `Array : IList<T>` in place.
Backwards compatibility mattered more than honesty.

## The Correct Design Was Already Known

The correct design is not difficult. You need ISP applied honestly:

```
ICount                           // just Count. One property.
IIndexer<T> : ICount             // read-only indexed access.
IxIndexer<T> : IIndexer<T>       // read-write indexed access.
IAdd<T>                          // Add and Insert. Nothing else.
IRemove<T>                       // Remove, RemoveAt, RemoveLast. Nothing else.
IAddRange<T>                     // AddRange. Nothing else.
IRemoveRange<T>                  // RemoveRange, RemoveAll. Nothing else.
ISwap<T>                         // Swap and Relocate. Nothing else.
IFind<TKey, TItem>               // Find, FindIndex, Exists, Contains.
IIndexOf<T>                      // IndexOf. Nothing else.
IReplace<T>                      // Replace. Nothing else.
IExist<T>                        // Exists. Nothing else.
```

Then, for an array - a fixed-size collection with indexed read and write access:

```
MyArray<T> : IReadOnlyCollection<T>, IxIndexer<T>
```

No `IAdd<T>`. No `IRemove<T>`. No `NotSupportedException`. No lies. The type tells
the truth about what it can do because the contracts it implements are exactly as
large as they need to be and no larger.

## What The Industry Did Instead

C# 8.0 (2019) introduced Default Interface Methods. The argument was API evolution:
widely-implemented interfaces need to grow without forcing every implementer to
update. The mechanism: put default implementations inside the interface itself.

This is not a solution to the `IList<T>` problem. It is a tool for avoiding the
solution. Instead of decomposing fat interfaces into honest atomic contracts, you
patch them with fallback behaviour and tell implementers they can ignore the new
methods. The interface gets fatter. The lie gets quieter.

Kotlin has protocol extensions. Swift has extension functions on interfaces. Rust has
trait default implementations. Every modern language made the same trade-off:
ergonomics over contract purity. And every one of them kept teaching SOLID.

That is the hypocrisy. Not that the trade-offs were wrong. The hypocrisy is the
refusal to say plainly: SOLID as originally formulated is no longer the complete
description of what we actually do.

## SOLIDE: An Honest Successor

SOLIDE extends and reframes SOLID. The extra **E** is deliberate.

It does not throw the old principles away. It calls out where their old vocabulary
became too small, too vague, and too easy to abuse. It adds the one principle the
original formulation was missing.

---

### S - Single Role Per Construct

**Original:** A class should have one reason to change.

**Restated:** A language construct should have one architectural role.

Every construct in a system - whether it is a class, interface, module, or service -
should serve exactly one architectural purpose. Mixing roles produces the same class
of failure that `IList<T>` demonstrates: one abstraction tries to represent multiple
independent capabilities simultaneously, and the seams show up at runtime.

The principle is not about limiting change. It is about limiting confusion.

---

### O - Open Ecosystem, Stable Contract

**Original:** Open for extension, closed for modification.

**Restated:** A contract is closed to structural change. Its ecosystem is open to
explicit, named extension.

A contract does not need to change every time useful derived behaviour is discovered.
That behaviour lives in separately named extension points. The contract remains stable.
The ecosystem grows. Extension is declared, named, and visible to any reader.

The original formulation said nothing about how extension should work. That silence
became an escape hatch. The industry filled the gap with extension methods and default
interface members, then pretended the old rules still described the new reality.

---

### L - Verified Substitutability

**Original:** Subtypes must be substitutable for their base types.

**Restated:** Substitutability is a verified conformance fact, not a design aspiration.

This principle is violated whenever a type throws `NotSupportedException` on methods
inherited from a contract it claims to satisfy. The substitutability claim is either
true or it is false - and "check `IsFixedSize` before calling the interface method"
is a formal admission that it is false.

A type that cannot honour a contract must not implement that contract. The goal is
to make this failure impossible by construction, not merely unlikely by convention.

---

### I - Minimal Contracts, Composable Behaviour

**Original:** Clients should not be forced to depend on methods they do not use.

**Restated:** Contracts declare the smallest meaningful set of requirements. Shared
behaviour that derives from those requirements is composed explicitly, not inherited
silently.

`IList<T>` failed ISP because it was not minimal. It combined read access, indexed
access, mutation, insertion, and removal in one contract. A fixed-size collection that
honestly only supports read access and indexed write access has no contract it can
implement without lying.

A fat interface with runtime exceptions is not a pragmatic trade-off when a clean
atomic design is available. It is a failed contract protected by backwards compatibility
and defended by convention.

---

### D - Depend On Contracts, Not Constructs

**Original:** Depend on abstractions, not concretions.

**Restated:** Depend on verified contracts and named extension points, not concrete
implementation details.

The principle's goal is to insulate callers from implementation change. Depending on
a minimal contract - rather than a concrete type - means the implementation can change
without forcing callers to change. But this only works if the contract is genuinely
minimal and genuinely honoured.

---

### E - Explicit Extension

**New principle. No SOLID equivalent.**

All behavioural extension to a contract must be named, declared, inspectable, and
conflict-checked. Nothing may silently attach behaviour to a contract.

This is the principle the original SOLID did not have. It is the one that would have
prevented extension methods from being silent, would have forced Default Interface
Methods to require explicit opt-in naming, and would have made the
`Array : IList<T>` relationship impossible to compile unless `Array` could actually
honour `IList<T>`'s full contract.

A behaviour extension that is explicit only where it is declared, but invisible where
it lands, is only half explicit. The correct standard is that both the declaration
and the target must name the relationship.

---

## Summary

| Principle | Original | Restated |
|-----------|----------|----------|
| S | One reason to change | One architectural role |
| O | Open/closed | Stable contract, explicit ecosystem |
| L | Substitutability | Verified conformance, not aspiration |
| I | Minimal interfaces | Minimal contracts, composed explicitly |
| D | Depend on abstractions | Depend on verified contracts |
| E | *(new)* | All extension is named, declared, and conflict-checked |
