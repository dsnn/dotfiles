# Dotfiles roadmap

This is the central overview for the terminal development environment. Detailed requirements and research belong in the linked idea documents.

## Status model

- **Backlog** — researched or requested, but not approved for implementation.
- **Planned** — explicitly approved and ready to implement.
- **In Progress** — actively being implemented. Keep at most one major improvement here.
- **Done** — implemented and verified.

Labels used throughout the documentation:

- **Verified** — confirmed from repository content or a local check dated 2026-10-25.
- **Proposed** — a recommendation that has not been approved.
- **Decided** — explicitly chosen by the repository owner.
- **Open** — requires a decision or further verification.

## Current foundation

| Improvement                | Status | Priority | Summary                                                                                            | Details                                         | Blockers                                           |
| -------------------------- | ------ | -------- | -------------------------------------------------------------------------------------------------- | ----------------------------------------------- | -------------------------------------------------- |
| Terminal foundation        | Done   | —        | Zsh, tmux, sesh, fzf, Git tooling and Catppuccin-based presentation are managed by the repository. | [tmux workflow](ideas/tmux-workflow.md)         | None                                               |
| Neovim editing foundation  | Done   | —        | Lazy-loaded editing, navigation, Treesitter, LSP, completion and UI components are present.        | [Neovim UI](ideas/neovim-ui.md)                 | Visual terminal rendering is not fully verified.   |
| .NET foundation            | Done   | —        | Roslyn, EasyDotnet, Neotest and DAP are configured.                                                | [.NET development](ideas/dotnet-development.md) | Work-project behavior needs targeted verification. |
| Architecture documentation | Done   | —        | Roadmap, decisions, idea documents and Codex instructions capture current context.                 | [decisions](decisions.md)                       | None                                               |
| AI development toolkit      | Done   | —        | Repository-managed Codex skills, project templates, validation and safety workflows are available. | [AI toolkit](ai/README.md)                       | Real-project usage will guide focused refinements. |

## In progress

No major improvement is currently in progress.

## Planned

No improvement has been explicitly approved for implementation.

## Backlog

| Improvement                         | Priority | Summary                                                                         | Details                                                    | Important blockers or decisions                      |
| ----------------------------------- | -------- | ------------------------------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------- |
| Neovim UI refinement                | —        | Improve borders, contrast and rendering without adding visual noise.            | [Neovim UI](ideas/neovim-ui.md)                            | Choose a native-first or plugin-led approach.        |
| Which-key discoverability           | —        | Add descriptions and group metadata to existing mappings without changing keys. | [keybindings](ideas/keybindings.md)                        | **Open:** requires separate approval.                |
| .NET baseline verification          | —        | Validate SDK selection, Roslyn compatibility and large solutions.               | [.NET development](ideas/dotnet-development.md)            | Requires a safe representative work project.         |
| Progressive .NET debugging          | —        | Support minimal, selected-panel and deep-debug workflows.                       | [.NET debugging](ideas/dotnet-debugging.md)                | Choose UI/output behavior and verify adapters.       |
| On-demand tmux tool windows         | —        | Open named Git, SQL, KQL, API and runtime windows only when needed.             | [tmux workflow](ideas/tmux-workflow.md)                    | Define naming and creation behavior.                 |
| Global SQL workflow                 | —        | Provide secure SQL Server connections and reusable queries.                     | [SQL workflow](ideas/sql-workflow.md)                      | Select tools and credential method.                  |
| KQL investigation workflow          | —        | Run reusable queries, cache JSON and explore correlated telemetry.              | [KQL workflow](ideas/kql-workflow.md)                      | Confirm storage, caching and workspace selection.    |
| OpenAPI client                      | —        | Select endpoints, supply parameters and inspect requests in a TUI.              | [API client](ideas/api-client.md)                          | Select Slumber, Posting or another client.           |
| Service Bus tooling                 | —        | Inspect and manage Service Bus with explicit production safeguards.             | [Service Bus](ideas/service-bus.md)                        | Define allowed production operations.                |
| Optional private work configuration | —        | Integrate private scripts and query libraries without coupling the public repo. | [private work configuration](ideas/private-work-config.md) | Employer policy and storage model must be confirmed. |

## Suggested decision order

Resolve one item at a time in the order recorded in [decisions.md](decisions.md). Research or documentation alone does not change a roadmap item to Planned or In Progress.
