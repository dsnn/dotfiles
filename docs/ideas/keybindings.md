# Keybindings and command discovery

## Goal

Keep frequent commands direct, related commands discoverable through which-key, and the complete mapping set searchable through fzf-lua.

## Current state

**Verified (2026-10-25):** `mapleader` is comma and `maplocalleader` is Space. Many mappings use a literal Space prefix rather than `<localleader>`.

Which-key is installed and loads successfully. Its health check reports no duplicate or overlapping mappings. It automatically reads `desc` from Neovim mappings; the configuration does not explicitly register group names.

### Core editing mappings

These 39 mappings are defined in `config/keymaps.lua`. None currently has a `desc`, so which-key and `FzfLua keymaps` cannot give all of them a curated description.

| Mode           | Keys                           | Action                                                                                      |
| -------------- | ------------------------------ | ------------------------------------------------------------------------------------------- |
| Visual         | `Alt-j`, `Alt-k`               | Move selected lines down or up.                                                             |
| Normal         | `U`                            | Redo.                                                                                       |
| Normal         | Arrow keys                     | Resize the current split.                                                                   |
| Normal         | `Tab`, `Shift-Tab`             | Select next or previous buffer.                                                             |
| Normal         | `vv`, `ss`                     | Create vertical or horizontal split.                                                        |
| Normal         | `,q`, `,w`                     | Delete the current buffer or close the current window.                                      |
| Normal         | `Space q q`                    | Quit all without saving.                                                                    |
| Normal         | `,.`, `,,`, `Ctrl-s`           | Alternate buffer or save all buffers.                                                       |
| Normal         | `,h`, `,x`, `,m`, `Esc`        | Toggle search highlight, source current Lua file, show messages, or clear search highlight. |
| Visual         | `p`                            | Paste while preserving the original register.                                               |
| Visual         | `<`, `>`                       | Indent and retain the selection.                                                            |
| Visual         | `/`                            | Search inside the visual selection.                                                         |
| Normal         | `Ctrl-h/j/k/l`                 | Initial window navigation; handed to vim-tmux-navigator after lazy loading.                 |
| Normal         | `n`, `N`, `*`, `#`, `g*`, `g#` | Search and center the match.                                                                |
| Normal, Visual | `H`, `L`                       | Move to first nonblank character or end of line.                                            |

### Navigation and discovery

| Keys                  | Action                                                          |
| --------------------- | --------------------------------------------------------------- |
| `,Space`              | Select a buffer with fzf-lua.                                   |
| `Space s a/g/w/W`     | Find files, live grep, or search word/WORD.                     |
| `Space s h/k/l/r/c/q` | Help, keymaps, resume, recent files, colorschemes, or quickfix. |
| `Space s s/S`         | Document or workspace symbols.                                  |
| `Space g b/c/f/s`     | Git branches, buffer commits, files, or status.                 |
| `Ctrl-n`, `,k`        | Toggle Neo-tree or reveal the current file.                     |
| `Space o`             | Open Oil.                                                       |
| `Space t`, `Space c`  | Toggle Trouble diagnostics or quickfix.                         |

All mappings in this section have useful `desc` values and are automatically visible to which-key where their prefixes trigger it. `Space s k` is the existing searchable keymap launcher.

### LSP and diagnostics

| Scope        | Keys                              | Action                                                          | Which-key description           |
| ------------ | --------------------------------- | --------------------------------------------------------------- | ------------------------------- |
| LSP buffer   | `gd`, `gD`, `gi`, `gh`, `gt`      | Definition, references, implementation, hover, type definition. | Missing on the custom mappings. |
| LSP buffer   | `Space r`, `Space .`, `Space f o` | Rename, code action, format.                                    | Missing on the custom mappings. |
| Global       | `Space n`, `Space p`              | Next or previous diagnostic with float.                         | Present.                        |
| C# workspace | `Space d`                         | Collect EasyDotnet workspace diagnostics.                       | Present.                        |

The eight custom buffer-local LSP mappings are created on `LspAttach` and currently share options without `desc`. Neovim also supplies built-in LSP mappings; this document describes the repository's explicit user workflow.

The Conform specification also declares `Space f o`, but the entire plugin specification is disabled. It does not conflict with the active buffer-local LSP formatting mapping.

### .NET, debugging and tests

| Keys                            | Action                                                                           |
| ------------------------------- | -------------------------------------------------------------------------------- |
| `F5`, `F10`, `F11`, `Shift-F11` | Continue, step over, step into, step out.                                        |
| `,d b/B/c/e/r/u/x`              | Breakpoint, conditional breakpoint, continue, evaluate, REPL, DAP UI, terminate. |
| `,d a/A/p`                      | Debug project, attach to process, debug launch profile.                          |
| `,t n/f/l`                      | Run nearest, file, or last test.                                                 |
| `,t N/F/L`                      | Debug nearest, file, or last test.                                               |
| `,t o/s/w/x`                    | Output, summary, runsettings, stop.                                              |

These mappings have descriptions and are automatically discoverable. There are no explicit which-key group names for `,d` or `,t`.

### Treesitter and editing plugins

| Mode                     | Keys                                     | Action                                  |
| ------------------------ | ---------------------------------------- | --------------------------------------- |
| Normal                   | `gnn`                                    | Start Treesitter selection.             |
| Visual                   | `grn`, `grc`, `grm`                      | Grow by node, grow to scope, shrink.    |
| Visual, Operator         | `af`, `if`, `ac`, `ic`, `ab`, `ib`       | Function, class and block text objects. |
| Normal                   | `,s`                                     | Edit snippet files.                     |
| Normal, Visual, Operator | `gc`, `gcc` where applicable             | Mini comment operations.                |
| Normal, Visual           | `sa`, `sd`, `sf`, `sF`, `sh`, `sr`, `sn` | Mini surround operations.               |

Treesitter mappings and the lazy-loaded snippet mapping have descriptions. Mini supplies descriptions for its runtime mappings.

## Which-key coverage

**Verified:** Lazy-loaded mappings for fzf-lua, navigation, .NET, debugging, tests, Trouble, Neo-tree and Oil have descriptions. Treesitter selection/text-object and diagnostic navigation mappings also have descriptions.

**Open:** The following discoverability gaps require separate approval:

- 39 core mappings have no `desc`.
- Eight custom LSP mappings have no `desc`.
- No named groups exist for `,d` (debug/.NET), `,t` (tests), `Space s` (search) or `Space g` (Git).

Dynamic plugin defaults and Neovim built-ins are intentionally not exhaustively catalogued here.

## Proposed approach

**Proposed:** Add meaningful `desc` values at the existing mapping definitions without changing key sequences. Use which-key v3 `wk.add()` only for group labels and metadata; do not recreate or duplicate mappings in which-key.

Prioritize leader and Space-prefixed workflows. Direct editing keys and conventional Vim motions do not all need named which-key entries. Retain `FzfLua keymaps` as the searchable full inventory.

## Decisions

- **Decided:** Direct keys serve frequent actions, which-key serves grouped discovery, and fzf serves searchable discovery.
- **Open:** The metadata-only remediation is Backlog and requires explicit approval.

## Verification criteria

- Run which-key health and confirm no duplicate or overlapping mappings.
- Inspect runtime normal, visual, operator and buffer-local LSP mappings.
- Confirm each approved prefix has a group label and each user-facing mapping has an accurate description.
- Confirm key sequences and behavior remain unchanged.
- Confirm `Space s k` can find the documented mappings by description.

## Research references

- [which-key mapping specification](https://github.com/folke/which-key.nvim#%EF%B8%8F-mappings)
