locals {
  ipv4 = "192.168.2.131"
}

module "deploy" {
  source                 = "github.com/nix-community/nixos-anywhere//terraform/all-in-one"
  # with flakes
  nixos_system_attr      = ".#nixosConfigurations.template.config.system.build.toplevel"
  nixos_partitioner_attr = ".#nixosConfigurations.template.config.system.build.diskoScript"

  target_host            = local.ipv4
  instance_id            = local.ipv4 # when instance id changes, it will trigger a reinstall
  extra_files_script     = "${path.module}/decrypt-ssh-secrets.sh"
}
