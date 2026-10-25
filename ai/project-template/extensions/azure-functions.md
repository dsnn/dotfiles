## Azure Functions profile

- Identify the Functions runtime, hosting model, trigger and binding contracts, local settings strategy, and deployment target before editing.
- Keep secrets and environment-specific values out of tracked `local.settings.json`, examples, logs, and documentation.
- Separate local emulator or host verification from live Azure operations. Creating resources, publishing, changing app settings, or invoking production functions requires explicit approval.
- Verify trigger payloads, retries, idempotency, timeouts, poison-message behavior, and observability where they are relevant to the change.
