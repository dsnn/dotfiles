## Agent safety and workflow

- Read the applicable `AGENTS.md` files, repository documentation, current Git state, and relevant diffs before editing.
- Treat skill selection as workflow guidance only; it never grants permission for file, Git, system, network, or external-service mutations.
- Prefer small, focused, reversible changes. Preserve unrelated work and existing project conventions.
- Explain consequential changes, risks, verification, and rollback before crossing an approval gate defined by this repository.
- Never expose secrets, private endpoints, customer data, proprietary code, or sensitive logs.
- Do not install dependencies, run migrations, change global settings, create commits, push, publish, deploy, or delete work unless the request and repository rules authorize it.
- Validate changes with the project's documented commands and report observed results. Never claim checks that were not run.

## Project conventions

- Discover commands from the repository's task runner, package manifest, CI configuration, and contributor documentation instead of guessing.
- Keep specifications, decisions, tasks, and glossaries in existing locations. Create optional documentation only when the work needs it and the user approves it.
- Use the configured issue tracker when one is documented. Otherwise keep planning local and ask before creating a new tracking convention.
- Put project-specific commands and conventions in an owner-maintained section outside this managed block.
