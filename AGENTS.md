# Repository instructions

This is a public dotfiles repository. Prefer simple, focused, reversible changes that reuse the existing architecture. Read `docs/roadmap.md`, `docs/decisions.md`, and the relevant idea document before proposing work.

## Design principles

- Reuse existing tools and plugins before adding alternatives.
- Avoid duplicate functionality and unnecessary dependencies.
- Keep Neovim, tmux, and shell configuration modular and maintainable.
- Prefer standalone CLI/TUI tools for specialized workflows where appropriate.
- Preserve existing keybindings and workflows unless a change is explicitly approved.
- Do not attempt to recreate an entire IDE inside Neovim.
- Keep public configuration generic and work-specific configuration separate.

## Mandatory change workflow

For changes to configuration, scripts, installations, dependencies, or development-environment behavior:

1. Inspect the relevant configuration, documentation, Git status, and existing diffs.
2. Explain the problem and present a concrete plan with affected files, dependencies, risks, verification, and rollback.
3. Wait for explicit approval. Approval applies only to the proposed scope.
4. Implement only the approved work. Stop for new approval if a significant deviation is required.
5. Verify the result, review the final diff and untracked files, and update relevant documentation.

Do not combine unrelated changes. Preserve all unrelated user work. Never reset, clean, overwrite, or discard it.

## Public repository safety

- Treat every tracked file, example, comment, and commit message as public.
- Never include credentials, tokens, passwords, API keys, sensitive connection strings, internal hosts, private endpoints, customer names, proprietary code, or confidential work information.
- Sanitize paths, commands, logs, and output before documenting them.
- Do not copy data from work projects or private configuration into this repository.
- Keep secrets in an approved secret manager, never in Git. A private repository is not automatically an approved place for employer or customer information.
- If publication safety is uncertain, exclude the information and ask.

## Git and system safety

- Before changes, run `git status` and inspect relevant diffs.
- After changes, review `git status`, the complete diff, and new untracked files; report exactly what changed.
- Never stage, commit, push, publish, or create a pull request without explicit approval.
- Do not install or remove software, change global settings or symlinks, or run destructive commands without approval.
- Be especially careful with shell startup, `PATH`, tmux, and Neovim startup.
- Do not execute unknown scripts merely to inspect them.

## Documentation

- Keep `docs/roadmap.md` as the central overview and `docs/decisions.md` as the decision log.
- Use idea documents for requirements, research, alternatives, and verification criteria.
- Label statements as **Verified**, **Proposed**, **Decided**, or **Open** where their status matters.
- Do not present a proposal as an approved decision. Keep documentation concise and avoid duplication.
