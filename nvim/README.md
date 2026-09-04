# Neovim

The C#/.NET setup deliberately keeps Git, EF Core, Azure, Functions, and package
management in the terminal. Neovim owns editing, Roslyn navigation and code
actions, tests, and debugging.

## .NET prerequisites

- Compatible project SDKs and `dotnet` on `PATH`. The current Roslyn server
  requires an SDK 10 host. If the main installation lacks it, the config uses
  an existing `~/.dotnet` SDK 10 for Roslyn only.
- The EasyDotnet global tool: `dotnet tool install -g EasyDotnet`.
- When SDK 10 exists only in `~/.dotnet`, install Roslyn with
  `DOTNET_ROOT="$HOME/.dotnet" PATH="$HOME/.dotnet:$PATH" dotnet-easydotnet roslyn install`.
- For Razor markup completion, `vscode-html-language-server` on `PATH`. The
  existing Mason `html-lsp` package provides it inside Neovim.

`roslyn.nvim` runs Microsoft's current language server; `easy-dotnet.nvim`
provides its bundled `netcoredbg` plus project, test, launch-profile, attach,
and workspace-diagnostics workflows. Run `:checkhealth easy-dotnet` if the
backend or debugger fails to start.

## C# workflows

The leader is comma. LSP mappings use a literal Space prefix.

| Keys | Action |
| --- | --- |
| `Space s a` / `Space s g` | Find file / live grep |
| `Space s s` / `Space s S` | Document / workspace symbols |
| `gd` / `gD` / `gi` | Definition / references / implementation |
| `Space r` | Rename symbol |
| `Space .` | Code actions; use on a visual selection for Extract Method |
| `Space d` | Collect workspace diagnostics |
| `, t n` / `, t f` / `, t l` | Run nearest / file / last test |
| `, t N` / `, t F` / `, t L` | Debug nearest / file / last test |
| `, t s` / `, t o` / `, t x` | Test summary / output / stop |
| `, t w` | Select a project `.runsettings` file |
| `, d a` / `, d p` | Debug a project / launch profile |
| `, d A` | Attach to a running .NET process, including `func start` |
| `, d b` / `, d B` | Toggle breakpoint / set conditional breakpoint |
| `F5` / `F10` / `F11` / `Shift-F11` | Continue / over / into / out |
| `, d u` / `, d r` / `, d e` | Debug UI / REPL / evaluate expression |
| `, d x` | End the debug session |

`neotest-dotnet` supplies repository-independent MSTest discovery, execution,
`.runsettings`, and test-host attach debugging. EasyDotnet owns application
debugging and its bundled debugger, while `roslyn.nvim` is the sole C# LSP
client; EasyDotnet's overlapping LSP and test-runner UI stay disabled.
