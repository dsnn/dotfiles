---
name: wizard
description: Design an interactive script for manual setup, credential entry, migration, or cutover steps that an agent cannot perform. Use when a human must safely complete a repeatable multi-stage procedure.
---

# Wizard

Inspect the repository and current official documentation first. List the stages, values produced, secret classification, destinations, irreversible actions, and recovery path. Confirm this design before writing the script.

The script should:

- use strict shell mode and clear progress;
- verify prerequisites without installing them;
- hide secret input and never echo credentials;
- be resumable or idempotent where practical;
- confirm immediately before external or irreversible actions;
- provide a dry-run when the underlying operations allow it;
- stop safely on error and explain recovery.

Do not invent current dashboard paths or API behavior. Do not embed credentials, automatically run the completed wizard, or commit an ephemeral wizard unless requested.

Validate syntax, run `shellcheck` when available, and statically trace every captured value to its destination.
