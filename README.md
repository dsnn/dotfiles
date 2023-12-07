# dotfiles

## Test configurations

```
nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-23.11 -I nixos-config=./configuration.nix
```

## Remote deploy via nixos-rebuild

```nix
nixos-rebuild switch --flake .#profile --fast --use-remote-sudo --target-host <user@host> --build-host <user@host> --verbose
```

# TODO

- https://github.com/catppuccin/base16
- [flake checker github action](https://determinate.systems/posts/flake-checker)
- review https://github.com/ClementTsang/bottom

# Links

- [Deleting old generations](https://github.com/LnL7/nix-darwin/wiki/Deleting-old-generations)
- [Upgrading macOS](https://github.com/LnL7/nix-darwin/wiki/Upgrading-macOS)
- [tmux tilish](https://github.com/jabirali/tmux-tilish)
- [tmuxp examples](https://tmuxp.git-pull.com/configuration/examples.html)
- [catppuccin](https://github.com/catppuccin/catppuccin)
- [bat-extras](https://github.com/eth-p/bat-extras/tree/master)
