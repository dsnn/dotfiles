#!/usr/bin/env bash
set -euo pipefail

test_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
repo_dir="$(cd "$test_dir/../.." && pwd -P)"
tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-ai-validator-test.XXXXXX")"
trap 'rm -rf "$tmp_dir"' EXIT

fail() {
  printf 'test failure: %s\n' "$*" >&2
  exit 1
}

copy_fixture() {
  local destination="$1"
  mkdir -p "$destination/scripts"
  cp -R "$repo_dir/ai" "$destination/ai"
  cp "$repo_dir/scripts/ai-project" "$repo_dir/scripts/ai-skills" "$repo_dir/scripts/validate-ai-toolkit" "$destination/scripts/"
}

"$repo_dir/scripts/validate-ai-toolkit" >/dev/null
if rg -q 'expected 32|count.*32|32.*count' "$repo_dir/scripts/validate-ai-toolkit"; then
  fail "validator still contains an exact skill-count assertion"
fi

extra_fixture="$tmp_dir/extra"
copy_fixture "$extra_fixture"
cp -R "$extra_fixture/ai/skills/research" "$extra_fixture/ai/skills/extra-skill"
sed -i.bak 's/^name: research$/name: extra-skill/' "$extra_fixture/ai/skills/extra-skill/SKILL.md"
"$extra_fixture/scripts/validate-ai-toolkit" >/dev/null || fail "validator rejected an additional valid skill"

missing_fixture="$tmp_dir/missing"
copy_fixture "$missing_fixture"
rm -rf "$missing_fixture/ai/skills/to-spec"
if "$missing_fixture/scripts/validate-ai-toolkit" >"$missing_fixture/output" 2>&1; then
  fail "validator accepted a missing required skill"
fi
rg -q 'required skill is missing: to-spec' "$missing_fixture/output" || fail "missing-skill error was unclear"

policy_fixture="$tmp_dir/policy"
copy_fixture "$policy_fixture"
sed -i.bak 's/allow_implicit_invocation: false/allow_implicit_invocation: true/' "$policy_fixture/ai/skills/implement-spec/agents/openai.yaml"
if "$policy_fixture/scripts/validate-ai-toolkit" >"$policy_fixture/output" 2>&1; then
  fail "validator accepted implicit implement-spec invocation"
fi
rg -q 'implement-spec must require explicit invocation' "$policy_fixture/output" || fail "policy error was unclear"

printf '✓ AI toolkit validator behavior tests passed\n'
