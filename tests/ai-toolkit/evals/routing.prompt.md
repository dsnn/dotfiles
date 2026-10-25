This is a read-only behavioral evaluation. Do not modify files or external state.

Read and follow the routing guidance in:

- `{{REPO}}/ai/skills/which-skill/SKILL.md`
- the candidate skill manifests under `{{REPO}}/ai/skills/`

Scenario: A developer reports an intermittent production-like timeout in a local reproduction. The cause is unknown. They ask which workflow should start next. They have not approved a fix, code edits, dependency changes, or external operations.

Select the single smallest appropriate skill. Return only the structured result required by the output schema. Base the result on observable workflow boundaries, not exact wording from a manifest.
