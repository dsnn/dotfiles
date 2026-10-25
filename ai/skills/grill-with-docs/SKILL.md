---
name: grill-with-docs
description: Interview the user to refine a project idea while preserving durable terminology and decisions in the repository. Invoke explicitly when the discussion should leave a reviewed paper trail.
---

# Grill With Docs

Load `grilling` for the interview method and `domain-modeling` when terminology or durable architecture decisions are actually being resolved.

Before writing, inspect repository instructions and existing documentation. Propose the exact documents and sections to update, then follow the repository's approval workflow. Do not create a glossary, ADR directory, or planning hierarchy merely because this skill was invoked.

During the interview:

- update an existing glossary only when a domain term is settled;
- propose an ADR only for a consequential, hard-to-reverse trade-off whose rationale would otherwise be lost;
- keep feature requirements in the repository's existing specification or idea-document convention;
- label unresolved points instead of filling gaps with assumptions;
- keep work-specific or sensitive context out of public repositories.

At the end, report what was written, what remains conversational context, and whether the result is ready for `to-spec`, direct implementation, or further research.
