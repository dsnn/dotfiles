---
name: handoff
description: Preserve the minimum reliable context another session or agent needs to continue work. Invoke explicitly at a phase boundary, context reset, or ownership transfer.
---

# Handoff

Inspect the actual working state rather than summarizing from memory. Write the handoff where the user requests or return it in chat; do not create a repository file without approval.

Include:

- objective, current phase, and exact scope;
- applicable instructions and source-of-truth documents;
- decisions, rationale, rejected alternatives, and unresolved questions;
- files changed and current Git state;
- commands run with observed results;
- failures, hypotheses, and useful logs with secrets removed;
- next concrete action and its approval requirements.

Use paths, commits, issue IDs, and links as context pointers instead of copying large content. Distinguish verified state from assumptions. Never claim a commit, test, or external action occurred unless observed.
