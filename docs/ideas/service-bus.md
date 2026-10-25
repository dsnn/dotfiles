# Azure Service Bus workflow

## Goal

Inspect and troubleshoot Azure Service Bus from the terminal while preventing accidental production changes.

## Current state

**Verified (2026-10-25):**

- Azure CLI is installed, but no Service Bus data-plane TUI is configured.
- Azure CLI can list and manage namespaces, queues, topics and subscriptions, but its core Service Bus commands do not provide the desired interactive message browser.
- `service-bus-explorer-tui` documents queues, topics, subscriptions, message metadata, dead-letter queues, send/resend, multiple connections, Vim keys and Microsoft Entra default credentials.
- The tool also exposes create, delete, purge and bulk resend operations.
- Its documented peek implementation uses peek-lock followed by abandon because of REST limitations. This can increment `DeliveryCount`; it is not equivalent to Azure Service Bus's native non-destructive Peek API.

## Requirements

- Browse namespaces and entities across multiple environments.
- Inspect active and dead-letter messages and their metadata.
- Send or republish messages only when explicitly intended.
- Prefer Microsoft Entra ID and least-privilege roles over saved SAS secrets.
- Make environment and production risk unmistakable.
- Distinguish native read-only observations from receive, abandon, complete, delete, purge and resend behavior.

## Proposed approach

**Proposed:** Pilot `service-bus-explorer-tui` only in development or test with Entra authentication and narrowly scoped permissions. Verify every operation against disposable messages and monitor `DeliveryCount` before considering broader use.

Do not store SAS connection strings in dotfiles. Keep production disconnected until RBAC, tool behavior, visual labeling and confirmation requirements are explicitly approved. Retain the Azure Portal Service Bus Explorer as the official fallback for native peek and occasional operations.

## Open questions

- May terminal tooling connect to production at all?
- If yes, which exact production operations are allowed?
- Can a sufficiently safe role be created when even receiver permissions may enable destructive receive behavior?
- Is the DeliveryCount side effect acceptable for development and test troubleshooting?
- Which environments need saved non-secret connection metadata?

## Verification criteria

- Authenticate with a test identity and list queues, topics and subscriptions.
- Inspect message bodies and metadata in active and dead-letter paths.
- Measure DeliveryCount before and after the tool's message inspection.
- Send, edit and republish only disposable test messages.
- Confirm that delete, purge and bulk operations require deliberate confirmation.
- Confirm no connection string or message content is written to the public repository.

## Research references

- [Service Bus Explorer TUI](https://github.com/CosX/service-bus-explorer-tui)
- [Azure Service Bus message browsing](https://learn.microsoft.com/azure/service-bus-messaging/message-browsing)
- [Azure Portal Service Bus Explorer](https://learn.microsoft.com/azure/service-bus-messaging/explorer)
