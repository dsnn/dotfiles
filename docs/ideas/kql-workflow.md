# KQL and Application Insights workflow

## Goal

Support fast and deep investigation of distributed .NET systems through reusable KQL and terminal-native result exploration.

## Current state

**Verified (2026-10-25):**

- Azure CLI is installed and its Log Analytics extension is present.
- `az monitor log-analytics query` can execute KQL against a workspace and return JSON, table, TSV or YAML output.
- Neovim has no KQL filetype, parser, LSP or query runner configured.
- No global query library, workspace registry or result cache exists in this repository.

**Open:** Azure authentication, subscriptions, workspaces and data access were not inspected. Work telemetry and identifiers must never be copied into this public repository.

## Requirements

- Edit reusable `.kql` files in Neovim.
- Select an environment, subscription and Log Analytics workspace.
- Parameterize domain identifiers and time ranges safely.
- Preserve the original result as JSON and derive table views from it.
- Reopen cached results without repeating a billed or slow query.
- Search results, extract `OperationId`, and follow related traces, requests, dependencies and exceptions.
- Use fzf for selection and VisiData for deeper tabular exploration where useful.

## Proposed approach

**Proposed:** Use Azure CLI as the query backend and keep Neovim responsible only for editing. A small external command layer may select safe environment metadata, substitute explicit parameters, write immutable JSON result files and open fzf or VisiData. This is a CLI workflow, not a Neovim plugin framework.

Separate public example queries from private work queries. Cache keys should account for workspace, query content, parameters and time range; cache behavior must be approved before implementation.

## Open questions

- Where should global private queries, environment metadata and cached results live?
- Which parameters require prompting, and how should unsafe string substitution be prevented?
- What cache lifetime and manual refresh behavior are appropriate?
- Is minimal regex highlighting sufficient, or is a maintained KQL parser required?
- Which portal-only features, including Transaction Search, must remain outside the terminal workflow?

## Decisions

- **Decided:** Azure CLI is the desired query execution backend; fzf remains the preferred selector.
- **Open:** storage, caching, parameter interface and editor highlighting.

## Verification criteria

- Select two sanitized test workspaces without changing global Azure state unexpectedly.
- Run parameterized queries for traces, requests and exceptions and retain original JSON.
- Reopen a cached result without an Azure request.
- Extract an operation identifier and query correlated events across relevant tables.
- Open selected event data in Neovim and the complete table in VisiData.

## Research references

- [`az monitor log-analytics query`](https://learn.microsoft.com/cli/azure/monitor/log-analytics#az-monitor-log-analytics-query)
- [Application Insights telemetry model](https://learn.microsoft.com/azure/azure-monitor/app/data-model-complete)
