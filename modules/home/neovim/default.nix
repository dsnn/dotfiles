{ lib, config, ... }:
with lib;
let cfg = config.dotfiles.neovim;
in {
  options.dotfiles.neovim = {
    enable = mkEnableOption "Enable neovim";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    programs.zsh.initExtra = ''
      function run_nvim() {
        BUFFER="nvim && clear"
        zle accept-line
      }
      zle -N run_nvim
      bindkey "^n" run_nvim
    '';

    home.file."/Users/dsn/.config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/home/neovim/nvim";
  };
}
