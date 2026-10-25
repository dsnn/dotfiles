# Neovim UI and rendering

## Goal

Create a modern, minimal and consistent interface that remains functional and quiet.

## Current state

**Verified (2026-10-25):**

- Catppuccin Mocha provides the Neovim theme with a transparent background.
- Lualine provides a global status line; there is no bufferline.
- fzf-lua is the main picker. Neo-tree and Oil provide tree and directory-oriented navigation.
- Completion and diagnostic floats explicitly use rounded borders. Lazy's UI also uses rounded borders.
- Diagnostics use signs and underlines while permanent virtual text is disabled.
- Treesitter and Roslyn semantic tokens are available; Catppuccin supplies native LSP and semantic-token highlights by default.
- tmux, fzf, Bat, Lazygit, gh-dash and Starship use Catppuccin Mocha colors.

**Open:** The terminal emulator configuration is not in this repository. Font fallback, italic text, undercurl, glyph alignment and actual color reproduction have not been verified. Hover and signature-help borders are not configured globally.

## Requirements

- Preserve fzf-lua unless a concrete limitation is demonstrated.
- Keep completion, hover, diagnostics, pickers and notifications visually consistent.
- Prefer useful contrast over additional decoration.
- Avoid permanent components that duplicate tmux, fzf-lua or existing navigation.
- Verify semantic-token highlights in representative C# code.

## Proposed approach

**Proposed:** Begin with Neovim's native border and highlight capabilities. Inspect C# captures and semantic tokens before changing colors. Add a UI plugin only for a remaining, named limitation.

Snacks should be evaluated module by module; its picker, explorer and buffer deletion overlap with existing tools. Noice replaces messages, the command line and popup menu through an experimental UI integration and should not be adopted without a concrete need. blink.cmp is a completion-engine migration, not a visual-only improvement.

## Open questions

- Is native-first UI refinement the approved direction?
- Which terminal emulator and font configuration must be validated?
- Is notification history a real requirement, or is `:messages` sufficient?
- Is transparent background desirable in every terminal context?

## Decisions

- **Decided:** fzf-lua remains the preferred picker unless it has a demonstrated limitation.
- **Open:** native-first UI, notification tooling and completion-engine choices.

## Verification criteria

- C#, Lua, JSON, Markdown and diagnostics have readable, distinct highlights.
- Completion, documentation, hover, code actions and diagnostics use consistent borders.
- tmux and Neovim colors remain legible with active and inactive windows.
- Startup time and large-file behavior do not regress materially.

## Research references

- [Catppuccin for Neovim](https://github.com/catppuccin/nvim)
- [Snacks](https://github.com/folke/snacks.nvim)
- [Noice](https://github.com/folke/noice.nvim)
- [blink.cmp](https://github.com/Saghen/blink.cmp)
