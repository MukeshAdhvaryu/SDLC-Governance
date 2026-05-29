# SDLC-Governance

Engineering policies, document templates, and project structure guidelines for
maintaining effective SDLC governance in a software development organisation.

These materials are extracted from production use. They are generic and apply to
any project regardless of language or platform.

Pin to a version tag so changes to this repository do not silently affect
in-flight work. See [CONTRIBUTING.md](CONTRIBUTING.md) for the versioning model.

---

## What Is Here

### Policies

Ready-to-adopt engineering policies. Copy them into your project's Architecture
folder and reference them from your ADRs and README.

| Policy | Summary |
|--------|---------|
| [ONBOARDING-POLICY.md](Policies/ONBOARDING-POLICY.md) | Pre-joining preparation, day-one agenda, and 30/60/90-day milestones that eliminate the serial access-waiting problem costing new joiners their first two weeks. |
| [ROLE-ACCESS-POLICY.md](Policies/ROLE-ACCESS-POLICY.md) | Role-based software and access checklist with dependency ordering and service-portal guidance - so requests run in parallel before day one, not serially after it. |
| [BEST-ENGINEERING-POLICY.md](Policies/BEST-ENGINEERING-POLICY.md) | Constants, nesting depth, SOLID, and MVP-to-production naming rules. |
| [DOCUMENTATION-POLICY.md](Policies/DOCUMENTATION-POLICY.md) | Five-tier documentation strategy, README standards, DIP format, and cross-reference rules. |
| [DRIFT-RESOLUTION-POLICY.md](Policies/DRIFT-RESOLUTION-POLICY.md) | Format and closure criteria for Drift Fix Reports. |
| [NAMING-CONVENTION-POLICY.md](Policies/NAMING-CONVENTION-POLICY.md) | Positive capability naming, interface conventions, and namespace alignment. |
| [SOLIDE-DESIGN-POLICY.md](Policies/SOLIDE-DESIGN-POLICY.md) | SOLIDE: an honest successor to SOLID with Explicit Extension as the sixth principle. |
| [TESTING-STANDARDS-POLICY.md](Policies/TESTING-STANDARDS-POLICY.md) | Contract-first testing, test categories, anti-patterns, and review criteria. |
| [WORK-DONE-POLICY.md](Policies/WORK-DONE-POLICY.md) | Mandatory status table format for ADRs, MDs, DFRs, and Roadmaps. |

### Templates

Document templates with writing instructions. Use them as starting points.

| Template | Summary |
|----------|---------|
| [ADR-Template.md](Templates/ADR-Template.md) | Architecture Decision Record. |
| [MD-Template.md](Templates/MD-Template.md) | Major Decision - for large cross-cutting design choices with full deliberation. |
| [DFR-Template.md](Templates/DFR-Template.md) | Drift Fix Report - for gaps between intended design and current behaviour. |
| [RDMP-Template.md](Templates/RDMP-Template.md) | Roadmap - phased delivery tracker with status table. |
| [DIP-Template.md](Templates/DIP-Template.md) | Document Index Page - repository catalogue with working example links and instructions. |
| [Semantic-Rule-Template.md](Templates/Semantic-Rule-Template.md) | Guide for writing machine-checkable semantic rules derived from specifications. |
| [Specification-Template.md](Templates/Specification-Template.md) | Guide for writing human-readable specifications for a system area. |
| [Project-Structure-Template.md](Templates/Project-Structure-Template.md) | Recommended folder layout with Architecture as the top-level independent layer. |
| [Onboarding-Journey-Recorder.md](Templates/Onboarding-Journey-Recorder.md) | Per-joiner living document tracking access grants, induction sessions, mandatory training, role-specific setup, and day-one logistics. |
| [github-actions-validate.yml](Templates/github-actions-validate.yml) | GitHub Actions workflow template - copy to .github/workflows/ in your project. |

### Examples

Filled-out documents showing the templates applied to a fictitious project (users,
orders, products). The [DIP-Template.md](Templates/DIP-Template.md) links to these
so every entry resolves.

| Example | What it shows |
|---------|--------------|
| [ADR-001-Contract-Based-Testing.md](Examples/Architecture/ADRs/ADR-001-Contract-Based-Testing.md) | Full ADR with status table, context, decision, rationale, and consequences. |
| [ADR-002-No-Magic-Values.md](Examples/Architecture/ADRs/ADR-002-No-Magic-Values.md) | ADR with partial status - some items shipped, one still in progress. |
| [ADR-003-Layered-Architecture.md](Examples/Architecture/ADRs/ADR-003-Layered-Architecture.md) | ADR with a deferred item (architecture enforcement test). |
| [MD-001-Interface-Decomposition.md](Examples/Architecture/Major-Decisions/MD-001-Interface-Decomposition.md) | Major Decision with problem statement, positions, and deliberation record. |
| [MD-002-Documentation-First.md](Examples/Architecture/Major-Decisions/MD-002-Documentation-First.md) | Major Decision with fully shipped status table. |
| [DFR-001-Repository-Layer-Bypass.md](Examples/Architecture/Drift-Reports/DFR-001-Repository-Layer-Bypass.md) | Resolved drift with complete journey log and task evidence. |
| [DFR-002-Config-Hardcoded-In-Service.md](Examples/Architecture/Drift-Reports/DFR-002-Config-Hardcoded-In-Service.md) | In-progress drift with partially resolved tasks and a deferred CI check. |
| [RDMP-Core.md](Examples/Architecture/Roadmap/RDMP-Core.md) | Roadmap with mixed status: shipped, in-progress, and not-started rows. |
| [RDMP-API.md](Examples/Architecture/Roadmap/RDMP-API.md) | Roadmap with a deferred integration test suite and a known gaps table. |

### Tools

Scripts that enforce the policies mechanically. Run them locally or wire them
into CI using the provided GitHub Actions template.

| Tool | What it checks |
|------|---------------|
| [Tools/validate-governance.ps1](Tools/validate-governance.ps1) | PowerShell. Run from your repo root. |
| [Tools/validate-governance.sh](Tools/validate-governance.sh) | Bash. Run from your repo root. |

**Default checks (always run):**
- `DIP.md` exists at the repository root
- Every ADR has a `## Status` section
- Every Major Decision has a `## Status` section
- Every Drift Report has a `## Status` section
- Every Roadmap file has a `## Status` section
- ADR files follow the `ADR-NNN-Name.md` naming convention
- MD files follow the `MD-NNN-Name.md` naming convention
- DFR files follow the `DFR-NNN-Name.md` naming convention

**Strict mode checks (`--strict` flag):**
- No em dashes (use hyphen `-`)

```powershell
# From your project root (Windows)
.\Tools\validate-governance.ps1
.\Tools\validate-governance.ps1 -Strict

# From your project root (Linux/macOS)
bash Tools/validate-governance.sh
bash Tools/validate-governance.sh Architecture --strict
```

---

## How to Adopt

1. Copy `Tools/validate-governance.ps1` and `validate-governance.sh` into your project.
2. Copy the relevant policies into `Architecture/Policies/` in your project.
3. Copy the templates you need from `Templates/` and fill them out.
4. Copy `Templates/github-actions-validate.yml` to `.github/workflows/validate-governance.yml`.
5. Note the version tag you adopted in your project README or DIP.

---

## Status Symbols

All status tables in this repository use ASCII symbols per [WORK-DONE-POLICY.md](Policies/WORK-DONE-POLICY.md):

| Symbol | Meaning |
|--------|---------|
| `[x]` | Shipped - complete and verified |
| `[ ]` | Not done - not started |
| `[~]` | Partial - some items done, some not |
| `[*]` | WIP - actively in progress |
| `[.]` | Deferred - intentionally postponed |
| `[!]` | Cancelled - decided against; row preserved for audit trail |
