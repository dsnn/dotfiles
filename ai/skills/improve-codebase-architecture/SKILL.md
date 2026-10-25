---
name: improve-codebase-architecture
description: Survey a codebase for focused architecture improvements and work through one candidate at a time. Invoke explicitly for an evidence-based architecture review, not routine cleanup.
---

# Improve Codebase Architecture

Load `codebase-design` and inspect repository instructions, decisions, tests, recent change hotspots, and the user-named scope. If no scope is given, use change history to find areas that repeatedly cost effort.

Look for duplicated policy, leaking interfaces, behavior that cannot be tested through its real entry point, changes that repeatedly span unrelated files, unclear ownership, and pass-through layers that add no leverage.

Return a terminal-readable shortlist. For each candidate include evidence, current and proposed seam, expected leverage and locality, risks, migration shape, verification, and a clear “leave it alone” alternative.

Then load `grilling` and discuss only the candidate the user selects. Produce a scoped proposal before edits. Do not generate an HTML report, open a browser, or refactor automatically.
