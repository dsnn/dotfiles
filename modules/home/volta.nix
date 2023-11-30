{ pkgs, lib, config, ... }:
with lib;
let cfg = config.dotfiles.volta;
in {
  options.dotfiles.volta = {
    enable = mkEnableOption "Enable volta";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [ volta ];

    programs.zsh.initExtra = ''
      export VOLTA_HOME="$HOME/.config/volta"
      export PATH="$VOLTA_HOME/bin:$PATH"

      PATH="$PATH:$HOME/.node_modules/bin"
      export npm_config_prefix=~/.node_modules
    '';

    programs.zsh.shellAliases = {
      ns = "npm start";
      nd = "npm run dev";
      ni = "npm install";
      nt = "npm test";
      ntu = "npm run test:update-snapshot";
      nrt = "npm run typecheck";
      nrl = "npm run lint";
    };
  };

}
