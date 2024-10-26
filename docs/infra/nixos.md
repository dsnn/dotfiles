# NixOS

## Automated deplyment

- Set up a terraform module to provision a virtual machine with cloud init (like regular ubuntu cloud init for instance).

- Use cloud init to specific ssh user, password and ip for easy access.

- Use nixos anywhere terraform module to apply flake with nixosConfiguration pointing to your configuration.nix and disko-config.nix

- Specify static ip as target_host and instance_id.

- Set install_user and target_user to root (?).
  NOTE: Initial tests failed when using another user. Try again with custom user in cloud init and configuration.nix.

- Important! Specify the static ip in your configuration.nix or nixos-anywhere fails after installation and reboot (we get a new IP).

- Sometimes when an installation with nixos-anywhere fails and you run it again it wont work at all. Seems like theres is some problem
  with old terraform state. To fix this, remove the .tfstate-files and try again (I know this is probably not recommended but yeh...).

Proxmox might have trouble showing the shell in the web console (serial0). Try change tty or something.

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
