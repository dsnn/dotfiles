---
name: code-review
description: Review a diff for concrete correctness, security, maintainability, compatibility, and specification failures. Use when asked to review changes or as the closing check for meaningful implementation.
---

# Code Review

Pin the fixed point: working tree versus `HEAD`, branch versus merge base, or the exact PR commits. Read repository instructions, the originating requirement, and relevant tests before judging style.

Review on two axes:

1. **Correctness and standards:** bugs, security, data loss, races, error handling, compatibility, performance, maintainability, and violated repository rules.
2. **Intent:** missing acceptance criteria, unintended behavior, scope creep, and weak or misleading verification.

Use parallel independent review passes only when delegation is available and the change warrants it; otherwise keep the axes separate in one pass. Inspect enough surrounding code to prove each finding.

Report findings first, ordered by severity. Each finding needs a precise location, triggering scenario, consequence, and the smallest safe correction. Do not report speculative preferences as defects. If no findings remain, say so and state residual testing gaps.

Review is read-only unless the user also asks for fixes.
