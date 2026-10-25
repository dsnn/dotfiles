# .NET development

## Goal

Make Neovim comfortable for professional C#/.NET work while retaining Rider for tasks where it is more effective.

## Current state

**Verified (2026-10-25):**

- `roslyn.nvim` runs Microsoft's Roslyn language server and is the only configured C# LSP client.
- Navigation covers definitions, references, implementations, type definitions, symbols and hover.
- Rename, code actions, LSP formatting and workspace diagnostics are mapped.
- EasyDotnet supplies project, run, launch-profile, debug and attach workflows; its overlapping LSP is disabled.
- Neotest with `neotest-dotnet` supplies test discovery, execution, output and DAP strategies.
- Installed SDKs include supported 8, 9 and 10 lines plus an 11 release candidate. The default observed SDK was the 11 release candidate.
- The global EasyDotnet and Roslyn language-server tools are installed.
- No `global.json`, `.editorconfig`, solution or project file belongs in this dotfiles repository.

**Open:** The observed Roslyn server build was slightly below the minimum documented by the current `roslyn.nvim` revision. The working setup should be tested before any controlled update. Large work solutions, `netstandard2.0`, source generation and solution selection were not tested during this documentation task.

## Requirements

- Respect project `global.json`, target frameworks and `.editorconfig` settings.
- Support IntelliSense, diagnostics, code actions, navigation and common refactorings.
- Use `dotnet` CLI for builds, runs and tests.
- Handle multi-project solutions without loading an unintended target.
- Keep package, EF Core, Azure and Git workflows in appropriate external tools.

## Proposed approach

**Proposed:** Stabilize and verify the current stack before considering replacements. Test SDK resolution both with and without `global.json`, verify Roslyn's selected solution, and use `:Roslyn target` when multiple candidates exist. Enable broad solution search only if a real repository layout requires it.

Formatting should continue through Roslyn unless a project establishes another formatter. The disabled Conform configuration is not part of the active C# workflow.

## Open questions

- Which SDK lines and target frameworks must representative verification cover?
- Do large repositories require Roslyn broad search or explicit target selection?
- Which Rider refactorings are essential enough to pursue in Neovim?
- Should repositories without `global.json` be treated as an error or merely documented?

## Decisions

- **Decided:** Neovim is the primary code editor; Rider remains complementary.
- **Open:** version-update timing and the required refactoring baseline.

## Verification criteria

- Open a representative multi-project solution and confirm the intended target.
- Confirm completion, diagnostics, navigation, references, implementations, rename and code actions.
- Build and test projects targeting the required SDKs, including `netstandard2.0` where applicable.
- Confirm project formatting follows repository policy.
- Measure startup and common navigation on a large solution before and after changes.

## Research references

- [roslyn.nvim](https://github.com/seblyng/roslyn.nvim)
- [EasyDotnet](https://github.com/GustavEikaas/easy-dotnet.nvim)
- [Neotest .NET adapter](https://github.com/Issafalcon/neotest-dotnet)
