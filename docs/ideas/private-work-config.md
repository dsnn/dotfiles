# Private work configuration

## Goal

Keep the public dotfiles generic while optionally integrating employer-approved private scripts, query libraries and metadata.

## Current state

**Verified (2026-10-25):**

- This repository is public.
- Zsh optionally sources a machine-private environment file outside the repository.
- Git conditionally includes a work-specific config outside the repository.
- SSH configuration optionally includes private snippets outside the repository.
- No private work repository or loader is managed here.

**Open:** Work directories, private repositories, employer policy, customer constraints and credentials were intentionally not inspected.

## Requirements

- Keep public bootstrap functional when no private configuration exists.
- Allow approved private scripts and SQL/KQL/API resources to appear in shared fzf-based discovery.
- Avoid Git submodules and hard repository coupling.
- Keep credentials out of every Git repository unless an explicitly approved encrypted-secret workflow says otherwise.
- Avoid customer, employer and identifying operational information in public examples.

## Proposed approach

**Proposed:** Use an optional, separately cloned private configuration root discovered through a local environment variable or a conventional untracked path. Public loaders must check for its presence and fail silently when absent. Define only a small documented interface, such as optional command directories and query-library roots.

A private Git repository is suitable only for material that organizational policy permits in that repository. Credentials should remain in an approved secret manager. Public documentation should use synthetic names and paths.

## Alternatives

- Unversioned machine-local files have minimal coupling but weaker history and portability.
- An employer-managed private repository can provide review and policy controls.
- Git submodules are rejected as unnecessary coupling for optional personal configuration.

## Open questions

- Does employer policy permit a private configuration repository?
- Which resource types may be versioned, and at what sensitivity classification?
- What optional paths or environment variables should form the public/private interface?
- Should private search results be merged into public fzf launchers or exposed separately?

## Verification criteria

- Bootstrap and all public commands work when private configuration is absent.
- Approved private resources appear when the optional root is present.
- No private path, hostname, organization name, query content or credential appears in the public diff.
- Removing the optional loader restores the current behavior without migration.
