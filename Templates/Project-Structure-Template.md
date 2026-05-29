# Project Structure Template

This template describes the recommended folder layout for a software project that
follows the SDLC governance model defined in this repository.

The key principle: **Architecture is the top-level abstraction layer.** It is
independent of the code that implements it. For projects that are ongoing or that
share design decisions across multiple repositories, Architecture should live in its
own dedicated repository (see note at the end of this document).

---

## Recommended Layout

```
ProjectName/
|
|- Architecture/                   <- Top-level, independent abstraction layer
|  |
|  |- ADRs/                        <- Architecture Decision Records
|  |   |- ADR-001-Name.md
|  |   |- ADR-002-Name.md
|  |   `- ...
|  |
|  |- Major-Decisions/             <- Large cross-cutting design decisions
|  |   |- MD-001-Name.md
|  |   `- ...
|  |
|  |- Policies/                    <- Engineering, testing, naming, and process policies
|  |   |- BEST-ENGINEERING-POLICY.md
|  |   |- DOCUMENTATION-POLICY.md
|  |   |- TESTING-STANDARDS-POLICY.md
|  |   |- NAMING-CONVENTION-POLICY.md
|  |   |- WORK-DONE-POLICY.md
|  |   |- DRIFT-RESOLUTION-POLICY.md
|  |   `- SOLIDE-DESIGN-POLICY.md
|  |
|  |- Drift-Reports/               <- Drift Fix Reports (DFRs)
|  |   |- DFR-001-Name.md
|  |   `- ...
|  |
|  |- Roadmap/                     <- Delivery roadmaps per area
|  |   |- RDMP-Core.md
|  |   |- RDMP-API.md
|  |   `- ...
|  |
|  |- Specs/                       <- Human-readable specifications per domain area
|  |   |- Spc-Domain.md
|  |   |- Spc-Persistence.md
|  |   `- ...
|  |
|  |- Semantics/                   <- Machine-checkable rule sets derived from specs
|  |   |- Sem-Domain.md
|  |   |- Sem-Persistence.md
|  |   `- ...
|  |
|  `- Progress/                    <- Status master document
|      `- Status-Master.md
|
|- DIP.md                          <- Document Index Page (public)
|- DIP_Internal.md                 <- Document Index Page (internal paths and tooling)
|- README.md                       <- Project entry point
|
|- src/                            <- Source code
|  |
|  |- Core/                        <- Core business logic (no infrastructure dependencies)
|  |   |- Interfaces/              <- Public contracts (IService, IRepository, etc.)
|  |   |- Services/                <- Service implementations
|  |   `- Models/                  <- Domain models and value types
|  |
|  |- Domain/                      <- Domain entities and aggregates
|  |   |- <Entity>.cs
|  |   `- ...
|  |
|  |- Infrastructure/              <- Database, external services, I/O
|  |   |- Persistence/
|  |   |- Messaging/
|  |   `- ...
|  |
|  `- <Platform>/                  <- Platform entry point (API, CLI, worker, etc.)
|      `- ...
|
|- Tests/
|  |
|  |- Abstractions/                <- Abstract contract test suites (one per interface)
|  |   |- IUserRepositoryTests.cs
|  |   `- ...
|  |
|  |- Implementation/              <- Concrete fixtures binding suites to implementations
|  |   |- SqlUserRepositoryFixture.cs
|  |   `- ...
|  |
|  `- Integration/                 <- End-to-end and cross-component tests
|      `- ...
|
|- Scripts/                        <- Build, migration, and utility scripts
`- Tools/                          <- Project-specific developer tooling
```

---

## Layer Rules

### Architecture layer

- Contains only documents: ADRs, decisions, policies, roadmaps, specs, and status.
- No source code, no build artifacts, no generated files.
- Changes slowly and deliberately. Each change should reference a decision record.
- The DIP.md at the repository root indexes everything in this layer.

### src layer

- Core must not reference Infrastructure. Dependencies flow inward.
- Interfaces live in Core/Interfaces. Implementations live in Infrastructure.
- Domain models must not reference services or repositories.
- Platform entry points are the only allowed reference to Infrastructure.

### Tests layer

- Abstractions contain abstract suites only. No concrete database or service calls.
- Implementation fixtures are the only place that wires a suite to a real backend.
- Integration tests may reference any layer but must not replace contract or semantic tests.

---

## Document Authority

- `DIP.md` is the authoritative index of all public files in the repository.
- `DIP_Internal.md` is the authoritative index of all files including internal paths.
- All documents must reference the DIP for path lookups - do not hard-code paths in prose.

See [DOCUMENTATION-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/DOCUMENTATION-POLICY.md)
for the full five-tier documentation model.

---

## Status Tracking

Every ADR, MD, DFR, and Roadmap must carry a status table.

See [WORK-DONE-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/WORK-DONE-POLICY.md)
for the mandatory format, column definitions, and status symbols.

---

## When Architecture Should Be a Separate Repository

For ongoing projects where design decisions span multiple codebases, the
`Architecture/` folder should be extracted into its own dedicated repository.

Move Architecture to a separate repository when:

- More than one codebase repository references the same ADRs or policies.
- Architecture documents need to be publicly accessible without exposing source code.
- The Architecture change cadence is significantly slower than the code change cadence
  and merging them creates noise.
- A new contributor should be able to read the design decisions without cloning
  the implementation.

When Architecture is a separate repository:
- The project README links to the Architecture repository for all design context.
- The DIP.md in each code repository indexes code files only.
- The Architecture repository has its own DIP.md indexing all decision documents.
- Policies in the Architecture repository apply to all linked code repositories.

This layout corresponds to Tier 2 in the documentation model: cross-project reference
material that survives project restructures and is discoverable without knowing the
implementation.

See [DOCUMENTATION-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/DOCUMENTATION-POLICY.md)
section "Tier 2 - Cross-Project Reference Repository" for the rationale.
