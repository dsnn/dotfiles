---
name: diagnosing-bugs
description: Diagnose difficult bugs and regressions through reproduction, minimization, competing hypotheses, and evidence. Use when the cause is unknown; diagnosis alone does not authorize a fix.
---

# Diagnosing Bugs

Protect sensitive data in logs and reproductions. Establish expected behavior, actual behavior, environment, frequency, and last-known-good state.

1. Build the tightest safe feedback loop that reliably detects the bug.
2. Minimize inputs, state, concurrency, and dependencies while preserving failure.
3. List competing hypotheses with predictions that distinguish them.
4. Instrument the boundary where predictions diverge; collect evidence.
5. Reject hypotheses explicitly and identify the root cause at the narrowest supported level.

For intermittent failures, record attempts, timing, seeds, and confidence; do not call a few passing runs a fix. Prefer read-only observation before changing behavior.

Report reproduction, evidence, root cause, blast radius, and a proposed regression test and fix. Implement only when the user also requested or approves the fix. After a fix, remove temporary instrumentation and verify that the regression test fails without the fix and passes with it when practical.
