# NixOS

## Test configurations

```console
    nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-24.05 \
  -I nixos-config=./configuration.nix
```

## [Remote deploy via nixos-rebuild](https://nixos.wiki/wiki/Nixos-rebuild)

```console
    nixos-rebuild switch --flake .#profile --fast --use-remote-sudo \
  --target-host <user@host> --build-host <user@host> --verbose
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

## [Touch ID for sudo](https://daiderd.com/nix-darwin/manual/index.html#opt-security.pam.enableSudoTouchIdAuth)

Also, macOS resets /etc/pam.d/sudo which enables touch id for sudo.
More info here:

## [Home-manager](https://home-manager-options.extranix.com/)

If home manager crashes on 'Could not find suitable profile directory':
Manually create this folder:

```console
    mkdir -p ~/.local/state/nix/profiles
```

## Node

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
