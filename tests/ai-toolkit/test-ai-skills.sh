#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"
tmp="$(mktemp -d "${TMPDIR:-/tmp}/ai-skills-test.XXXXXX")"
trap 'rm -rf "$tmp"' EXIT

fail() {
  printf 'FAIL: %s\n' "$*" >&2
  exit 1
}

assert_file() {
  [[ -f "$1" ]] || fail "expected file: $1"
}

assert_absent() {
  [[ ! -e "$1" && ! -L "$1" ]] || fail "expected absent path: $1"
}

assert_contains() {
  rg -Fq -- "$2" "$1" || fail "expected '$2' in $1"
}

assert_command_fails() {
  local output="$1"
  shift
  if "$@" >"$output" 2>&1; then
    fail "command unexpectedly succeeded: $*"
  fi
}

toolkit="$tmp/toolkit"
mkdir -p "$toolkit/scripts" "$toolkit/ai"
cp "$repo_dir/scripts/ai-skills" "$toolkit/scripts/ai-skills"
cp "$repo_dir/ai/project-skills.json" "$toolkit/ai/project-skills.json"
cp -R "$repo_dir/ai/skills" "$toolkit/ai/skills"
toolkit="$(cd "$toolkit" && pwd -P)"
mkdir -p "$toolkit/ai/skills/plan-tasks/references"
printf 'remove on update\n' >"$toolkit/ai/skills/plan-tasks/references/obsolete.md"
script="$toolkit/scripts/ai-skills"

# Global installation remains symlink-based and separate from project copies.
codex_home="$tmp/codex"
CODEX_HOME="$codex_home" "$script" install >"$tmp/global-install.out"
[[ -L "$codex_home/skills/plan-tasks" ]] || fail 'global plan-tasks was not installed as a symlink'
global_target="$(readlink "$codex_home/skills/plan-tasks")"
[[ "$global_target" == "$toolkit/ai/skills/plan-tasks" ]] || fail 'global symlink target changed'

project="$tmp/project"
mkdir "$project"
git -C "$project" init -q

# Preview expands required dependencies but never creates destination files.
"$script" copy preview --project "$project" grill-me plan-tasks >"$tmp/copy-preview.out"
assert_contains "$tmp/copy-preview.out" 'grilling (required by grill-me)'
"$script" copy preview --project "$project" wayfinder >"$tmp/optional-preview.out"
assert_contains "$tmp/optional-preview.out" 'OPTIONAL wayfinder -> research (not copied automatically)'
assert_absent "$project/.agents"

# Apply copies one or multiple selections as physical, manifest-tracked directories.
assert_command_fails "$tmp/no-confirm.out" "$script" copy apply --project "$project" grill-me
"$script" copy apply --yes --project "$project" grill-me plan-tasks >"$tmp/copy-apply.out"
for name in grill-me grilling plan-tasks; do
  assert_file "$project/.agents/skills/$name/SKILL.md"
  jq -e --arg name "$name" '.skills[$name] != null' \
    "$project/.agents/skills/.dotfiles-ai.json" >/dev/null || fail "manifest does not track $name"
done
[[ -z "$(find "$project/.agents/skills" -type l -print -quit)" ]] || fail 'project copy contains a symlink'
[[ "$(readlink "$codex_home/skills/plan-tasks")" == "$global_target" ]] || fail 'project copy changed global installation'
if rg -Fq "$toolkit" "$project/.agents/skills"; then
  fail 'project copy contains an absolute toolkit path'
fi

# Unchanged updates are observable and do not rewrite managed content.
before_hash="$(shasum -a 256 "$project/.agents/skills/plan-tasks/SKILL.md" | awk '{print $1}')"
"$script" update apply --yes --project "$project" >"$tmp/unchanged.out"
assert_contains "$tmp/unchanged.out" 'UNCHANGED plan-tasks'
after_hash="$(shasum -a 256 "$project/.agents/skills/plan-tasks/SKILL.md" | awk '{print $1}')"
[[ "$before_hash" == "$after_hash" ]] || fail 'unchanged update rewrote content'

# Updates synchronize additions, modifications, removals, and modes.
printf '\nUpdate fixture.\n' >>"$toolkit/ai/skills/plan-tasks/SKILL.md"
printf '#!/usr/bin/env bash\nprintf test\\n\n' >"$toolkit/ai/skills/plan-tasks/references/new-helper.sh"
chmod 755 "$toolkit/ai/skills/plan-tasks/references/new-helper.sh"
rm "$toolkit/ai/skills/plan-tasks/references/obsolete.md"
"$script" update preview --project "$project" >"$tmp/update-preview.out"
assert_contains "$tmp/update-preview.out" 'MODIFY   SKILL.md'
assert_contains "$tmp/update-preview.out" 'ADD      references/new-helper.sh'
assert_contains "$tmp/update-preview.out" 'REMOVE   references/obsolete.md'
"$script" update apply --yes --project "$project" >"$tmp/update-apply.out"
assert_file "$project/.agents/skills/plan-tasks/references/new-helper.sh"
assert_absent "$project/.agents/skills/plan-tasks/references/obsolete.md"
[[ -x "$project/.agents/skills/plan-tasks/references/new-helper.sh" ]] || fail 'copied file mode was not preserved'

# A conflict in any managed skill blocks the whole operation until that tracked
# skill is named explicitly with --overwrite.
printf '\nlocal drift\n' >>"$project/.agents/skills/plan-tasks/SKILL.md"
printf '\nsource change\n' >>"$toolkit/ai/skills/grilling/SKILL.md"
grilling_before="$(shasum -a 256 "$project/.agents/skills/grilling/SKILL.md" | awk '{print $1}')"
assert_command_fails "$tmp/drift.out" "$script" update apply --yes --project "$project"
assert_contains "$tmp/drift.out" 'local content differs from the managed baseline'
grilling_after="$(shasum -a 256 "$project/.agents/skills/grilling/SKILL.md" | awk '{print $1}')"
[[ "$grilling_before" == "$grilling_after" ]] || fail 'blocked update partially changed another skill'
"$script" update apply --yes --project "$project" --overwrite plan-tasks >"$tmp/overwrite.out"
assert_contains "$tmp/overwrite.out" 'OVERWRITE plan-tasks'
if rg -Fq 'local drift' "$project/.agents/skills/plan-tasks/SKILL.md"; then
  fail 'approved overwrite did not restore authoritative source'
fi

# Unrelated project skills survive managed updates.
mkdir -p "$project/.agents/skills/project-owned"
printf 'owned by project\n' >"$project/.agents/skills/project-owned/keep.txt"
"$script" update apply --yes --project "$project" >"$tmp/preserve.out"
assert_contains "$project/.agents/skills/project-owned/keep.txt" 'owned by project'

# --overwrite cannot adopt or overwrite an unmanaged skill, even when requested.
collision_project="$tmp/collision-project"
mkdir "$collision_project"
git -C "$collision_project" init -q
"$script" copy apply --yes --project "$collision_project" grill-me >"$tmp/collision-seed.out"
mkdir -p "$collision_project/.agents/skills/plan-tasks"
printf 'unmanaged\n' >"$collision_project/.agents/skills/plan-tasks/keep.txt"
assert_command_fails "$tmp/unmanaged-overwrite.out" "$script" update apply --yes \
  --project "$collision_project" --overwrite plan-tasks
assert_contains "$tmp/unmanaged-overwrite.out" '--overwrite can only name a skill already tracked'
assert_contains "$collision_project/.agents/skills/plan-tasks/keep.txt" 'unmanaged'

# A first-copy collision blocks every requested skill and preserves user content.
partial_project="$tmp/partial-project"
mkdir -p "$partial_project/.agents/skills/plan-tasks"
git -C "$partial_project" init -q
printf 'unmanaged\n' >"$partial_project/.agents/skills/plan-tasks/keep.txt"
assert_command_fails "$tmp/copy-collision.out" "$script" copy apply --yes \
  --project "$partial_project" grill-me plan-tasks
assert_absent "$partial_project/.agents/skills/grill-me"
assert_contains "$partial_project/.agents/skills/plan-tasks/keep.txt" 'unmanaged'

# Missing source content is reported without deleting the managed destination.
mv "$toolkit/ai/skills/grill-me" "$tmp/missing-grill-me"
assert_command_fails "$tmp/missing.out" "$script" update apply --yes --project "$project"
assert_contains "$tmp/missing.out" 'managed source skill is missing'
assert_file "$project/.agents/skills/grill-me/SKILL.md"
mv "$tmp/missing-grill-me" "$toolkit/ai/skills/grill-me"

# Dotfiles-only skills, path escapes, malformed manifests, and symlinked roots stop safely.
assert_command_fails "$tmp/excluded.out" "$script" copy preview --project "$project" setup-project
assert_contains "$tmp/excluded.out" 'not project-copyable'
assert_command_fails "$tmp/escape.out" "$script" copy preview --project "$project" ../plan-tasks
assert_contains "$tmp/escape.out" 'unsafe skill name'

malformed_project="$tmp/malformed-project"
mkdir -p "$malformed_project/.agents/skills"
git -C "$malformed_project" init -q
printf '{bad json\n' >"$malformed_project/.agents/skills/.dotfiles-ai.json"
assert_command_fails "$tmp/malformed.out" "$script" update preview --project "$malformed_project"
assert_contains "$tmp/malformed.out" 'malformed project skill manifest'

symlink_project="$tmp/symlink-project"
mkdir "$symlink_project"
git -C "$symlink_project" init -q
ln -s "$tmp" "$symlink_project/.agents"
assert_command_fails "$tmp/symlink.out" "$script" copy preview --project "$symlink_project" plan-tasks
assert_contains "$tmp/symlink.out" 'project .agents path is a symlink'

printf '✓ ai-skills project copy and update behavior\n'
