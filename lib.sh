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
