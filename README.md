# dotfiles

My dotfiles manage everything from NixOS configurations and automation with Ansible to infrastructure setup using Terraform.

These are mostly for my own use, but if you find them interesting, feel free to explore, tweak, and make them your own.

For more information:

[Documentation](https://www.dsnn.io/dotfiles/)

## TODO

### Automate NixOS VMs

A nixos cloud-init proxmox vm template with custom ip, disk type, partition table and configuration. A terraform script to clone template and create vms.

Current state:

Generate VMA with nixos-generate via `nix build .#cloud`.
scp upload generated file manually to proxmox `/var/lib/vz/dump/`
Restore backup from Proxmox. Correct values prefilled from VMA.

Problem:

- no control over partitions in VMA? (proxmox-image)
  - virtio0-config?
- this is possible to fix with nixos-anywhere but feels ugly.
- generate .raw-disk and
  - use this instead before converting vm to template?
  - point to custom .raw-disk: `virtio0 = "local:901/base-901-disk-0";` ?

Other:

- nixos-anywhere: should handle everything but I dont like this solution.

- nixos-generators

  - proxmox-image: works but lacking config (partitions etc?)
  - <other_format>: is there any better format that handles \* and works with proxmox ? qcow2?

- disko

  - generate .raw-disk: and use in template?
