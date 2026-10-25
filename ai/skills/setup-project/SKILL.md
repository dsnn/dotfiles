---
name: setup-project
description: Preview and apply this toolkit's project-level AGENTS.md template, with optional .NET, Azure Functions, and Avalonia profiles. Invoke explicitly for initial setup or managed-section updates.
---

# Setup Project

Locate the dotfiles repository from this skill's real path, then use its `scripts/ai-project` utility. Inspect the target repository and its applicable instructions first.

For initial setup or update:

1. choose only profiles supported by repository evidence or the user's request: `dotnet`, `azure-functions`, `avalonia`;
2. run `scripts/ai-project preview --project <path> [--profile <name> ...]`;
3. explain the diff, managed-section boundary, collisions, and rollback;
4. obtain approval required by the target repository;
5. run the same command with `apply`;
6. review the resulting diff and validate the target repository.

The utility manages only its marked block in root `AGENTS.md`. It must refuse a modified managed block and never overwrite content outside it. Do not create plans, ADRs, glossaries, task stores, or stack profiles that were not selected.
