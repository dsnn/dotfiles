#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd "$SCRIPT_DIR"
sops --extract '["zfs-key"]' --decrypt "$SCRIPT_DIR/secrets.yaml"
