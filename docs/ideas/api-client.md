# HTTP and OpenAPI client

## Goal

Provide a keyboard-driven terminal client that can discover OpenAPI operations, collect required input and inspect complete HTTP exchanges.

## Current state

**Verified (2026-10-25):**

- HTTPie is installed, but no collection-oriented HTTP TUI is configured.
- Posting, Slumber and Cielago are not installed through this repository.
- Posting imports OpenAPI 3.0/3.1 operations into editable requests. Path parameters become editable entries in a Path tab; import alone does not create a send-time prompt.
- Slumber imports OpenAPI 3.0/3.1 and supports explicit `prompt()` and `select()` template functions at request time.
- Cielago imports Swagger/OpenAPI documents and pre-fills parameters, examples and servers, but its documented workflow does not establish an automatic prompt for every required parameter.

## Requirements

- Support standard HTTP methods, headers, query parameters, bodies and JSON formatting.
- Support bearer tokens and other common authentication without committing secrets.
- Select local, development, test and production environments clearly.
- Save requests and reusable templates.
- Import OpenAPI operations and browse endpoints.
- Prompt for required path or query values before sending where configured.
- Display status, headers and response body with Vim-like navigation where possible.

## Proposed approach

**Proposed:** Pilot Slumber with a sanitized real-world OpenAPI document because it directly supports the required prompt flow. Treat imported output as a generated starting point: add explicit prompt templates where required rather than assuming the importer inferred the desired interaction.

Keep shareable request definitions with the project when appropriate. Keep personal global collections in an approved private location. Load secrets from local environment or an approved secret manager.

## Alternatives

- Posting offers a polished request editor, layered environments and strong import, but uses editable path-parameter fields rather than automatic prompts.
- Cielago is OpenAPI-focused and Vim-oriented but currently has a smaller ecosystem and less evidence for the required prompt behavior.
- HTTPie remains useful for ad hoc and scripted requests.

## Open questions

- Which client should receive a time-boxed pilot?
- Should API collections normally be project-owned, global-private, or both?
- Which authentication flows beyond static bearer tokens are required?
- How should production environments be visually and operationally guarded?

## Verification criteria

- Import a sanitized OpenAPI specification and select `GET /orders/{id}` or an equivalent operation.
- Prompt for the required identifier, build the correct URL and apply the selected environment.
- Send GET, POST, PUT, PATCH and DELETE requests with headers and JSON bodies.
- Load a token without writing it to a tracked file or persisted history unintentionally.
- Inspect status, response headers and formatted body entirely from the terminal.

## Research references

- [Slumber OpenAPI import](https://slumber.lucaspickering.me/user_guide/cli/subcommands.html#slumber-import)
- [Slumber template functions](https://slumber.lucaspickering.me/api/template_functions.html)
- [Posting OpenAPI import](https://posting.sh/guide/importing/)
- [Posting path parameters](https://posting.sh/guide/requests/#path-parameters)
- [Cielago](https://github.com/stevedylandev/cielago)
