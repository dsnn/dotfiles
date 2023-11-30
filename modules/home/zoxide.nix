{ lib, config, ... }:
with lib;
let cfg = config.dotfiles.zoxide;
in {
  options.dotfiles.zoxide = {
    enable = mkEnableOption "Enable zoxide";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.zoxide.enable = true;
    programs.zoxide.enableZshIntegration = true;
  };
}
