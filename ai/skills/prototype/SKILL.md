---
name: prototype
description: Build a deliberately limited prototype to answer a specific design question. Use when conversation or static research cannot resolve behavior, interaction, feasibility, or an integration assumption.
---

# Prototype

State the question, success signal, scope box, and what will not be productionized. Prefer an isolated temporary directory unless the user approves a repository location.

Choose the cheapest artifact that produces evidence: a focused test, spike, command-line experiment, minimal UI, contract probe, or benchmark. Reuse project tooling when safe, but do not install dependencies or contact live systems without approval.

Keep production concerns proportional: enough error handling and instrumentation to trust the result, not a disguised implementation. Mark shortcuts and assumptions visibly.

Finish with the observed result, reproduction steps, proof limits, files or temporary resources, real-design recommendation, and cleanup options. Do not merge prototype code into production by default.
