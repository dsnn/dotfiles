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
	debug_logging          = true

	# extra_files_script     = "${path.module}/decrypt-ssh-secrets.sh"
}

# deploy and build on remote when using darwin system

# locals {
#   ipv4 = "192.168.2.131"
# }
#
# module "system-build" {
#   source            = "github.com/nix-community/nixos-anywhere//terraform/nix-build"
#   attribute         = ".#nixosConfigurations.template.config.system.build.toplevel"
# }
#
# module "disko" {
#   source         = "github.com/nix-community/nixos-anywhere//terraform/nix-build"
#   attribute      = ".#nixosConfigurations.template.config.system.build.diskoScript"
# }
#
# module "install" {
#   source            = "github.com/nix-community/nixos-anywhere//terraform/install"
#   nixos_system      = module.system-build.result.out
#   nixos_partitioner = module.disko.result.out
#   target_host       = local.ipv4
# 	build_on_remote		= true
# }
#
# module "deploy" {
#   source                 = "github.com/nix-community/nixos-anywhere//terraform/all-in-one"
# 	nixos_system					 = module.system-build.result.out 
#   # nixos_system_attr      = ".#nixosConfigurations.template.config.system.build.toplevel"
#   # nixos_partitioner_attr = ".#nixosConfigurations.template.config.system.build.diskoScript"
#
#   target_host            = local.ipv4
#   instance_id            = local.ipv4 # when instance id changes, it will trigger a reinstall
# }

