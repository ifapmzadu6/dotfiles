# dotfiles

Small, repeatable Vim, Zsh, Readline, and Git configuration for macOS and Ubuntu.

## Install

1. Install prerequisites (if needed)
    - Linux (Ubuntu):
        - `sudo apt install git vim`
    - macOS:
        - `git` and `vim` are usually pre-installed.

2. Install dotfiles
    ```bash
    git clone https://github.com/ifapmzadu6/dotfiles.git ~/.dotfiles && ~/.dotfiles/install.sh
    ```

## Update

To update your dotfiles, simply run the installation script:

```bash
~/.dotfiles/install.sh
```

The installer only performs a fast-forward Git update. If the repository has
local changes, it leaves them untouched and skips the update.

Existing `~/.vimrc` and `~/.inputrc` files are preserved with a timestamped
`.backup.YYYYMMDDHHMMSS` suffix before the symlinks are created. Correct links
are left unchanged on subsequent runs. Vim plugins are recreated from the
declared list on every installation. All plugins are downloaded into a temporary
directory before replacing the working set. If a download fails, the existing
plugins are retained; if the replacement fails, the previous set is restored.
If restoration fails or the destination has been recreated, the backup is kept
and its location is reported. The two directory renames are not a single atomic
exchange: after a power loss or forced termination, a retained
`start.install.*/previous` may need to be moved back manually. Avoid concurrent
installer runs or other writes to the plugin directory during replacement.

Run the offline installer regression tests with `bash tests/vim_plugins_test.sh`.
