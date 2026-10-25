# SQL Server workflow

## Goal

Provide secure, global SQL Server access and reusable queries independently of the current project.

## Current state

**Verified (2026-10-25):**

- The Go implementation of `sqlcmd` is declared in the Brewfile and installed locally.
- No Neovim database plugin, global connection registry or query library is configured.
- The shell can load machine-private environment values outside the repository.
- Rider remains the current full-featured database interface.

Dadbod supports SQL Server through `sqlcmd`. Dadbod UI supports global saved connections, query files, schema navigation, async execution and optional completion on macOS. Go-sqlcmd supports multiple Microsoft Entra authentication methods.

## Requirements

- Select global connections and databases from any project.
- Keep credentials and sensitive connection information out of public dotfiles.
- Support SQL authentication and relevant Microsoft Entra methods.
- Save reusable SQL files globally.
- Provide highlighting, useful completion, query execution and readable results.
- Preserve Rider for advanced schema, grid and database-administration work.

## Proposed approach

**Proposed:** Evaluate Dadbod, Dadbod UI and Dadbod completion as one integrated option, with Go-sqlcmd as the execution backend. Compare it with a plain `sqlcmd` tmux window before installing anything.

Store safe query text separately from credentials. Resolve secrets at runtime through an approved secret manager, Azure identity or private local environment. Do not save passwords or SAS-like values in Dadbod connection files.

## Alternatives

- `sqlcmd` alone has the lowest maintenance cost but no schema browser or editor integration.
- A standalone SQL TUI may provide better result navigation but must demonstrate SQL Server and Entra support before adoption.
- Rider provides the richest experience at the highest resource and context-switching cost.

## Open questions

- Should SQL run inside the main Neovim instance, a separate Neovim instance or a standalone tmux window?
- Which authentication methods are required in practice?
- Where may global query files and non-secret connection metadata be stored?
- Is sortable tabular output mandatory, and which tool should own it?

## Verification criteria

- Connect using every required authentication method without placing a secret in Git.
- Select a server and database from an unrelated project directory.
- Execute a file and a visual selection and inspect errors and tabular output.
- Confirm schema completion and saved-query discovery.
- Compare the resulting workflow with the Rider tasks it is intended to replace.

## Research references

- [Dadbod](https://github.com/tpope/vim-dadbod)
- [Dadbod UI](https://github.com/kristijanhusak/vim-dadbod-ui)
- [Go-sqlcmd authentication](https://github.com/microsoft/go-sqlcmd#azure-active-directory-authentication)
