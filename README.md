# dotfiles

## Test configurations

```console
nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-23.11 \
  -I nixos-config=./configuration.nix
```

## Remote deploy via nixos-rebuild

```console
nixos-rebuild switch --flake .#profile --fast --use-remote-sudo \
  --target-host <user@host> --build-host <user@host> --verbose
```

## Generate options doc

```console
    nix build .#options-doc
```

## Apple upgrades

### zsh

When upgrading macOS your /etc/zshrc might reset.
Result: commands or configurations stop working, NIX_PATH is empty etc.
Fix: Add this to the bottom of /etc/zshrc.

```zsh
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

```

### Touch ID for sudo

Also, macOS resets /etc/pam.d/sudo which enables touch id for sudo.
More info here: [enableSudoTouchIdAuth](https://daiderd.com/nix-darwin/manual/index.html#opt-security.pam.enableSudoTouchIdAuth)

## Home-manager

If home manager crashes on 'Could not find suitable profile directory':
Manually create this folder:

```console
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

## packer

Create proxmox templates. Run command inside OS folder e.g pkr-ubuntu-noble-1

```console
    packer build -var-file=<(sops -d ~/dotfiles/secrets/secret.tfvars.json) .
```

## terraform

Create and run infrastructure (virtual machines, DNS etc).
Sync state in cloud with terraform login.

```console
    terraform plan -var-file=<(sops -d ~/dotfiles/secrets/secret.tfvars.json)
    terraform apply -var-file=<(sops -d ~/dotfiles/secrets/secret.tfvars.json) -auto-approve
```

## nixos container template

Create a container tarball.

```console
    nix run github:nix-community/nixos-generators -- --format proxmox-lxc
```

Upload to proxmox and run colmena build/apply.

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
- [deleting old generations](https://github.com/LnL7/nix-darwin/wiki/Deleting-old-generations)
- [upgrading macos](https://github.com/LnL7/nix-darwin/wiki/Upgrading-macOS)
- [tmux tilish](https://github.com/jabirali/tmux-tilish)
- [tmuxp examples](https://tmuxp.git-pull.com/configuration/examples.html)
- [catppuccin](https://github.com/catppuccin/catppuccin)
- [bat-extras](https://github.com/eth-p/bat-extras/tree/master)
- [nix-community srvos](https://github.com/nix-community/srvos)
- [nix-community infra](https://github.com/nix-community/infra)
- [nixos proxmox ve](https://nixos.wiki/wiki/Proxmox_Virtual_Environment)
- [nixos anywhere](https://github.com/nix-community/nixos-anywhere)
