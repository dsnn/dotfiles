#!/usr/bin/env bash
set -euo pipefail

test_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

"$test_dir/test-ai-project.sh"
"$test_dir/test-ai-skills.sh"
"$test_dir/test-validator.sh"

printf '✓ deterministic AI toolkit tests passed\n'
