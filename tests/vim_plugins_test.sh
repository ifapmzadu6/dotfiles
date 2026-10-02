#!/usr/bin/env bash
set -euo pipefail

REPO_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
TEST_ROOT=$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-plugins-test.XXXXXX")
cleanup_test() {
    local result=$?
    if [ "$result" -ne 0 ] && [ -f "$TEST_ROOT/output.log" ]; then
        cat "$TEST_ROOT/output.log" >&2
    fi
    rm -rf -- "$TEST_ROOT"
    return "$result"
}
trap cleanup_test EXIT

# Export fixture commands to the child Bash. No network or user config is used.
git() {
    [ "$1" = clone ] && [ "$2" = --depth ] && [ "$3" = 1 ] || return 90
    local plugin_name
    plugin_name=$(basename "$4" .git)
    if [ -n "$DOTFILES_FIXTURE_EXPECTED_FILE" ]; then
        [ -f "$DOTFILES_FIXTURE_EXPECTED_FILE" ] || return 91
    fi
    mkdir -p "$5"
    printf '%s\n' "$plugin_name" > "$5/plugin.txt"
    if [ "$DOTFILES_FIXTURE_INTERRUPT" = 1 ]; then
        # Signal only the installer subshell that owns this fixture operation.
        bash -c 'kill -TERM "$PPID"'
    fi
    if [ "$plugin_name" = "$DOTFILES_FIXTURE_FAIL_CLONE" ]; then
        echo "fixture: clone failed for $plugin_name" >&2
        return 42
    fi
}

mv() {
    if [ "$2" = "$DOTFILES_FIXTURE_PLUGINS_DIR" ] && [ "$DOTFILES_FIXTURE_FAIL_BACKUP" = 1 ]; then
        return 43
    fi
    if [[ "$2" == */plugins ]] && [ "$DOTFILES_FIXTURE_FAIL_PUBLISH" = 1 ]; then
        return 44
    fi
    if [[ "$2" == */previous ]] && [ "$DOTFILES_FIXTURE_FAIL_RESTORE" = 1 ]; then
        return 45
    fi
    command mv "$@"
    if [[ "$2" == */plugins ]] && [ "$DOTFILES_FIXTURE_INTERRUPT_PUBLISH" = 1 ]; then
        bash -c 'kill -TERM "$PPID"'
    fi
}
export -f git mv

new_case() {
    local case_name=$1
    DOTFILES_FIXTURE_PLUGINS_DIR="$TEST_ROOT/$case_name/pack/start"
    DOTFILES_FIXTURE_EXPECTED_FILE=""
    DOTFILES_FIXTURE_FAIL_CLONE=""
    DOTFILES_FIXTURE_FAIL_BACKUP=0
    DOTFILES_FIXTURE_FAIL_PUBLISH=0
    DOTFILES_FIXTURE_FAIL_RESTORE=0
    DOTFILES_FIXTURE_INTERRUPT=0
    DOTFILES_FIXTURE_INTERRUPT_PUBLISH=0
    export DOTFILES_FIXTURE_PLUGINS_DIR DOTFILES_FIXTURE_EXPECTED_FILE DOTFILES_FIXTURE_FAIL_CLONE
    export DOTFILES_FIXTURE_FAIL_BACKUP DOTFILES_FIXTURE_FAIL_PUBLISH DOTFILES_FIXTURE_FAIL_RESTORE
    export DOTFILES_FIXTURE_INTERRUPT DOTFILES_FIXTURE_INTERRUPT_PUBLISH
}

seed_existing() {
    mkdir -p "$DOTFILES_FIXTURE_PLUGINS_DIR/working-plugin"
    printf 'known working plugin\n' > "$DOTFILES_FIXTURE_PLUGINS_DIR/working-plugin/plugin.txt"
    DOTFILES_FIXTURE_EXPECTED_FILE="$DOTFILES_FIXTURE_PLUGINS_DIR/working-plugin/plugin.txt"
    cp -R "$DOTFILES_FIXTURE_PLUGINS_DIR" "${DOTFILES_FIXTURE_PLUGINS_DIR%/*}/expected"
}

run_install() {
    bash -c 'source "$1/lib.sh"; install_vim_plugins "$2" fixture/one.git fixture/two.git fixture/three.git' \
        plugin-fixture "$REPO_DIR" "$DOTFILES_FIXTURE_PLUGINS_DIR" \
        > "$TEST_ROOT/output.log" 2>&1
}

expect_failure() {
    local expected=$1
    local actual
    if run_install; then
        echo "FAIL: expected installer failure" >&2
        exit 1
    else
        actual=$?
    fi
    if [ "$actual" -ne "$expected" ]; then
        echo "FAIL: expected status $expected, got $actual" >&2
        exit 1
    fi
}

assert_preserved() {
    diff -r "${DOTFILES_FIXTURE_PLUGINS_DIR%/*}/expected" "$DOTFILES_FIXTURE_PLUGINS_DIR"
}

assert_no_staging() {
    local leftovers
    leftovers=$(find "${DOTFILES_FIXTURE_PLUGINS_DIR%/*}" -name 'start.install.*' -print)
    [ -z "$leftovers" ]
}

for failed_plugin in one two three; do
    new_case "clone-failure-$failed_plugin"
    seed_existing
    DOTFILES_FIXTURE_FAIL_CLONE="$failed_plugin"
    expect_failure 42
    assert_preserved
    assert_no_staging
    echo "PASS: $failed_plugin clone failure preserves the complete working set"
done

new_case interrupted-download
seed_existing
DOTFILES_FIXTURE_INTERRUPT=1
expect_failure 143
assert_preserved
assert_no_staging
echo "PASS: interrupted download preserves the working set and cleans staging"

new_case fresh-failure
DOTFILES_FIXTURE_FAIL_CLONE=two
expect_failure 42
[ ! -e "$DOTFILES_FIXTURE_PLUGINS_DIR" ]
assert_no_staging
echo "PASS: failed fresh install publishes no partial plugin set"

new_case successful-replacement
seed_existing
run_install
[ ! -e "$DOTFILES_FIXTURE_PLUGINS_DIR/working-plugin" ]
for plugin in one two three; do
    [ "$(cat "$DOTFILES_FIXTURE_PLUGINS_DIR/$plugin/plugin.txt")" = "$plugin" ]
done
assert_no_staging
DOTFILES_FIXTURE_EXPECTED_FILE="$DOTFILES_FIXTURE_PLUGINS_DIR/one/plugin.txt"
run_install
assert_no_staging
echo "PASS: successful replacement and reinstallation publish all declared plugins"

new_case backup-failure
seed_existing
DOTFILES_FIXTURE_FAIL_BACKUP=1
expect_failure 43
assert_preserved
assert_no_staging
echo "PASS: backup move failure retains the working set"

new_case publication-failure
seed_existing
DOTFILES_FIXTURE_FAIL_PUBLISH=1
expect_failure 44
assert_preserved
assert_no_staging
echo "PASS: publication failure restores the working set"

new_case interrupted-publication
seed_existing
DOTFILES_FIXTURE_INTERRUPT_PUBLISH=1
expect_failure 143
for plugin in one two three; do
    [ "$(cat "$DOTFILES_FIXTURE_PLUGINS_DIR/$plugin/plugin.txt")" = "$plugin" ]
done
[ ! -e "$DOTFILES_FIXTURE_PLUGINS_DIR/previous" ]
assert_no_staging
echo "PASS: interruption after publication retains the complete new set"

new_case rollback-failure
seed_existing
DOTFILES_FIXTURE_FAIL_PUBLISH=1
DOTFILES_FIXTURE_FAIL_RESTORE=1
expect_failure 1
preserved_sets=("${DOTFILES_FIXTURE_PLUGINS_DIR}".install.*/previous)
[ "${#preserved_sets[@]}" -eq 1 ]
diff -r "${DOTFILES_FIXTURE_PLUGINS_DIR%/*}/expected" "${preserved_sets[0]}"
grep -F "preserved at ${preserved_sets[0]}" "$TEST_ROOT/output.log" > /dev/null
echo "PASS: failed rollback retains the backup and reports its location"
