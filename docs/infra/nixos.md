# NixOS

## NixOS Anywhere

[NixOS Anywhere](https://github.com/nix-community/nixos-anywhere)

```console
nix run github:nix-community/nixos-anywhere -- --flake .#template --build-on-remote user@ip
```

## nixos-rebuild

[Remote deploy via nixos-rebuild](https://nixos.wiki/wiki/Nixos-rebuild)

```console
nixos-rebuild switch --flake .#profile --fast --use-remote-sudo \
--target-host <user@host> --build-host <user@host> --verbose
```
