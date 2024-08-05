locals {
  ipv4 = "192.0.2.1"
}

module "system-build" {
  source              = "github.com/nix-community/nixos-anywhere//terraform/nix-build"
  # with flakes
  attribute           = ".#nixosConfigurations.mymachine.config.system.build.toplevel"
  # without flakes
  # file can use (pkgs.nixos []) function from nixpkgs
  #file                = "${path.module}/../.."
  #attribute           = "config.system.build.toplevel"
}

module "deploy" {
  source       = "github.com/nix-community/nixos-anywhere//terraform/nixos-rebuild"
  nixos_system = module.system-build.result.out
  target_host  = local.ipv4
}
