# SDLC-Governance

Engineering policies, document templates, and project structure guidelines for
maintaining effective SDLC governance in a software development organisation.

These materials are extracted from production use. They are generic and apply to
any project regardless of language or platform.

---

## What Is Here

### Policies

Ready-to-adopt engineering policies. Copy them into your project's Architecture
folder and reference them from your ADRs and README.

| Policy | Summary |
|--------|---------|
| [BEST-ENGINEERING-POLICY.md](Policies/BEST-ENGINEERING-POLICY.md) | Constants, nesting depth, SOLID, and MVP-to-production naming rules. |
| [DOCUMENTATION-POLICY.md](Policies/DOCUMENTATION-POLICY.md) | Five-tier documentation strategy, README standards, DIP format, and cross-reference rules. |
| [DRIFT-RESOLUTION-POLICY.md](Policies/DRIFT-RESOLUTION-POLICY.md) | Format and closure criteria for Drift Fix Reports. |
| [NAMING-CONVENTION-POLICY.md](Policies/NAMING-CONVENTION-POLICY.md) | Positive capability naming, interface conventions, and namespace alignment. |
| [SOLIDE-DESIGN-POLICY.md](Policies/SOLIDE-DESIGN-POLICY.md) | SOLIDE: an honest successor to SOLID with Explicit Extension as the sixth principle. |
| [TESTING-STANDARDS-POLICY.md](Policies/TESTING-STANDARDS-POLICY.md) | Contract-first testing, test categories, anti-patterns, and review criteria. |
| [WORK-DONE-POLICY.md](Policies/WORK-DONE-POLICY.md) | Mandatory status table format for ADRs, MDs, DFRs, and Roadmaps. |

### Templates

Document templates with instructions. Use them as starting points.

| Template | Summary |
|----------|---------|
| [ADR-Template.md](Templates/ADR-Template.md) | Architecture Decision Record. |
| [MD-Template.md](Templates/MD-Template.md) | Major Decision - for large cross-cutting design choices with full deliberation. |
| [DFR-Template.md](Templates/DFR-Template.md) | Drift Fix Report - for gaps between intended design and current behaviour. |
| [RDMP-Template.md](Templates/RDMP-Template.md) | Roadmap - phased delivery tracker with status table. |
| [DIP-Template.md](Templates/DIP-Template.md) | Document Index Page - repository catalogue with dummy entries and policy links. |
| [Semantic-Rule-Template.md](Templates/Semantic-Rule-Template.md) | Guide for writing machine-checkable semantic rules derived from specifications. |
| [Specification-Template.md](Templates/Specification-Template.md) | Guide for writing human-readable specifications for a system area. |
| [Project-Structure-Template.md](Templates/Project-Structure-Template.md) | Recommended folder layout with Architecture as the top-level independent layer. |

---

## How to Use This

1. Copy the relevant policies into `Architecture/Policies/` in your project.
2. Use the templates in `Templates/` as starting points for your ADRs, roadmaps, and DIP.
3. Reference policies from your ADRs using the public URLs in this repository.
4. For ongoing projects, consider extracting `Architecture/` into its own repository -
   see [Project-Structure-Template.md](Templates/Project-Structure-Template.md) for when
   and how to do this.

---

## Status Symbols

All status tables in this repository use these ASCII symbols:

| Symbol | Meaning |
|--------|---------|
| `[x]` | Shipped - complete and verified |
| `[ ]` | Not done - not started |
| `[~]` | Partial - some items done, some not |
| `[*]` | WIP - actively in progress |
| `[.]` | Deferred - intentionally postponed |
| `[!]` | Cancelled - decided against; row preserved for audit trail |

See [WORK-DONE-POLICY.md](Policies/WORK-DONE-POLICY.md) for the full format.
