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
are left unchanged on subsequent runs. Vim plugins are treated as disposable
and recreated from the declared list on every installation.
