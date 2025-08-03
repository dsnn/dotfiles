# dotfiles

Dotfiles to manage everything.

---

add gh-dash
https://github.com/dlvhdr/gh-dash
https://github.com/jojojames/fussy
https://github.com/nix-community/nh
https://github.com/jzbor/nix-sweep

# Home manager

## Options

[Home-manager options](https://home-manager-options.extranix.com/)

## Troubleshooting

If home manager crashes on 'Could not find suitable profile directory':
Manually create this folder:

```console
mkdir -p ~/.local/state/nix/profiles
```

## Apple upgrades

When upgrading macOS your /etc/zshrc might reset.
Result: commands or configurations stop working, NIX_PATH is empty etc.
Fix: Add this to the bottom of /etc/zshrc.

```console
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
```

## Touch ID for sudo

[Enable sudo touch id auth](https://daiderd.com/nix-darwin/manual/index.html#opt-security.pam.enableSudoTouchIdAuth)

Also, macOS resets /etc/pam.d/sudo which enables touch id for sudo.
More info here:

## Node not available

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

# Links

- [local nixos cache](https://docs.cachix.org/)
- [terraform sops](https://github.com/carlpett/terraform-provider-sops)
- [catppuccin base16](https://github.com/catppuccin/base16)
- [flake checker GitHub action](https://determinate.systems/posts/flake-checker)
- [tmux-continuum issue 118](https://github.com/tmux-plugins/tmux-continuum/issues/118)
- [jellyfin hw acc](https://nixos.wiki/wiki/Jellyfin)
- [impermanence](https://nixos.wiki/wiki/Impermanence)
- [flame](https://github.com/pawelmalak/flame)
- [docker registry ui](https://github.com/Joxit/docker-registry-ui)

## Links

- [bottom](https://github.com/ClementTsang/bottom)
- [deleting old generations](https://github.com/LnL7/nix-darwin/wiki/Deleting-old-generations)
- [upgrading macos](https://github.com/LnL7/nix-darwin/wiki/Upgrading-macOS)
- [tmux tilish](https://github.com/jabirali/tmux-tilish)
- [tmuxp examples](https://tmuxp.git-pull.com/configuration/examples.html)
- [catppuccin](https://github.com/catppuccin/catppuccin)
- [bat-extras](https://github.com/eth-p/bat-extras/tree/master)
- [nix-community srvos](https://github.com/nix-community/srvos)
- [nix-community infra](https://github.com/nix-community/infra)
- [proxmox template](https://technotim.live/posts/cloud-init-cloud-image/)
