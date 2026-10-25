#!/usr/bin/env bash
set -euo pipefail

test_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
repo_dir="$(cd "$test_dir/../.." && pwd -P)"
tool="$repo_dir/scripts/ai-project"
tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-ai-project-test.XXXXXX")"
trap 'rm -rf "$tmp_dir"' EXIT

fail() {
  printf 'test failure: %s\n' "$*" >&2
  exit 1
}

mode_of() {
  stat -f '%Lp' "$1" 2>/dev/null || stat -c '%a' "$1"
}

expect_preview_failure() {
  local project="$1" expected="$2"
  if "$tool" preview --project "$project" >"$project/output" 2>&1; then
    fail "preview unexpectedly accepted $project"
  fi
  rg -q "$expected" "$project/output" || fail "unexpected failure for $project"
}

new_project="$tmp_dir/new"
mkdir -p "$new_project"
"$tool" apply --project "$new_project" --profile azure-functions --yes >/dev/null
[[ "$(mode_of "$new_project/AGENTS.md")" == 644 ]] || fail "new AGENTS.md mode is not 0644"
rg -q '^## \.NET / C# profile$' "$new_project/AGENTS.md" || fail "Azure Functions did not include .NET"
rg -q '^## Azure Functions profile$' "$new_project/AGENTS.md" || fail "Azure Functions profile missing"
before_hash="$(shasum -a 256 "$new_project/AGENTS.md" | awk '{print $1}')"
"$tool" apply --project "$new_project" --yes >/dev/null
after_hash="$(shasum -a 256 "$new_project/AGENTS.md" | awk '{print $1}')"
[[ "$before_hash" == "$after_hash" ]] || fail "idempotent update changed AGENTS.md"

existing_project="$tmp_dir/existing"
mkdir -p "$existing_project"
printf 'owner prefix\n' >"$existing_project/AGENTS.md"
chmod 0600 "$existing_project/AGENTS.md"
"$tool" apply --project "$existing_project" --yes >/dev/null
[[ "$(mode_of "$existing_project/AGENTS.md")" == 600 ]] || fail "existing mode was not preserved"
rg -q '^owner prefix$' "$existing_project/AGENTS.md" || fail "existing owner content was lost"

owned_project="$tmp_dir/owned"
mkdir -p "$owned_project"
"$tool" apply --project "$owned_project" --yes >/dev/null
end_line="$(rg -n '^<!-- dotfiles-ai:end -->$' "$owned_project/AGENTS.md" | cut -d: -f1)"
head -n "$end_line" "$owned_project/AGENTS.md" >"$owned_project/candidate"
printf '\nOWNER-SUFFIX-NO-NEWLINE' >>"$owned_project/candidate"
mv "$owned_project/candidate" "$owned_project/AGENTS.md"
"$tool" apply --project "$owned_project" --profile dotnet --yes >/dev/null
suffix='OWNER-SUFFIX-NO-NEWLINE'
[[ "$(tail -c "${#suffix}" "$owned_project/AGENTS.md")" == "$suffix" ]] || fail "owner suffix bytes changed"
[[ "$(tail -c 1 "$owned_project/AGENTS.md" | od -An -t x1 | tr -d '[:space:]')" != 0a ]] || fail "owner suffix gained a newline"

custom_project="$tmp_dir/custom"
mkdir -p "$custom_project"
"$tool" apply --project "$custom_project" --yes >/dev/null
sed -i.bak 's/Prefer small, focused, reversible changes/Prefer tiny changes/' "$custom_project/AGENTS.md"
expect_preview_failure "$custom_project" 'managed block was customized'

for case_name in orphan-end orphan-start duplicate reversed malformed; do
  project="$tmp_dir/$case_name"
  mkdir -p "$project"
  case "$case_name" in
    orphan-end)
      printf 'owner\n<!-- dotfiles-ai:end -->\n' >"$project/AGENTS.md"
      ;;
    orphan-start)
      printf '<!-- dotfiles-ai:start profiles=none checksum=%064d -->\nowner\n' 0 >"$project/AGENTS.md"
      ;;
    duplicate)
      printf '<!-- dotfiles-ai:end -->\n<!-- dotfiles-ai:end -->\n' >"$project/AGENTS.md"
      ;;
    reversed)
      printf '<!-- dotfiles-ai:end -->\n<!-- dotfiles-ai:start profiles=none checksum=%064d -->\n' 0 >"$project/AGENTS.md"
      ;;
    malformed)
      printf '<!-- dotfiles-ai:start broken -->\n<!-- dotfiles-ai:end -->\n' >"$project/AGENTS.md"
      ;;
  esac
  expect_preview_failure "$project" 'managed markers'
done

symlink_project="$tmp_dir/symlink"
mkdir -p "$symlink_project"
printf 'source remains\n' >"$symlink_project/source"
ln -s source "$symlink_project/AGENTS.md"
expect_preview_failure "$symlink_project" 'symlinked AGENTS.md'
[[ "$(cat "$symlink_project/source")" == 'source remains' ]] || fail "symlink target changed"

directory_project="$tmp_dir/directory"
mkdir -p "$directory_project/AGENTS.md"
expect_preview_failure "$directory_project" 'not a regular file'

mention_project="$tmp_dir/mention"
mkdir -p "$mention_project"
printf 'Document the phrase dotfiles-ai:start without creating a marker.\n' >"$mention_project/AGENTS.md"
"$tool" apply --project "$mention_project" --yes >/dev/null
rg -q '^Document the phrase dotfiles-ai:start without creating a marker\.$' "$mention_project/AGENTS.md" || fail "plain marker text was not preserved"

printf '✓ ai-project behavior tests passed\n'
