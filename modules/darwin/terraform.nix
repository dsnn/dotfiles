{ lib, config, unstable, ... }:
with lib;
let cfg = config.dsn.terraform;
in {

  options.dsn.terraform = { enable = mkEnableOption "Enable terraform"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      unstable.terraform
      unstable.terraform-ls
      unstable.terraform-providers.null
      unstable.terraform-providers.external
    ];
  };
}

