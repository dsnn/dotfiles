# Recovery and resumption

Use this procedure only when ordinary task execution cannot continue or when resuming an interrupted `implement-spec` run.

## Reconstruct before acting

Treat Git and observed verification as authoritative. Read the integration branch, base commit, worktree list, task branches, commits, diffs, and the chosen durable task-state source. Do not trust a stale agent message or infer completion from a branch name.

Classify every task using its existing identifier:

- **ready** — blockers are integrated and no work has started;
- **active** — an owned worktree has verified ongoing work;
- **partial** — useful changes exist but acceptance criteria are incomplete;
- **failed** — execution stopped with recorded failure evidence;
- **integrated** — the reviewed task commit is present on the integration branch;
- **blocked** — progress requires a decision, conflict resolution, permission, or external change.

Record the observed branch, worktree, commit, covered requirement and acceptance-criterion identifiers, and verification evidence. Mark missing evidence as unverified.

## Failed or missing agent

Inspect its worktree and diff without modifying them. Preserve useful partial work and logs. Do not integrate unverified changes, delete the worktree, or automatically retry.

Resume in the same worktree only when ownership is clear and its state is understood. Otherwise propose a successor worktree or bounded recovery task. One failed attempt is enough to stop and report when the same cause remains; never create an unbounded retry loop.

## Partial task

Keep completed and remaining acceptance criteria separate. Revalidate any claimed passes. Continue only the remaining scope, preserving the original task and requirement identifiers. If the partial implementation changed the intended design, stop for a new decision instead of silently updating the specification.

## Integration conflict

Do not resolve semantic conflicts by choosing a side mechanically. Preserve both task branches, identify the conflicting requirements or decisions, and propose an explicit integration resolution with affected tests and rollback. Resume the frontier only after the resolution is approved, applied, and revalidated.

## Interrupted session

Reconstruct the task graph and integration frontier from durable artifacts and Git. Confirm the integration base has not moved unexpectedly and that no worktree has uncommitted or unreported changes. Re-run the smallest checks needed to trust prior evidence before assigning more work.

## Safe stop

Stop with a handoff when state cannot be reconstructed, ownership overlaps, evidence is missing, permissions are insufficient, a decision changed, or a conflict remains semantic. The handoff must identify current states, branches and worktrees, last verified commits, failed or unrun checks, unresolved approvals, and the next safe action. Cleanup, force operations, remote writes, and task closure remain separately authorized.
