---
name: tdd
description: Develop behavior through a red-green-refactor loop at a stable test seam. Use for features and bug fixes where an automated test can express the required observable behavior.
---

# Tdd

Choose the highest stable seam that proves user- or caller-visible behavior without coupling the test to internals. Prefer existing test infrastructure and conventions.

For each small vertical slice:

1. **Red:** add one focused test and run it. Confirm it fails for the expected reason, not setup noise.
2. **Green:** make the smallest production change that passes the new test.
3. **Refactor:** improve names and structure while all tests remain green.
4. **Verify:** run neighboring tests and relevant static checks.

Good tests are deterministic, behavior-focused, readable, and fail with useful evidence. Mock only real seams such as time, randomness, networks, or external systems; do not mock the unit's own internal decisions.

If no trustworthy automated seam exists, explain the limitation and propose the cheapest seam or reproducible manual check. Do not redesign public interfaces or install a test framework without approval.
