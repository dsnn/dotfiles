# Decisions and open questions

This file records durable choices and the unresolved questions that affect implementation. A proposal is not a decision until explicitly approved.

## Decided

| Decision                                                                           | Rationale                                                                                             | Related document                                           |
| ---------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| Keep the public dotfiles generic and separate from work-specific configuration.    | Prevents confidential information and organizational assumptions from entering the public repository. | [Private work configuration](ideas/private-work-config.md) |
| Use Neovim primarily for code editing.                                             | Keeps the editor focused and maintainable instead of recreating a full IDE.                           | [Neovim UI](ideas/neovim-ui.md)                            |
| Use tmux and sesh for sessions and workspaces.                                     | Separates workspace lifecycle from editor configuration.                                              | [tmux workflow](ideas/tmux-workflow.md)                    |
| Prefer specialized CLI/TUI tools when appropriate.                                 | Keeps SQL, Azure and HTTP workflows composable and independently replaceable.                         | [roadmap](roadmap.md)                                      |
| Keep fzf-lua as the preferred Neovim picker unless a concrete limitation is found. | It already covers files, text, symbols, Git objects, keymaps and quickfix.                            | [Neovim UI](ideas/neovim-ui.md)                            |
| Keep Rider available as a complementary tool.                                      | Rider remains useful for workflows where terminal tooling is less capable or less efficient.          | [.NET development](ideas/dotnet-development.md)            |
| Do not make Git worktrees the foundation of the session workflow.                  | A worktree-centered workflow was evaluated previously and intentionally rejected.                     | [tmux workflow](ideas/tmux-workflow.md)                    |
| Require explicit approval before functional environment changes.                   | Makes changes focused, reviewable and reversible.                                                     | [`AGENTS.md`](../AGENTS.md)                                |

## Open decisions

Resolve these in order where practical.

1. **Neovim UI strategy:** use native capabilities first, or adopt a narrowly scoped UI plugin? Alternatives include native `winborder`, selected Snacks modules, and Noice.
2. **Completion engine:** retain the working `nvim-cmp` stack or approve a measured blink.cmp migration?
3. **Debug UI:** refine `nvim-dap-ui` or replace it with `nvim-dap-view`?
4. **Debug output:** keep application output inside Neovim, run it in an on-demand tmux window and attach, or support both explicitly?
5. **tmux tool windows:** which names and commands should be standardized, and should sesh or tmux bindings own creation?
6. **SQL workflow:** use Dadbod inside Neovim, `sqlcmd` in tmux, a standalone TUI, or a small combination without overlap?
7. **KQL workflow:** where should global queries, environment metadata and cached results live, and what may be shared publicly?
8. **API client:** choose Slumber, Posting, Cielago or another verified alternative.
9. **Service Bus production access:** permit no production access, read-oriented access only, or explicitly guarded write operations?
10. **Private work configuration:** choose an optional private repository or another employer-approved local structure.
11. **Which-key metadata:** approve adding `desc` values and group metadata without changing existing key sequences.

Each decision should update this file, the relevant idea document and the roadmap before implementation begins.
