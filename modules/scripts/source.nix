{ config, lib, ... }:
with lib;
let
  binPath = "${config.home.homeDirectory}/.local/bin";
  scriptsPath = "${config.home.homeDirectory}/dotfiles/modules/scripts";
  cfg = config.dsn.scripts;
in {

  options.dsn.scripts = { enable = mkEnableOption "Enable custom scripts"; };

  config = mkIf cfg.enable {

    home.file."${binPath}".source =
      config.lib.file.mkOutOfStoreSymlink "${scriptsPath}";

    programs.zsh.initExtra = ''
      if [ -d "$HOME/.local/bin" ]; then
        export PATH="${binPath}:$PATH"
      fi
    '';
  };
}
