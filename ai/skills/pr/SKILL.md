---
name: pr
description: Prepare or review a pull request summary from the actual diff and verification evidence. Use when the user wants a PR body, readiness review, or merge-risk assessment.
---

# Pr

Inspect the branch diff, commits, originating issue or specification, and observed validation. Never claim tests, screenshots, reviews, or deployments that were not observed.

Draft:

- **Summary:** why the change exists and the smallest useful explanation of what changed;
- **Evidence:** exact commands and results, plus before/after evidence when behavior or visuals changed;
- **Merge danger:** reversibility, blast radius, migrations or compatibility concerns, rollout, and rollback;
- **Related work:** tracker references only when verified.

Use a compact table or ASCII diagram only when it materially clarifies multiple mappings or a flow. Keep implementation details out unless reviewers need them to assess risk.

Preparing text is read-only. Creating, updating, marking ready, merging, or commenting on a PR is an external write and requires explicit approval.
