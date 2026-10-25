---
name: validate-dotfiles
description: Validate this dotfiles repository, managed symlinks, and AI toolkit without changing active configuration. Use after dotfiles edits or when installation integrity is in question.
---

# Validate Dotfiles

Run from the dotfiles repository. Start with `git status --short` and inspect relevant diffs so failures can be attributed correctly.

Run, in order:

1. `just ai-check` for skill, metadata, template, and script integrity;
2. `just check` for repository configuration syntax;
3. `just ai-skills-status` to report installed, missing, and conflicting global skills;
4. `brew bundle check --verbose` only when Homebrew availability or package state matters.

These checks are read-only apart from tool caches and temporary files. Do not run bootstrap, relink, install, upgrade, or cleanup recipes as validation.

Report each command and observed result. Separate repository defects, missing optional tools, installation drift, and unrelated pre-existing changes. Never print secrets or private configuration contents.
