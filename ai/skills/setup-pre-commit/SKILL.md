---
name: setup-pre-commit
description: Design and configure a small pre-commit guardrail using a project's existing checks. Invoke explicitly when the user wants local commit-time validation added or repaired.
---

# Setup Pre Commit

Inspect the language, package manager, existing check commands, hooks, CI, contributor workflow, and repository instructions. Reuse an existing hook manager before adding another dependency.

Propose a fast default set that catches mechanical mistakes. Keep slow integration, network, and environment-dependent checks in CI unless the user wants them locally. Explain bypass and recovery behavior.

Before mutation, show exact files, new dependencies, estimated runtime, installation steps, CI relationship, and rollback. Obtain approval required by the repository.

After implementation, run the underlying commands directly and then exercise the hook in a safe way that does not create an unwanted commit. Do not install global software, rewrite Git configuration, or enable hooks outside the target repository without explicit approval.
