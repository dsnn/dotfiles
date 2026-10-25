---
name: to-spec
description: Turn settled discussion and verified repository context into an implementation-ready specification. Invoke explicitly for work that must survive multiple sessions or be reviewed before task planning.
---

# To Spec

Synthesize; do not reopen discovery unless a missing decision makes the specification unsafe or ambiguous. Inspect repository instructions, relevant code, existing plans, and overlapping work first.

Use the project's existing specification location and tracker convention. If none exists, propose a local Markdown path and wait for approval before writing. Do not force GitHub, Azure DevOps, or a new documentation tree.

Include:

- problem and desired outcome;
- scope and explicit non-goals;
- users or callers and observable behavior;
- domain terms and settled decisions;
- affected interfaces and test seams;
- functional and operational acceptance criteria;
- migration, compatibility, security, and rollback where relevant;
- unresolved questions that prevent implementation.

Every requirement must trace to conversation, repository evidence, or a cited source. Label assumptions instead of inventing completeness. Finish by identifying whether the spec is ready for `plan-tasks`.
