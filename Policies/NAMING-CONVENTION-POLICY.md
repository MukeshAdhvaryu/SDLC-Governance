# Naming Convention Policy

## Purpose

This policy records naming principles for system design, library contracts,
and architecture documents.

Names should describe the capability a construct delivers. They should avoid
absence-based or prohibitive wording when a positive capability name is available.

## Positive Capability Names

**Use positive capability names for contracts. A contract name should say what it
provides, not what it forbids.**

For example, prefer `Readable` over `ReadOnly`:

- `IReadableCollection<T>` means the contract provides collection reading.
- `IReadableList<T>` means the contract provides indexed list reading.
- A writable list can honestly inherit `IReadableList<T>` because readability is a
  delivered capability.
- A writable list inheriting `IReadOnlyList<T>` reads as a contradiction, even when
  the inherited members are technically only getters.

The same rule applies beyond collections. Prefer names such as `Counted`, `Indexed`,
`Writable`, `Resizable`, `Clearable`, `Disposable`, `Observable`, and `Queryable` when
those names state the offered capability directly.

`Disposable` is a valid positive capability name: it means the type offers deterministic
disposal/release behavior. A name such as `INotDisposable`, or a name that encodes what
the type cannot do, is the pattern this policy rejects.

## Interface Names

Interface names conventionally start with `I`, but this is a guideline, not an
enforced rule.

Use the `I` prefix when it improves recognition of a capability contract, especially for
stdlib-style contracts such as `ICount`, `IEnumerable`, `IIndexer`, `IReadableCollection`,
and `IDisposable`. Omit it when the domain name is clearer without the prefix.

## Namespace and Folder Hierarchy

Namespace naming must follow the folder hierarchy exactly. Both must reflect the same
path.

A namespace must be deducible from the folder path, and the folder path must be
deducible from the namespace. No drift is allowed.

When moving or renaming folders, update all matching namespaces, project names, and
documentation references in the same change.

## Documentation Path Authority

Repository path references are maintained in exactly two documents:

1. `DIP.md` (public document index)
2. `DIP_Internal.md` (internal document index)

All other documents must reference the DIPs for path lookup and must not be treated as
the source of truth for repository paths.

## Restriction Names

Use absence-based or restrictive names only when the restriction itself is the semantic
contract and cannot be expressed as a positive capability.

Acceptable restriction names must pass both tests:

1. The restriction is externally observable and part of the contract.
2. A positive capability name would hide or misrepresent the behavior.

## Construct Casing Conventions

| Construct | Convention | Example |
|-----------|------------|---------|
| Interface / contract | PascalCase with `I` prefix | `IReadableCollection`, `IDisposable` |
| Class / struct / record | PascalCase | `UserService`, `OrderRepository` |
| Public method | PascalCase | `GetById`, `ProcessOrder` |
| Private field | camelCase | `userId`, `orderCount` |
| Local variable | camelCase | `lineLength`, `retryCount` |
| Constant | PascalCase or SCREAMING_SNAKE | `MaxRetries`, `DEFAULT_TIMEOUT` |
| Generic type parameter | PascalCase | `T`, `TKey`, `TValue` |
