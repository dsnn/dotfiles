# dotfiles

Dotfiles to manage everything from nixos configurations to deployment.
See [documentation](https://www.dsnn.io/dotfiles/) for more info.

## TODO

## Automate nixos deployment

A nixos cloud-init proxmox vm template with custom ip, disk type, partition table and configuration. A terraform script to clone template and create vms.

### Current state

- Generate VMA with nixos-generate via `nix build .#cloud`.
- scp upload generated file manually to proxmox `/var/lib/vz/dump/`
- Restore backup from Proxmox. Correct values prefilled from VMA.

### Problem:

- no control over partitions in VMA? (proxmox-image)
  - virtio0-config?
- this is possible to fix with nixos-anywhere but feels ugly.
- generate .raw-disk and
  - use this instead before converting vm to template?
  - point to custom .raw-disk: `virtio0 = "local:901/base-901-disk-0";` ?
