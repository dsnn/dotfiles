---
name: which-skill
description: Recommend the smallest appropriate toolkit skill or workflow for a stated goal. Invoke explicitly when the user is unsure where to start or wants to avoid unnecessary process.
---

# Which Skill

Read the current inventory if availability is uncertain. Recommend direct work when no skill adds value.

Route by outcome:

- unclear bounded idea: `grill-me` or `grill-with-docs`;
- external factual uncertainty: `research`;
- huge ambiguous initiative: `wayfinder`;
- settled multi-session work: `to-spec`, then `plan-tasks`;
- one approved task: `implement`;
- approved task graph needing orchestration: `implement-spec`;
- unknown failure: `diagnosing-bugs`;
- review or PR communication: `code-review` or `pr`;
- project/toolkit maintenance: `setup-project`, `improve-skill`, `update-skills`, or `validate-dotfiles`.

Explain why the recommendation fits, why the closest alternative does not, required inputs, likely outputs, and approval implications. Selecting a skill never grants permission or starts it automatically.
