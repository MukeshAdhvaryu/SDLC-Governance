# FFM-NNN: The Question, Stated as a Question

**Opened:** YYYY-MM-DD
**Status:** Open | Concluded | Abandoned
**Author:** Name, in deliberation with Name

---

> **What an FFM is.** A Fact-Finding Mission (spike) gathers evidence about a question
> the team cannot yet answer. It is not a decision (ADR/MD) and not a unit of work (DFR).
> It produces *findings*, then hands off. It never closes by implementing something.
>
> **Rules.**
> 1. Facts and opinions live in separate sections. Every fact row carries a source.
> 2. Code written during an FFM is scratch only and is never merged.
> 3. An FFM closes by hand-off: each finding is routed to a decision (ADR/MD), a unit of
>    work (DFR), or nowhere (recorded and dropped).
> 4. Closure is by exit criteria, not by calendar.

---

## Question

One sentence, answerable by facts. If it can only be answered by choosing, it is an
ADR/MD, not an FFM.

## Trigger

What prompted this? A recurring pain, a design discussion, a defect class, an incoming
requirement. Link the origin.

## Scope and Non-Scope

**In scope:**

- ...

**Out of scope (and why):**

- ...

## Method

What will be examined and how, so a second person could repeat it.

| Source of evidence | How it is examined | Output |
|--------------------|--------------------|--------|
| Our own codebase | ... | ... |
| Prior art (other languages, libraries, papers) | ... | ... |
| Experiments (scratch code, measurements) | ... | ... |

## Exit Criteria

The FFM may be marked Concluded when all of these hold:

- [ ] Every question in Scope has a finding, or is recorded under Open Questions.
- [ ] Every finding is routed in the Hand-off table.
- [ ] ...

## Facts

Evidence only. No recommendations. No adjectives that carry a verdict.

| # | Fact | Source | Date observed |
|---|------|--------|---------------|
| F1 | ... | path, link, or command | YYYY-MM-DD |

## Findings

What the facts, taken together, show. Each finding cites the facts it rests on.

| # | Finding | Rests on |
|---|---------|----------|
| N1 | ... | F1, F2 |

## Candidate Outcomes

Options the findings open up. Listing an option here is **not** a decision.

| Option | What it would take | Likely home |
|--------|--------------------|-------------|
| ... | ... | ADR / MD / DFR / none |

## Hand-off

Filled when the FFM concludes.

| Finding | Routed to | Reference |
|---------|-----------|-----------|
| N1 | ADR / MD / DFR / dropped | ADR-NNN, DFR-NNN, or reason |

## Open Questions

- [ ] Question text - Owner: Name. Resolved when: condition.

## References

- Related ADR / MD / DFR / spec / policy
- Prior art
