---
name: codebase-design
description: Evaluate module interfaces, seams, coupling, locality, and testability. Use when designing or restructuring code and when architectural choices need a concrete vocabulary.
---

# Codebase Design

Prefer deep modules: a small, stable interface hiding substantial behavior. Treat an interface as everything callers must know, including invariants, errors, ordering, configuration, and performance constraints.

Use these checks:

- **Leverage:** does the interface provide meaningful capability without making every caller repeat policy?
- **Locality:** can a change or bug be understood and fixed mainly in one place?
- **Seam:** is there a useful place to vary or test behavior without exposing internals?
- **Deletion test:** if the abstraction disappeared, would complexity vanish or spread across callers?
- **Reality test:** does a seam serve actual variation, or only a hypothetical future?

Prefer tests through the same interface used by real callers. Accept dependencies at an appropriate boundary and return observable results where practical. Do not add layers, repositories, factories, or interfaces solely to satisfy a pattern.

Present alternatives with affected callers, migration cost, failure modes, and rollback. Architecture analysis does not authorize a refactor.
