# NixOS

## Test configurations

```console
nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-24.11 \
-I nixos-config=./configuration.nix
```

## Generate documentation

[Example](https://github.com/NixOS/nixpkgs/blob/master/nixos/doc/manual/default.nix)

```console
nix build .#options-doc
```

## Generate iso

```console
nix build .#nixosConfigurations.iso.config.system.build.isoImage
```

or

```console
just iso
```