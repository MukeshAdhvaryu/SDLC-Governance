# DIP

Public-facing index for repository documents, user-visible source files, and public
entities. Internal implementation details live in `DIP_Internal.md`.

> This is a template DIP. It demonstrates the format and column structure using a
> fictitious project (users, orders, products). Architecture document entries link
> to working example files in this repository. Source code entries are shown as
> plain text - in your project, each should be a markdown link: `[filename.cs](relative/path/to/file.cs)`.

- Generated: YYYY-MM-DD
- Columns: `Name`, `Document Type`, `Folder`, `File Type`, `Description`.

---

## Table of Contents

- [Project Root](#project-root)
- [Architecture/ADRs](#architectureadrs)
- [Architecture/Major-Decisions](#architecturemajor-decisions)
- [Architecture/Policies](#architecturepolicies)
- [Architecture/Drift-Reports](#architecturedrift-reports)
- [Architecture/Roadmap](#architectureroadmap)
- [Architecture/Specs](#architecturespecs)
- [src/Core](#srccore)
- [src/Core/Interfaces](#srccoreinterfaces)
- [src/Domain](#srcdomain)
- [Tests/Abstractions](#testsabstractions)

---

## Project Root

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [README.md](README.md) | Project README | `/` | `.md` | Entry point: what the project is, current status, build instructions, and links to canonical documents. |
| [DIP.md](DIP.md) | Document Index | `/` | `.md` | Public-facing catalogue of all repository documents and source entities. |

---

## Architecture/ADRs

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [ADR-001-Contract-Based-Testing.md](Examples/Architecture/ADRs/ADR-001-Contract-Based-Testing.md) | ADR | `Architecture/ADRs` | `.md` | Mandates that tests target public interface contracts, not concrete implementations. |
| [ADR-002-No-Magic-Values.md](Examples/Architecture/ADRs/ADR-002-No-Magic-Values.md) | ADR | `Architecture/ADRs` | `.md` | Prohibits magic strings and numbers; all business-rule literals must be named constants. |
| [ADR-003-Layered-Architecture.md](Examples/Architecture/ADRs/ADR-003-Layered-Architecture.md) | ADR | `Architecture/ADRs` | `.md` | Establishes that Core must not reference Infrastructure; dependencies flow inward only. |

---

## Architecture/Major-Decisions

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [MD-001-Interface-Decomposition.md](Examples/Architecture/Major-Decisions/MD-001-Interface-Decomposition.md) | Major Decision | `Architecture/Major-Decisions` | `.md` | Replaces fat IRepository with atomic capability contracts: IReadable, IWritable, IDeletable. |
| [MD-002-Documentation-First.md](Examples/Architecture/Major-Decisions/MD-002-Documentation-First.md) | Major Decision | `Architecture/Major-Decisions` | `.md` | Adopts the five-tier documentation model; documentation is written before code. |

---

## Architecture/Policies

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [BEST-ENGINEERING-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/BEST-ENGINEERING-POLICY.md) | Policy | `Architecture/Policies` | `.md` | Engineering standards: constants, nesting depth, SOLID, MVP-to-production naming. |
| [DOCUMENTATION-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/DOCUMENTATION-POLICY.md) | Policy | `Architecture/Policies` | `.md` | Five-tier documentation strategy, README standards, DIP format, and cross-reference rules. |
| [DRIFT-RESOLUTION-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/DRIFT-RESOLUTION-POLICY.md) | Policy | `Architecture/Policies` | `.md` | Format and closure criteria for Drift Fix Reports. |
| [NAMING-CONVENTION-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/NAMING-CONVENTION-POLICY.md) | Policy | `Architecture/Policies` | `.md` | Positive capability naming, interface prefix conventions, and namespace/folder alignment rules. |
| [SOLIDE-DESIGN-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/SOLIDE-DESIGN-POLICY.md) | Policy | `Architecture/Policies` | `.md` | SOLIDE design philosophy: an honest successor to SOLID with Explicit Extension as the sixth principle. |
| [TESTING-STANDARDS-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/TESTING-STANDARDS-POLICY.md) | Policy | `Architecture/Policies` | `.md` | Contract-first testing standard, test categories, anti-patterns, and review criteria. |
| [WORK-DONE-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/WORK-DONE-POLICY.md) | Policy | `Architecture/Policies` | `.md` | Mandatory status table format for ADRs, MDs, DFRs, and Roadmaps. |

---

## Architecture/Drift-Reports

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [DFR-001-Repository-Layer-Bypass.md](Examples/Architecture/Drift-Reports/DFR-001-Repository-Layer-Bypass.md) | Drift Report | `Architecture/Drift-Reports` | `.md` | Service layer instantiated infrastructure directly; resolved by switching to constructor injection. |
| [DFR-002-Config-Hardcoded-In-Service.md](Examples/Architecture/Drift-Reports/DFR-002-Config-Hardcoded-In-Service.md) | Drift Report | `Architecture/Drift-Reports` | `.md` | Role names and limits hardcoded as string/number literals in UserService; partially resolved. |

---

## Architecture/Roadmap

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [RDMP-Core.md](Examples/Architecture/Roadmap/RDMP-Core.md) | Roadmap | `Architecture/Roadmap` | `.md` | Delivery tracker for user management, order processing, and product catalog domain layers. |
| [RDMP-API.md](Examples/Architecture/Roadmap/RDMP-API.md) | Roadmap | `Architecture/Roadmap` | `.md` | Delivery tracker for REST API, authentication middleware, rate limiting, and API documentation. |

---

## Architecture/Specs

> Spec entries use plain text (no links) as example files do not exist in this template.
> In your project: `[Spc-Domain.md](Architecture/Specs/Spc-Domain.md)`

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| Spc-Domain.md | Spec | `Architecture/Specs` | `.md` | Specification for domain entity rules: invariants, validation, and aggregate boundaries. |
| Spc-Persistence.md | Spec | `Architecture/Specs` | `.md` | Specification for repository contracts: query shapes, transaction scope, and error semantics. |

---

## src/Core

> Source file entries use plain text (no links) as source files do not exist in this template.
> In your project: `[UserService.cs](src/Core/UserService.cs)`

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| UserService.cs | Implementation | `src/Core` | `.cs` | Handles user authentication, registration, session management, and profile updates. |
| OrderService.cs | Implementation | `src/Core` | `.cs` | Orchestrates order creation, validation, pricing, and fulfilment dispatch. |
| ProductCatalog.cs | Implementation | `src/Core` | `.cs` | Manages product listings, category membership, and availability state. |

---

## src/Core/Interfaces

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| IUserRepository.cs | Interface | `src/Core/Interfaces` | `.cs` | Persistence contract for user entities: find by ID, find by email, save, and delete. |
| IOrderRepository.cs | Interface | `src/Core/Interfaces` | `.cs` | Persistence contract for orders: find by ID, find by user, save, and update status. |
| IProductRepository.cs | Interface | `src/Core/Interfaces` | `.cs` | Persistence contract for products: find by ID, list by category, and update availability. |

---

## src/Domain

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| User.cs | Implementation | `src/Domain` | `.cs` | User aggregate root: identity, contact details, roles, and account state. |
| Order.cs | Implementation | `src/Domain` | `.cs` | Order aggregate root: line items, pricing, state machine, and fulfilment tracking. |
| Product.cs | Implementation | `src/Domain` | `.cs` | Product entity: SKU, description, pricing tiers, and stock state. |

---

## Tests/Abstractions

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| IUserRepositoryContractTests.cs | Test | `Tests/Abstractions` | `.cs` | Abstract contract suite for IUserRepository; runs against every registered backend. |
| IOrderRepositoryContractTests.cs | Test | `Tests/Abstractions` | `.cs` | Abstract contract suite for IOrderRepository; runs against every registered backend. |
