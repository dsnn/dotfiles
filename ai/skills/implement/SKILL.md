---
name: implement
description: Implement one approved, bounded task and verify it against its acceptance criteria. Invoke explicitly when the user wants code or configuration changed, not merely analyzed.
---

# Implement

Confirm the approved scope, repository instructions, current Git state, relevant design sources, and acceptance criteria. Skill invocation grants no permissions beyond the user's request.

Before edits, report the affected files, dependencies, risks, verification, and rollback when the repository requires an approval gate. Preserve unrelated work.

Implement the smallest coherent vertical slice. Use `tdd` when behavior can be driven through a stable seam. Keep generated files, dependency changes, migrations, external writes, commits, and deployments behind their own applicable approvals.

After editing:

1. run focused tests, then broader checks proportional to risk;
2. inspect failures instead of weakening checks;
3. review the complete diff and untracked files;
4. use `code-review` for meaningful changes;
5. compare observed behavior with every acceptance criterion.

Report exactly what changed, evidence, limitations, and rollback. Commit only when explicitly authorized.
