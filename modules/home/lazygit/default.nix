{ pkgs, ...}:{

  # TODO: https://github.com/catppuccin/lazygit
  # https://github.com/nix-community/home-manager/blob/master/modules/programs/lazygit.nix


  programs.zsh.initExtra = ''
    function run_lazy_git() {
      BUFFER="lazygit && clear"
      zle accept-line
    }
    zle -N run_lazy_git
    bindkey "^g" run_lazy_git
  '';

  programs.lazygit.enable = true;
}
