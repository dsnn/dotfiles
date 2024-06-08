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

When upgrading macOS your /etc/zshrc might reset.
Result: commands or configurations stop working, NIX_PATH is empty etc.
Fix: Add this to the bottom of /etc/zshrc.

```zsh
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

```

## Home-manager

If home manager crashes on 'Could not find suitable profile directory':
Manually create this folder:

```zsh
mkdir -p ~/.local/state/nix/profiles
```

## node

If node isn't available check that host configuration has nix-ld enabled.

```nix

  ...
  nixosConfigurations.host = nixpkgs.lib.nixosSystem {
    modules = [
      ./<host>/configuration.nix
      nix-ld.nixosModules.nix-ld
    ];
  ...

  programs.nix-ld.dev.enable = true;
```

## TODO

- [catppuccin base16](https://github.com/catppuccin/base16)
- [flake checker GitHub action](https://determinate.systems/posts/flake-checker)
- [tmux-continuum issue 118](https://github.com/tmux-plugins/tmux-continuum/issues/118)
- [jellyfin hw acc](https://nixos.wiki/wiki/Jellyfin)
- [impermanence](https://nixos.wiki/wiki/Impermanence)
- [flame](https://github.com/pawelmalak/flame)
- [docker registry ui](https://github.com/Joxit/docker-registry-ui)

## Links

- [bottom](https://github.com/ClementTsang/bottom)
- [Deleting old generations](https://github.com/LnL7/nix-darwin/wiki/Deleting-old-generations)
- [Upgrading macOS](https://github.com/LnL7/nix-darwin/wiki/Upgrading-macOS)
- [tmux tilish](https://github.com/jabirali/tmux-tilish)
- [tmuxp examples](https://tmuxp.git-pull.com/configuration/examples.html)
- [catppuccin](https://github.com/catppuccin/catppuccin)
- [bat-extras](https://github.com/eth-p/bat-extras/tree/master)
- [nix-community srvos](https://github.com/nix-community/srvos)
- [nix-community infra](https://github.com/nix-community/infra)
