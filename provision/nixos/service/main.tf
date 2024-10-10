locals {
  ipv4 = "192.0.2.1"
}

module "proxmox" {
  source              = "./proxmox"
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  vmid                = var.vmid
  name                = var.name
  clone               = var.image
  cores               = var.cores
  memory              = var.memory
}

module "deploy" {
  source                 = "github.com/nix-community/nixos-anywhere//terraform/all-in-one"
  nixos_system_attr      = ".#nixosConfigurations.service.config.system.build.toplevel"
  nixos_partitioner_attr = ".#nixosConfigurations.service.config.system.build.diskoScript"

  target_host = local.ipv4
  instance_id = local.ipv4
}
