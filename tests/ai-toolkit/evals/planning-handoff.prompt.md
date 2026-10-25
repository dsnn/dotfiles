This is a read-only behavioral evaluation. Do not modify files or external state.

Read and follow these workflow instructions:

- `{{REPO}}/ai/skills/to-spec/SKILL.md`
- `{{REPO}}/ai/skills/plan-tasks/SKILL.md`
- `{{REPO}}/ai/skills/implement/SKILL.md`
- `{{REPO}}/ai/skills/handoff/SKILL.md`

Simulate the artifacts these workflows would produce without choosing a tracker or writing files.

Settled context:

- Authorized users need to export active invoices as UTF-8 CSV.
- Reuse the existing `InvoiceQuery` interface.
- Archived invoices are excluded.
- The export remains synchronous; no background job is introduced.
- An authorized user receives a header and the active invoice rows.
- An unauthorized user receives the existing forbidden response.
- With no active invoices, the export contains the header only.
- No implementation or verification has occurred and no mutation is authorized.

Create stable identifiers, tasks covering all requirements, and a handoff preserving the complete identifier relationships. Verification evidence must honestly remain `not_run`. Return only the structured result required by the output schema.
