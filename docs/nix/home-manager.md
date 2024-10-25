# Home manager

## Shell

To change shell when using standalone home manager on a e.g. ubuntu installation, use:

```console
echo ~/.nix-profile/bin/zsh | sudo tee -a /etc/shells
usermod -s ~/.nix-profile/bin/zsh $user
```

## Options

[Home-manager options](https://home-manager-options.extranix.com/)

## Troubleshooting

If home manager crashes on 'Could not find suitable profile directory':
Manually create this folder:

```console
mkdir -p ~/.local/state/nix/profiles
```
