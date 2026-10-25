---
name: writing-for-agents
description: Write or review instructions intended for AI agents, including skills, AGENTS.md files, plans, and handoffs. Use when agent-facing text must be precise, scoped, and economical.
---

# Writing For Agents

Write for behavior change, not exposition. Put durable repository-wide constraints in `AGENTS.md`, reusable procedures in skills, task-specific requirements in specs or plans, and observed state in handoffs or logs.

Use this hierarchy:

1. outcome and scope;
2. non-obvious constraints and permissions;
3. context pointers to the owning source;
4. procedure only where ordering or risk makes it necessary;
5. observable completion and stop conditions.

Prefer strong, testable language. Separate facts, decisions, proposals, and open questions. Avoid duplicating documentation, narrating model defaults, encoding one incident as a universal rule, or listing tools that may not exist.

Keep discovery metadata concise and discriminating. Move conditional detail into a directly linked reference. A selected skill never overrides higher-priority instructions or grants permission.

Review every sentence: remove it if behavior would be unchanged, replace prose with a deterministic check when practical, and keep confidential context out of public instructions.
