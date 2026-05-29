# Documentation Policy

> Documentation is not a secondary objective. It is the first task.

A team that writes code before it writes documentation has already made a decision
about who the code is for. The answer, implied by the absence of documentation, is:
only the person who wrote it, right now, while it is still fresh. Everyone else -
the new hire, the domain expert, the future maintainer, the auditor, the operator
who gets paged at 3am - is an afterthought.

This document defines the documentation strategy for any project or organisation
that adopts it. It specifies where each category of documentation lives, why those
locations are different, how documents cross-reference each other, and what to do
when security or sensitivity constrains what can be shared.

---

## Table of Contents

- [Why Documentation Is the First Task](#why-documentation-is-the-first-task)
- [The Five Tiers](#the-five-tiers)
- [Tier 1 - Project README](#tier-1--project-readme)
- [Tier 2 - Cross-Project Reference Repository](#tier-2--cross-project-reference-repository)
- [Tier 3 - Partial Technical on the Common Domain](#tier-3--partial-technical-on-the-common-domain)
- [Tier 4 - Pure Non-Technical on the Common Domain](#tier-4--pure-non-technical-on-the-common-domain)
- [How to Write a README](#how-to-write-a-readme)
- [Why a Document Index Page Is Necessary](#why-a-document-index-page-is-necessary)
- [Cross-Reference Rules](#cross-reference-rules)
- [Security and Sensitivity Rules](#security-and-sensitivity-rules)
- [Tier Summary Cheat Sheet](#tier-summary-cheat-sheet)
- [DIP Table Format](#dip-table-format)

---

## Why Documentation Is the First Task

Documentation is not what you write after the code is done. It is what you write
to decide what the code should do.

A README written before the first commit forces the author to state: what this
does, who it is for, what it depends on, and what success looks like. These are not
documentation questions. They are design questions. The README is the cheapest
design review available.

A team that defers documentation until the code is "stable" is a team that has
confused *stable* with *finished*. Code that lacks documentation is not finished.
It is a liability: correct in the author's head, invisible to everyone else.

The cost of writing documentation late is not just the time it takes to write it.
It is:

- Decisions that cannot be traced to their reasons
- Interfaces that cannot be consumed without reading the implementation
- Onboarding that requires pairing with the original author
- Migrations that fail because nobody documented the invariants
- Audits that take weeks because nobody documented the design

**Documentation written before the code is a design tool. Documentation written
after the code is archaeology.** The difference is not just quality - it is
whether the author still has the context to write it honestly.

---

## The Five Tiers

Documentation belongs in different locations depending on its audience, its
coupling to specific code, and its sensitivity. Putting everything in one place
produces a repository that is simultaneously too detailed for domain experts and
too vague for engineers. Putting everything in a wiki produces documents that go
stale the moment the code changes.

The five tiers separate concerns correctly.

| Tier | What | Where | Audience |
|-----:|------|-------|----------|
| 1 | Project-specific: README, ADRs, status, build | Project repository | Engineers on that project |
| 2 | Cross-project: design philosophy, shared decisions, public API | Dedicated docs repository | Engineers across projects, public |
| 3 | Partial technical: feature guides, onboarding, runbooks | Wiki / Confluence | Mixed: engineers and non-engineers |
| 4 | Pure non-technical: process, policy, strategy, org decisions | Wiki / Confluence | Domain experts, leadership, compliance |
| 5 | Cross-reference | Wherever the document lives | Whoever needs the full picture |

Tier 5 is not a location. It is a rule: every document that depends on material
in another tier must link to it. See [Cross-Reference Rules](#cross-reference-rules).

---

## Tier 1 - Project README

**Location:** The repository that owns the code.

**Tightly coupled to the project.** The README lives and dies with the code. It is
versioned with the code. It is the first thing a reader sees. It is the contract
between the project and anyone who needs to understand or use it.

### What belongs in Tier 1

- What the project is and what problem it solves
- Current status: what is shipped, active, planned, designed
- Build and verification instructions
- Test counts and test project scope
- Architecture decisions local to this project (ADRs)
- Tooling status if the project exposes developer tooling
- Roadmap for this project
- Links to Tier 2 for cross-project design context
- Links to Tier 3/4 for non-technical or process context

### What does not belong in Tier 1

- Full language or domain specifications (Tier 2)
- Onboarding guides for new team members (Tier 3)
- Process documentation: hiring, sprints, ceremonies (Tier 4)
- Design philosophy essays (Tier 2)
- Anything that is true for multiple projects simultaneously

### The single test

Ask: *If this project were deleted tomorrow, would this documentation still be
useful to someone?* If yes, it does not belong in Tier 1. If it only makes sense
in the context of this specific codebase at this specific version, it belongs here.

---

## Tier 2 - Cross-Project Reference Repository

**Location:** A dedicated repository, separate from any single project.

**Loosely coupled to any specific project.** Tier 2 documents describe decisions,
designs, and standards that span multiple projects or that must be shared publicly.
They do not go stale when one project changes because they describe principles, not
implementations.

### What belongs in Tier 2

- Design philosophy and intent
- Major design decisions that affect multiple projects
- Public API design standards
- SOLIDE principles or equivalent organisational design principles
- Cross-project architecture decisions
- Ambitions and long-range strategy (the *why* behind the work)
- Document Index Pages that map the full document landscape
- Migration policies and feasibility documents that span projects
- Handoff briefs that transfer context between contributors or teams

### What does not belong in Tier 2

- Implementation details of any specific project (those stay in Tier 1)
- Process and HR policy (Tier 4)
- Step-by-step user guides (Tier 3)
- Internal build commands or developer tooling cheat sheets

### Why a separate repository

A cross-project docs repository serves a different change cadence than any
individual project. Project code changes daily. Design philosophy changes slowly
and deliberately. If philosophy documents live inside a project repository, they
are implicitly scoped to that project's version history and are discovered only by
people who already know to look there.

A standalone docs repository:
- Gives documentation a first-class home with its own contribution model
- Allows public access to philosophy and design without exposing implementation
- Creates a natural boundary between *what we decided* and *how we implemented it*
- Survives project restructures, renames, or splits

---

## Tier 3 - Partial Technical on the Common Domain

**Location:** Wiki, Confluence, or equivalent organisational knowledge base.

**Mixed audience. Mixed depth.** Tier 3 documents are for readers who need
context but not source code. They live on a platform accessible to non-engineers
without a GitHub account or development environment.

### What belongs in Tier 3

- Onboarding guides: how to set up a development environment, how to get access
- Runbooks: how to deploy, how to roll back, how to respond to an incident
- Feature guides: what a feature does, how to configure it, what the edge cases are
- Integration guides: how this system connects to external systems
- Architecture overviews with diagrams aimed at a mixed audience
- Glossaries: shared vocabulary between domain experts and engineers
- FAQ documents that arise repeatedly from users or operators

### What Tier 3 documents must do

- Link to Tier 1 (the project README) for implementation detail
- Link to Tier 2 for design decisions and philosophy
- Link to Tier 4 for process and policy that governs what is described
- Never reproduce content from Tier 1 or Tier 2 verbatim - reference it

### What Tier 3 documents must not do

- Replace the README as the authoritative project status
- Replace ADRs as the record of why decisions were made
- Embed internal architecture detail that belongs in Tier 1

---

## Tier 4 - Pure Non-Technical on the Common Domain

**Location:** Wiki, Confluence, or equivalent organisational knowledge base.

**Non-technical audience. No implementation detail.** Tier 4 is for the people
who own the domain without being responsible for the implementation: product owners,
domain experts, compliance officers, executives, legal.

### What belongs in Tier 4

- Product strategy and roadmap narratives (business language, not technical)
- Process documentation: sprints, ceremonies, escalation paths, approval chains
- Compliance and audit documentation
- Organisational policies: access control policy, incident response policy
- Meeting records that capture decisions (not their technical rationale)
- Business context for features: why they were requested, who owns them
- SLAs and SLOs stated in business terms

### What Tier 4 documents must do

- Link to Tier 3 for the mixed technical/non-technical detail
- Never assume the reader has seen a diff, a class diagram, or a test failure
- State *what* and *why* in business terms; leave *how* to lower tiers

### What Tier 4 documents must not do

- Contain source code, configuration, or build instructions
- Substitute for ADRs or design decisions (those belong in Tier 1 or Tier 2)
- Duplicate information from Tier 3 - link to it instead

---

## How to Write a README

The README is not a marketing document. It is not a tutorial. It is not a
specification. It is a *navigation instrument*: a reader picks it up and it tells
them where they are, what works, and where to go next.

### The four questions a README must answer

1. **What is this?** One paragraph. No jargon. What problem does this project
   solve? Why does it exist?

2. **What is the current state?** Tables over prose. What is shipped, active,
   planned, or designed? Nothing raises reader confidence faster than seeing that
   the author knows the difference between these four states.

3. **How do I build and verify it?** Exact commands that work. Not "you'll need to
   configure X" - actual commands. If setup is complex, link to a Tier 3 guide.

4. **Where do I go for more?** Links to the canonical documents. Not duplications
   of them - links.

### What a README must not do

- Duplicate the full specification, ADR bodies, or philosophy essays. Those have
  homes. The README points to them.
- Contain stale status. A shipped feature that is listed as "planned" destroys
  trust faster than no documentation at all.
- Apologise. "This is a work in progress" is not documentation. Every project is
  a work in progress. Say what is done. Say what is next. That is all.

### Structure that works

```
# Project Name
tagline

[status badges]

One-paragraph introduction.

## Table of Contents

## What It Is
## Current Status      <- table with clear states
## Test Coverage       <- table: project, scope, count
## Build and Verify    <- exact commands
## Roadmap             <- table: phase, feature, state
## Canonical Documents <- links to specs, ADRs, design docs
## Architecture Decisions <- ADR index with one-line summaries
```

### The staleness test

Every claim in a README is a liability if it is false. Run the README through
this test before committing:

- Is the "Current Status" table accurate today?
- Do the build commands work on a clean machine?
- Do all links resolve?
- Does the test count match your test runner's output?

If any answer is no, fix it before committing. A README with one false claim
teaches readers to distrust the whole document.

---

## Why a Document Index Page Is Necessary

A repository with fifty source files and no index is a library with no catalogue.
You can find things if you already know where they are.

The Document Index Page (DIP) solves a specific problem: *a reader who knows what
they want to understand but does not know which file contains it.* Without a DIP,
that reader reads the README, follows a few links, and eventually gives up or asks
someone. With a DIP, that reader scans a structured index and finds the file in
under a minute.

### What a DIP provides that a README does not

The README is a *narrative* entry point. It tells a story about the project. A
DIP is a *reference* entry point. It lists every named document and entity with a
one-line description, grouped by category.

| README | Document Index Page |
|--------|---------------------|
| Tells you what the project is | Tells you what every file is |
| Narrative structure | Table structure |
| Written and curated by hand | Generated or templated, verified by hand |
| Stable - changes slowly | Updated as files are added or removed |
| Points to canonical documents | IS the catalogue of canonical documents |

### What a DIP must contain

For each indexed item:

- **Name** - the file or entity name, linked to the source
- **Document Type** - what kind of document it is (spec, ADR, runbook, entity, etc.)
- **Folder** - where it lives
- **File Type** - the format
- **Description** - one sentence, no jargon, no duplication of the name

### Public vs. internal DIP

Maintain two DIPs:

- **Public DIP** - everything that can be shared outside the organisation. Links
  are to public-facing documentation only. Internal file paths, internal tooling,
  and sensitive configuration are absent.
- **Internal DIP** - everything. Includes implementation files, internal tools,
  configuration, and private design documents.

Never merge them. A document that accidentally exposes an internal file path or
internal tool name in a public DIP is a documentation failure and potentially a
security concern.

---

## Cross-Reference Rules

Documentation tiers are only useful if they are connected. An isolated document
is noise. A connected document is a node in a navigable graph.

### Rule 1 - Project README must link to Tier 2

A Tier 1 README that references design philosophy, cross-project decisions, or
the system ambition statement must link to the Tier 2 document that contains it.
It must never reproduce that content inline. The link is the contract: if the Tier
2 document changes, the README does not go stale.

### Rule 2 - Project README must link to Tier 3/4 for non-technical context

If a README contains a statement whose motivation or policy context lives in a wiki
or Confluence page, link to that page. A statement like "tests must target public
contracts" should link to the policy document that says why. The reader who needs
the policy gets the link. The reader who only needs the rule gets the statement.

### Rule 3 - Tier 3 documents must link in both directions

A partial technical document lives between the technical and non-technical worlds.
It must:

- Link **down** to Tier 1 (the project README, the specific ADR, the exact
  source file) for readers who need implementation detail
- Link **up** to Tier 4 (the policy document, the business context) for readers
  who need organisational context

A Tier 3 document that links in only one direction is incomplete.

### Rule 4 - Tier 4 documents must link to Tier 3 for depth

A pure non-technical document states the *what* and the *why*. It does not contain
the *how*. If a reader needs the *how*, the Tier 4 document links to the Tier 3
document that provides it. Tier 4 documents never embed technical detail directly.

### Rule 5 - No circular content duplication

Content must live in exactly one tier. Cross-references are links, not copies.
If the same paragraph appears in both the README and a Confluence page, one of
them will go stale. Choose which tier owns the content. The other tier links to it.

---

## Security and Sensitivity Rules

Not every document can be fully public. Some documents reference internal systems,
internal tooling, internal file paths, or decisions whose full rationale would
reveal security-sensitive architecture. The documentation strategy handles this
through *tiered disclosure* and *stripped documents*.

### Rule 1 - The public tier contains no internal paths

A document in Tier 2 (the public cross-project repository) must not contain:

- Internal file system paths (`C:\source\Repos\...`, `/home/...`)
- Internal tool names, agent names, or automation credentials
- Internal server names, endpoints, or environment variables
- Names of unreleased products, services, or partners

The text that *describes* the thing may remain. The path or identifier that *locates*
the thing internally must be removed. A reader can understand the concept without
knowing the internal path.

### Rule 2 - Stripped documents are a first-class artefact

When a full technical document (Tier 1 or Tier 2) cannot be made public due to
sensitivity, a stripped version must be maintained alongside it. The stripped
version:

- Contains all conceptual and design content that is not sensitive
- Replaces sensitive specifics (names, paths, credentials, counts) with generic
  descriptions or placeholders
- Explicitly states at the top: *"This document is a public-facing summary.
  The full technical document is available internally."*
- Links to the full internal document by name (not by path) so internal readers
  can locate it

The stripped document is not a summary. It is the same document with sensitive
content removed. The intellectual content remains intact.

### Rule 3 - Partial documents link to both versions

A Tier 3 document that references a sensitive Tier 1 or Tier 2 document must:

- Link to the stripped version for external readers
- Link to the full version for internal readers, clearly marked as internal
- Never present the stripped version as if it were the full document

If the existence of the full document is itself sensitive, the Tier 3 document
notes only that a more detailed internal document exists, without naming it.

### Rule 4 - Security concerns do not justify the absence of documentation

The correct response to "this document contains sensitive information" is a
stripped version, not no documentation. Absence of documentation is not security.
It is obscurity, and obscurity fails when the first person who knows the system
leaves the team.

---

## Tier Summary Cheat Sheet

| Question | Tier | Location |
|----------|------|----------|
| What does this project do right now? | 1 | Project README |
| Why did we make this architectural decision? | 1 | ADR in project repo |
| What is the design philosophy of this system? | 2 | Cross-project docs repo |
| What are the cross-project standards? | 2 | Cross-project docs repo |
| How do I onboard to this project? | 3 | Wiki / Confluence |
| How do I run a deployment? | 3 | Wiki / Confluence |
| What is the business case for this feature? | 4 | Wiki / Confluence |
| What is the access control policy? | 4 | Wiki / Confluence |
| This doc references sensitive internal detail | stripped | Public version alongside full version |

### The acid test for tier placement

1. **Does this go stale when a single project changes?** - Tier 1.
2. **Is this true across projects or for the public?** - Tier 2.
3. **Does this need to be readable by non-engineers?** - Tier 3 or 4.
4. **Is this purely organisational with no implementation detail?** - Tier 4.
5. **Does this reference sensitive specifics?** - Tier 1 or Tier 2 with a stripped
   version alongside it.

---

## The Closing Argument

An organisation that treats documentation as optional has made a hiring decision:
it can only function if every member holds the full system model in their head,
all the time, forever. Every person who leaves takes irreplaceable context with
them. Every person who joins costs weeks of pairing time. Every incident post-mortem
begins with "we didn't document that assumption."

Documentation is not bureaucracy. Bureaucracy documents processes to control people.
Documentation documents decisions to respect the people who come after.

The five tiers are not overhead. They are the answer to a question that every
growing team eventually asks: *why does it take six months to get a new engineer
to full productivity?* The answer, almost always, is that the documentation
strategy was an afterthought.

Make it the first task.

---

## DIP Table Format

A Document Index Page entry follows this column structure. One row per indexed item.

| Name | Document Type | Folder | File Type | Description |
|------|---------------|--------|-----------|-------------|
| [UserService.cs](src/Core/UserService.cs) | Implementation | `src/Core` | `.cs` | Handles user authentication, registration, and profile management. |

Column rules:

- **Name** - link text is the filename; href is the relative path from the repo root.
- **Document Type** - one of: `ADR`, `Major Decision`, `Drift Report`, `Roadmap`, `Policy`, `Spec`, `Semantic`, `Implementation`, `Interface`, `Test`, `Tool`, `Config`, `Script`.
- **Folder** - the containing folder as a code-formatted relative path.
- **File Type** - the file extension, code-formatted.
- **Description** - one sentence. Does not repeat the filename. States what the item *does*, not what it *is*.
