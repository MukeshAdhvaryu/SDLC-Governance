# DIP

Public-facing index for repository documents, user-visible source files, and public
entities. Internal implementation details live in `DIP_Internal.md`.

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
| [ADR-001-Initial-Architecture.md](Architecture/ADRs/ADR-001-Initial-Architecture.md) | ADR | `Architecture/ADRs` | `.md` | Establishes the layered architecture and the rule that business logic must not depend on infrastructure. |
| [ADR-002-Contract-Based-Testing.md](Architecture/ADRs/ADR-002-Contract-Based-Testing.md) | ADR | `Architecture/ADRs` | `.md` | Mandates that tests target public contracts rather than implementation internals. See [TESTING-STANDARDS-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/TESTING-STANDARDS-POLICY.md). |
| [ADR-003-No-Magic-Values.md](Architecture/ADRs/ADR-003-No-Magic-Values.md) | ADR | `Architecture/ADRs` | `.md` | Prohibits magic strings and numbers; all constants must be named at the appropriate scope. See [BEST-ENGINEERING-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/BEST-ENGINEERING-POLICY.md). |

---

## Architecture/Major-Decisions

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [MD-001-Interface-Decomposition.md](Architecture/Major-Decisions/MD-001-Interface-Decomposition.md) | Major Decision | `Architecture/Major-Decisions` | `.md` | Adopts atomic interface decomposition over fat contracts; establishes the SOLIDE design model. See [SOLIDE-DESIGN-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/SOLIDE-DESIGN-POLICY.md). |
| [MD-002-Documentation-First.md](Architecture/Major-Decisions/MD-002-Documentation-First.md) | Major Decision | `Architecture/Major-Decisions` | `.md` | Establishes documentation as the first engineering task and the five-tier documentation model. See [DOCUMENTATION-POLICY.md](https://github.com/MukeshAdhvaryu/SDLC-Governance/blob/main/Policies/DOCUMENTATION-POLICY.md). |

---

## Architecture/Policies

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [BEST-ENGINEERING-POLICY.md](Architecture/Policies/BEST-ENGINEERING-POLICY.md) | Policy | `Architecture/Policies` | `.md` | Engineering standards: constants, nesting depth, SOLID, MVP-to-production naming. |
| [DOCUMENTATION-POLICY.md](Architecture/Policies/DOCUMENTATION-POLICY.md) | Policy | `Architecture/Policies` | `.md` | Five-tier documentation strategy, README standards, DIP format, and cross-reference rules. |
| [DRIFT-RESOLUTION-POLICY.md](Architecture/Policies/DRIFT-RESOLUTION-POLICY.md) | Policy | `Architecture/Policies` | `.md` | Format and closure criteria for Drift Fix Reports (DFRs). |
| [NAMING-CONVENTION-POLICY.md](Architecture/Policies/NAMING-CONVENTION-POLICY.md) | Policy | `Architecture/Policies` | `.md` | Positive capability naming, interface prefix conventions, and namespace/folder alignment rules. |
| [SOLIDE-DESIGN-POLICY.md](Architecture/Policies/SOLIDE-DESIGN-POLICY.md) | Policy | `Architecture/Policies` | `.md` | SOLIDE design philosophy: an honest successor to SOLID with Explicit Extension as the sixth principle. |
| [TESTING-STANDARDS-POLICY.md](Architecture/Policies/TESTING-STANDARDS-POLICY.md) | Policy | `Architecture/Policies` | `.md` | Contract-first testing standard, test categories, anti-patterns, and review criteria. |
| [WORK-DONE-POLICY.md](Architecture/Policies/WORK-DONE-POLICY.md) | Policy | `Architecture/Policies` | `.md` | Mandatory status table format for ADRs, MDs, DFRs, and Roadmaps. |

---

## Architecture/Drift-Reports

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [DFR-001-Repository-Layer-Bypass.md](Architecture/Drift-Reports/DFR-001-Repository-Layer-Bypass.md) | Drift Report | `Architecture/Drift-Reports` | `.md` | Service layer calling database directly; intended design routes all persistence through repository interfaces. |
| [DFR-002-Config-Hardcoded-In-Service.md](Architecture/Drift-Reports/DFR-002-Config-Hardcoded-In-Service.md) | Drift Report | `Architecture/Drift-Reports` | `.md` | Configuration values embedded as string literals in OrderService; ADR-003 requires named constants. |

---

## Architecture/Roadmap

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [RDMP-Core.md](Architecture/Roadmap/RDMP-Core.md) | Roadmap | `Architecture/Roadmap` | `.md` | Delivery tracker for core domain model, repository layer, and service pipeline. |
| [RDMP-API.md](Architecture/Roadmap/RDMP-API.md) | Roadmap | `Architecture/Roadmap` | `.md` | Delivery tracker for REST API surface, authentication, and rate limiting. |

---

## Architecture/Specs

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [Spc-Domain.md](Architecture/Specs/Spc-Domain.md) | Spec | `Architecture/Specs` | `.md` | Specification for domain entity rules: invariants, validation, and aggregate boundaries. |
| [Spc-Persistence.md](Architecture/Specs/Spc-Persistence.md) | Spec | `Architecture/Specs` | `.md` | Specification for repository contracts: query shapes, transaction scope, and error semantics. |

---

## src/Core

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [UserService.cs](src/Core/UserService.cs) | Implementation | `src/Core` | `.cs` | Handles user authentication, registration, session management, and profile updates. |
| [OrderService.cs](src/Core/OrderService.cs) | Implementation | `src/Core` | `.cs` | Orchestrates order creation, validation, pricing, and fulfilment dispatch. |
| [ProductCatalog.cs](src/Core/ProductCatalog.cs) | Implementation | `src/Core` | `.cs` | Manages product listings, category membership, and availability state. |

---

## src/Core/Interfaces

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [IUserRepository.cs](src/Core/Interfaces/IUserRepository.cs) | Interface | `src/Core/Interfaces` | `.cs` | Persistence contract for user entities: find by ID, find by email, save, and delete. |
| [IOrderRepository.cs](src/Core/Interfaces/IOrderRepository.cs) | Interface | `src/Core/Interfaces` | `.cs` | Persistence contract for orders: find by ID, find by user, save, and update status. |
| [IProductRepository.cs](src/Core/Interfaces/IProductRepository.cs) | Interface | `src/Core/Interfaces` | `.cs` | Persistence contract for products: find by ID, list by category, and update availability. |

---

## src/Domain

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [User.cs](src/Domain/User.cs) | Implementation | `src/Domain` | `.cs` | User aggregate root: identity, contact details, roles, and account state. |
| [Order.cs](src/Domain/Order.cs) | Implementation | `src/Domain` | `.cs` | Order aggregate root: line items, pricing, state machine, and fulfilment tracking. |
| [Product.cs](src/Domain/Product.cs) | Implementation | `src/Domain` | `.cs` | Product entity: SKU, description, pricing tiers, and stock state. |

---

## Tests/Abstractions

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [IUserRepositoryContractTests.cs](Tests/Abstractions/IUserRepositoryContractTests.cs) | Test | `Tests/Abstractions` | `.cs` | Abstract contract suite for IUserRepository; runs against every registered backend. |
| [IOrderRepositoryContractTests.cs](Tests/Abstractions/IOrderRepositoryContractTests.cs) | Test | `Tests/Abstractions` | `.cs` | Abstract contract suite for IOrderRepository; runs against every registered backend. |
