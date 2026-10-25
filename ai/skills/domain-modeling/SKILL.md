---
name: domain-modeling
description: Clarify domain concepts, terminology, boundaries, invariants, and scenarios. Use when requirements or code use overloaded language, or when a glossary or durable domain decision needs careful updating.
---

# Domain Modeling

Read the applicable code, tests, glossary, and decisions before changing terminology. Build the model from concrete scenarios, including edge cases and failure cases.

For each important concept, establish its canonical name, identity, lifecycle, invariants, relationships, ownership, transitions, and explicitly different terms.

Call out contradictions between conversation, documentation, and behavior. Prefer the repository's established vocabulary unless the user deliberately changes it.

Create documentation lazily:

- A glossary contains vocabulary, not implementation plans.
- A specification owns feature behavior.
- An ADR records a consequential, hard-to-reverse choice with genuine alternatives.
- Code comments explain local constraints, not the whole domain.

Before writing, show the proposed location and change. Never create `GLOSSARY.md` or ADR directories automatically, and never include confidential domain information in a public repository.
