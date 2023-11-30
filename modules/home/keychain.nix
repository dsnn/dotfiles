{ lib, config, ... }:
with lib;
let cfg = config.dotfiles.keychain;
in {
  options.dotfiles.keychain = {
    enable = mkEnableOption "Enable keychain";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.keychain.enable = true;
    programs.keychain.enableZshIntegration = true;
    programs.keychain.extraFlags = [ "--quiet" "--quick" ];
    programs.keychain.agents = [ "ssh" ];
    programs.keychain.keys = [ "id_rsa" ];
  };
}
