---
name: plan-tasks
description: Break an approved specification or plan into testable, dependency-aware tasks. Invoke explicitly when work needs sequencing across sessions, people, or parallel agents.
---

# Plan Tasks

Read the complete source specification and repository instructions. Confirm that blocking product decisions are settled; return unresolved decisions rather than disguising them as tasks.

Create vertical slices that leave behavior verifiable, not horizontal layers such as “models,” “services,” and “tests.” Each task must contain:

- outcome and parent specification;
- relevant context pointers;
- in-scope and out-of-scope work;
- observable acceptance criteria;
- verification command or evidence;
- dependencies expressed as task identifiers;
- risks or approval gates.

Keep dependencies acyclic and minimal. Identify the ready frontier: tasks whose blockers are already complete.

Use the project's configured tracker if one is documented. Otherwise propose local Markdown tasks beside the specification. Preview all external issue creation and require approval before writing to GitHub, Azure DevOps, or another service.

This skill plans work; it does not start implementation.
