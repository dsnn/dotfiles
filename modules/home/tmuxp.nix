{ config, lib, ... }:
with lib;
let cfg = config.dsn.tmuxp;
in {

  options.dsn.tmuxp = { enable = mkEnableOption "Enable tmuxp"; };

  config = mkIf cfg.enable {
    programs.tmux.tmuxp.enable = true;

    home.file."${config.home.homeDirectory}/.config/tmuxp".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/home/tmuxp-profiles";

    programs.zsh.initExtra = ''
      export TMUXP_CONFIGDIR=$HOME/.config/tmuxp
    '';
  };
}
