---
name: list-skills
description: Inventory repository-managed, installed, project-specific, and built-in Codex skills without modifying them. Invoke explicitly to understand availability, origin, policy, or installation drift.
---

# List Skills

Locate and classify skills from:

- this repository's `ai/skills/` source;
- `${CODEX_HOME:-$HOME/.codex}/skills`;
- project-specific skill directories exposed by the active environment;
- built-in `.system` skills.

Read only names, descriptions, invocation policy, and symlink targets unless the user asks for deeper inspection. Do not treat two skills with the same name as interchangeable.

Report a compact table with name, purpose, source, manual/automatic policy, link state, and conflicts. For this dotfiles repository, prefer `just ai-skills-status` as the deterministic installation view.

Do not install, remove, relink, or repair skills as part of listing.
