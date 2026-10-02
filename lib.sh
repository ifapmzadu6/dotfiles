#!/usr/bin/env bash

# Create a symlink without silently discarding an existing configuration file.
link_dotfile() {
    local source_path=$1
    local target_path=$2
    local backup_path
    local suffix=0

    if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
        echo "Already linked: $target_path"
        return
    fi

    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        backup_path="${target_path}.backup.$(date +%Y%m%d%H%M%S)"
        while [ -e "$backup_path" ] || [ -L "$backup_path" ]; do
            suffix=$((suffix + 1))
            backup_path="${target_path}.backup.$(date +%Y%m%d%H%M%S).${suffix}"
        done

        mv -- "$target_path" "$backup_path"
        echo "Backed up: $target_path -> $backup_path"
    fi

    ln -s "$source_path" "$target_path"
    echo "Linked: $target_path -> $source_path"
}

# Keep the working plugin set until every replacement has been downloaded.
install_vim_plugins() (
    set -euo pipefail
    # The subshell isolates these variables and keeps them available to EXIT.
    plugins_dir=$1
    shift

    # Conditional callers can suppress errexit, so check each operation directly.
    mkdir -p "$(dirname -- "$plugins_dir")" || exit "$?"
    staging_dir=$(mktemp -d "${plugins_dir}.install.XXXXXX") || exit "$?"

    cleanup_plugins() {
        local status=$?
        # Recursive deletion could partially destroy the only previous set.
        # Keep it after publication so cleanup errors cannot prevent recovery.
        if [ ! -d "$staging_dir/plugins" ] && { [ -e "$staging_dir/previous" ] || [ -L "$staging_dir/previous" ]; }; then
            echo "Previous Vim plugins preserved at $staging_dir/previous" >&2
            return "$status"
        fi
        # Before publication, restore any previous set that was moved aside.
        if [ -d "$staging_dir/plugins" ] && { [ -e "$staging_dir/previous" ] || [ -L "$staging_dir/previous" ]; }; then
            if [ -e "$plugins_dir" ] || [ -L "$plugins_dir" ] || ! mv -- "$staging_dir/previous" "$plugins_dir"; then
                echo "Error: could not restore Vim plugins; preserved at $staging_dir/previous" >&2
                return 1
            fi
        fi
        rm -rf -- "$staging_dir" || return "$?"
        return "$status"
    }
    trap cleanup_plugins EXIT
    trap 'exit 130' INT
    trap 'exit 143' TERM

    mkdir "$staging_dir/plugins" || exit "$?"
    for plugin_url in "$@"; do
        plugin_name=$(basename "$plugin_url" .git) || exit "$?"
        echo "Installing Vim plugin: $plugin_name" || exit "$?"
        git clone --depth 1 "$plugin_url" "$staging_dir/plugins/$plugin_name" || exit "$?"
    done

    if [ -e "$plugins_dir" ] || [ -L "$plugins_dir" ]; then
        mv -- "$plugins_dir" "$staging_dir/previous" || exit "$?"
    fi
    if [ -e "$plugins_dir" ] || [ -L "$plugins_dir" ]; then
        echo "Error: Vim plugin destination was recreated: $plugins_dir" >&2
        exit 1
    fi
    mv -- "$staging_dir/plugins" "$plugins_dir" || exit "$?"
)
