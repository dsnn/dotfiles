locals {
  ipv4 = "192.0.2.1"
}

module "deploy" {
  source                 = "github.com/nix-community/nixos-anywhere//terraform/all-in-one"
  # with flakes
  nixos_system_attr      = ".#nixosConfigurations.mymachine.config.system.build.toplevel"
  nixos_partitioner_attr = ".#nixosConfigurations.mymachine.config.system.build.diskoScript"
  # without flakes
  # file can use (pkgs.nixos []) function from nixpkgs
  #file                   = "${path.module}/../.."
  #nixos_system_attr      = "config.system.build.toplevel"
  #nixos_partitioner_attr = "config.system.build.diskoScript"

  target_host            = local.ipv4
  # when instance id changes, it will trigger a reinstall
  instance_id            = local.ipv4
  # useful if something goes wrong
  # debug_logging          = true
  # script is below
  extra_files_script     = "${path.module}/decrypt-ssh-secrets.sh"

  disk_encryption_key_scripts = [{
    path   = "/tmp/secret.key"
    # script is below
    script = "${path.module}/decrypt-zfs-key.sh"
  }]
}
