---
name: retro
description: Review a completed session and propose evidence-based improvements to the agent environment. Invoke explicitly after work that exposed repeatable friction or failure.
---

# Retro

Read the session evidence, diff, commands, failures, and repository guidance. Load `writing-for-agents` before proposing instruction changes.

Classify each finding:

- navigation or missing context pointer;
- deterministic check, test, lint, or CI gap;
- reusable skill behavior;
- repository instruction or coding-standard judgment;
- tool access or observability gap;
- one-off event requiring no process change.

Rank findings by repeated cost and severity. For each, cite the evidence, name the smallest owner artifact, explain the expected behavior change, and identify maintenance cost or risk.

Prefer automated checks for mechanical failures and scoped documentation for judgment. Do not accumulate rules for hypothetical problems. Present proposals only; update skills, instructions, CI, or tools after the applicable approval.
