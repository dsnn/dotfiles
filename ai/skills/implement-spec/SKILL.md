---
name: implement-spec
description: Orchestrate an approved multi-task specification on an integration branch with isolated worktrees and optional parallel agents. This large workflow must be invoked explicitly.
---

# Implement Spec

This is an explicit exception for a bounded specification; it does not make worktrees the project's normal workflow or expand permissions.

Preconditions:

- the specification and task graph are approved and readable;
- the repository instructions permit the proposed Git operations;
- the working tree and existing worktrees are inspected;
- branch naming, integration base, validation, and cleanup are agreed;
- commits, remote writes, PR actions, deployments, and destructive cleanup have separate authorization where required.

Create one integration branch. Give each ready task an isolated branch and worktree based on the current integration tip. Parallelize only independent tasks and only when agent delegation is available and authorized. Each implementer follows `implement` and `tdd`, touches only its task scope, and reports commits plus verification.

Integrate one completed task at a time. Before merging, update it from the integration tip and rerun relevant checks. Stop on semantic conflicts, overlapping ownership, unexpected scope, or a failed invariant; never guess through them.

Advance the task frontier only after blockers are integrated. When all tasks land, run full validation and `code-review` against the original base and specification. Fix findings through a bounded task, not ad hoc edits.

Report branches, worktrees, commits, conflicts, and evidence. Remove worktrees or branches only with approval; prefer `git worktree remove` after confirming nothing unique remains. Never push, publish a PR, or deploy unless requested.
