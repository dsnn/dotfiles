# .NET debugging

## Goal

Provide progressive debugging: code-only editing, focused debug panels, and deeper sessions with supporting tmux windows.

## Current state

**Verified (2026-10-25):**

- `nvim-dap`, `nvim-dap-ui`, EasyDotnet and `neotest-dotnet` are configured.
- EasyDotnet registers its bundled `netcoredbg` adapter and supports project, launch-profile and process-attach selection.
- Mappings exist for standard and conditional breakpoints, continue, step over, step into, step out, terminate, evaluate, REPL and the full DAP UI.
- DAP UI currently opens its default layout automatically on launch or attach and closes it when the session ends.
- Test debugging uses the EasyDotnet adapter through Neotest.
- `nvim-dap-ui` can represent scopes, watches, stack frames, breakpoints, REPL and application console as separate elements or floats.

**Open:** Async stepping, deep object inspection, exception breakpoints, macOS ARM64 adapter behavior, Azure Functions and real process attach were not exercised. EasyDotnet uses an integrated terminal; it does not automatically move application output into tmux.

## Requirements

- Support breakpoints, conditional breakpoints, watches, locals and expression evaluation.
- Navigate the call stack and individual frames.
- Support continue and standard stepping operations.
- Keep REPL and application output conceptually separate.
- Show or hide individual panels without forcing a permanent IDE layout.
- Support local process attach where the adapter permits it.

## Proposed approach

**Proposed:** Retain `nvim-dap-ui` first and add focused access to its existing elements. Do not install `nvim-dap-view` unless the current UI cannot meet a verified requirement.

For long-running output, start `dotnet` or `func start` in an on-demand tmux window and attach from Neovim. Automatically routing DAP's `runInTerminal` request into tmux would require custom integration and should be a separate decision.

For isolated Azure Functions, evaluate `func start --dotnet-isolated-debug` and attach to the reported worker process. Remote, container and deployed-Azure debugging are outside the initial scope.

## Open questions

- Retain `nvim-dap-ui` or evaluate `nvim-dap-view` after focused-panel testing?
- Should the default debug start remain code-only or open a compact panel automatically?
- Which application types and Azure Functions models must attach support cover?
- Are exception breakpoints and run-to-cursor required direct mappings?

## Verification criteria

- Launch and attach to representative applications.
- Exercise standard and conditional breakpoints, async code, watches, locals and nested objects.
- Navigate threads and stack frames and evaluate expressions in the selected frame.
- Separate interactive application input/output from the DAP REPL.
- Debug a nearest test and a launch profile.
- Start an applicable Functions host in tmux and attach without losing host output.

## Research references

- [nvim-dap-ui elements](https://github.com/rcarriga/nvim-dap-ui/blob/master/doc/nvim-dap-ui.txt)
- [EasyDotnet debugging](https://github.com/GustavEikaas/easy-dotnet.nvim/blob/main/docs/debugging.md)
- [NetCoreDbg](https://github.com/Samsung/netcoredbg)
- [Azure Functions Core Tools](https://learn.microsoft.com/azure/azure-functions/functions-run-local)
