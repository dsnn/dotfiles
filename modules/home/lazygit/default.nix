{ pkgs, lib, config, ... }:
with lib;
let cfg = config.dotfiles.lazygit;
in {

  # TODO: https://github.com/catppuccin/lazygit
  # https://github.com/nix-community/home-manager/blob/master/modules/programs/lazygit.nix

  options.dotfiles.lazygit = {
    enable = mkEnableOption "Enable lazygit";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.lazygit.enable = true;

    programs.zsh.initExtra = ''
      function run_lazy_git() {
        BUFFER="lazygit && clear"
        zle accept-line
      }
      zle -N run_lazy_git
      bindkey "^g" run_lazy_git
    '';
  };

}
