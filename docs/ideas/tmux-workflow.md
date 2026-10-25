# tmux and sesh workflow

## Goal

Use project-oriented tmux sessions with separate, on-demand tool windows and minimal permanent panes.

## Current state

**Verified (2026-10-25):**

- tmux uses `C-a`, one-based windows and panes, mouse support, vi copy mode and Catppuccin Mocha.
- vim-tmux-navigator shares `C-h/j/k/l` navigation between Neovim and tmux.
- `prefix+s` opens a sesh/fzf session picker; `prefix+L` returns to the last sesh session.
- Lazygit and gh-dash are available as tmux popups.
- New windows and splits inherit the current pane directory.
- `detach-on-destroy off` supports switching cleanly when a session closes.
- Sesh and zoxide are installed, but no managed `sesh.toml` or declarative session layout exists.
- The searchable shell/tmux help view exposes described tmux bindings.

## Requirements

- Keep Neovim as the primary window in a project session.
- Open Git, SQL, KQL, API, Service Bus and runtime tools only when needed.
- Prefer separate windows over permanent pane layouts.
- Allow temporary Neovim debug panels while long-running output remains available elsewhere.
- Reuse current-directory behavior and consistent navigation.
- Do not make Git worktrees foundational.

## Proposed approach

**Proposed:** Start new project sessions with only Neovim. Add idempotent commands that focus an existing named window or create it in the session's project directory. Decide whether tmux bindings or sesh window definitions should own those commands; do not implement both.

Keep Lazygit and gh-dash as popups unless a full window solves a demonstrated limitation. Use a separate operations session for environment-global SQL, KQL or Service Bus work when project ownership is ambiguous.

## Open questions

- Which window names and default commands should be standardized?
- Should a tool window close automatically when the tool exits?
- Should global operational tools live in the project session or a separate session?
- Is a searchable window launcher preferable to several direct bindings?

## Decisions

- **Decided:** tmux and sesh own workspace management; tools start on demand; worktrees are not foundational.
- **Open:** window definitions, ownership and lifecycle.

## Verification criteria

- Create and reconnect to sessions from the sesh picker.
- Open each approved tool window from multiple project paths without duplicates.
- Confirm every new window starts in the correct directory.
- Navigate between Neovim splits and tmux panes without key conflicts.
- Run a debug target or Functions host in a runtime window and attach from Neovim.

## Research references

- [Sesh](https://github.com/joshmedeski/sesh)
