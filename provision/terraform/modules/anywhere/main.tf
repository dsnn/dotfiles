module "deploy" {
  source                 = "github.com/nix-community/nixos-anywhere//terraform/all-in-one"
  nixos_system_attr      = ".#nixosConfigurations.template.config.system.build.toplevel"
  nixos_partitioner_attr = ".#nixosConfigurations.template.config.system.build.diskoScript"

  target_host = var.ipv4
  instance_id = var.ipv4

  install_user = var.user
  target_user = var.user
}
