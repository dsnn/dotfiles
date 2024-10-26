locals {
  ipv4 = "192.168.2.111"
}


module "deploy" {
  source                 = "github.com/nix-community/nixos-anywhere//terraform/all-in-one"
  nixos_system_attr      = ".#nixosConfigurations.srv-nixos-01.config.system.build.toplevel"
  nixos_partitioner_attr = ".#nixosConfigurations.srv-nixos-01.config.system.build.diskoScript"

  target_host = local.ipv4
  instance_id = local.ipv4

  install_user = "root"
  target_user = "root"
}
