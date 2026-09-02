# dotfiles

Personal macOS dotfiles managed with [`just`](https://github.com/casey/just) and
Homebrew. The repository can be cloned anywhere; the recipes resolve its path
automatically and respect `XDG_CONFIG_HOME`.

## Quick start

Prerequisites: Git and [Homebrew](https://brew.sh/).

```sh
git clone git@github.com:dsnn/dotfiles.git ~/dotfiles
cd ~/dotfiles

brew bundle install
just bootstrap
just check
```

`brew bundle install` installs the command-line tools from `Brewfile`.
`just bootstrap` creates the managed symlinks and any required directories.
It is safe to run repeatedly.

The bootstrap refuses to overwrite an existing unique file. Move such a file
aside, compare it with the repository version, and run the recipe again.
Identical files are adopted automatically.

## Managed configuration

- Shell: Zsh, Starship and Readline
- Terminal tools: tmux, bat, lsd, bottom and htop
- Development: Git, lazygit and SSH
- Editors: Neovim and IdeaVim for JetBrains Rider

Run a single recipe when only one configuration needs to be linked:

```sh
just zsh
just tmux
just nvim
```

Use `just --list` to see all recipes available on the current platform.

## Validation

```sh
just check
brew bundle check --verbose
```

`just check` validates the Justfile, Zsh, SSH, Git, IdeaVim, tmux, Neovim,
Readline, Starship, bat and htop configuration. The Homebrew command separately
reports missing or outdated packages from `Brewfile`.

## Local and private configuration

Secrets and machine-specific SSH hosts do not belong in this repository.
Place private SSH snippets in:

```text
~/.ssh/private/*
```

They are included automatically by `ssh/config`. The bootstrap creates the
directory with mode `700`, while individual private keys should normally use
mode `600`.

The Git configuration conditionally includes:

```text
~/projects/work/.gitconfig-work
```

Use that file for a work-specific Git identity or settings that should remain
outside this repository.

## Platform notes

macOS with Homebrew is the primary and fully tested setup. Additional Arch
Linux and desktop configuration is retained in the repository, but it is not
part of the default macOS bootstrap.
