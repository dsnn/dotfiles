# dotfiles

## Test configurations

```nix
nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-23.11 \
  -I nixos-config=./configuration.nix
```

## Remote deploy via nixos-rebuild

```nix
nixos-rebuild switch --flake .#profile --fast --use-remote-sudo \
  --target-host <user@host> --build-host <user@host> --verbose
```

## Apple upgrades

When upgrading macOS apple doesn't care about you, so they rewrite your /etc/zshrc.
Result: no commands or configurations are working, NIX_PATH is empty etc.
Fix: Add this to the bottom of /etc/zshrc.

```zsh
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

```

## TODO

- [oil.nvim](https://github.com/stevearc/oil.nvim)
- [catppuccin base16](https://github.com/catppuccin/base16)
- [flake checker github action](https://determinate.systems/posts/flake-checker)
- review [bottom](https://github.com/ClementTsang/bottom)
- [tmux-continuum issue 118](https://github.com/tmux-plugins/tmux-continuum/issues/118)

## Links

- [Deleting old generations](https://github.com/LnL7/nix-darwin/wiki/Deleting-old-generations)
- [Upgrading macOS](https://github.com/LnL7/nix-darwin/wiki/Upgrading-macOS)
- [tmux tilish](https://github.com/jabirali/tmux-tilish)
- [tmuxp examples](https://tmuxp.git-pull.com/configuration/examples.html)
- [catppuccin](https://github.com/catppuccin/catppuccin)
- [bat-extras](https://github.com/eth-p/bat-extras/tree/master)
