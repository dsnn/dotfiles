---
name: improve-skill
description: Review and improve an existing repository-managed skill using observed behavior, current conventions, and focused validation. Invoke explicitly when a skill is unclear, unreliable, or stale.
---

# Improve Skill

Use Codex's built-in `$skill-creator` as the governing authoring workflow. Confirm the target is repository-managed; do not edit first-party, plugin, or unrelated global skills.

Inspect the skill, its metadata and resources, callers, documentation, and concrete failure or desired behavior. Prefer a narrow correction over general expansion.

Before editing, state:

- evidence for the problem;
- intended trigger and non-trigger cases;
- exact files affected;
- compatibility and permission implications;
- validation and rollback.

Preserve invocation policy unless the user approved a change. Keep `SKILL.md` concise, move conditional detail to referenced files only when useful, and replace repeated deterministic logic with a tested script.

Run `quick_validate.py`, toolkit validation, relevant script tests, and realistic forward tests when risk warrants them. Update Swedish toolkit documentation when behavior or dependencies change.
