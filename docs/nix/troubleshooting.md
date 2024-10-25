# Troubleshooting

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
