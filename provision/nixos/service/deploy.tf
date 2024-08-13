locals {
  ipv4 = "192.0.2.1"
}

module "deploy" {
  source                 = "github.com/nix-community/nixos-anywhere//terraform/all-in-one"
  nixos_system_attr      = ".#nixosConfigurations.service.config.system.build.toplevel"
  nixos_partitioner_attr = ".#nixosConfigurations.service.config.system.build.diskoScript"

  target_host            = local.ipv4
  instance_id            = local.ipv4
}
