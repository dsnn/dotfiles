{ ... }: {

  # TODO: https://github.com/catppuccin/lazygit
  # https://github.com/nix-community/home-manager/blob/master/modules/programs/lazygit.nix

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --color-only --dark --paging=never";
          useConfig = false;
        };
      };
    };
  };

  programs.zsh.initExtra = ''
    function run_lazy_git() {
      BUFFER="lazygit && clear"
      zle accept-line
    }
    zle -N run_lazy_git
    bindkey "^g" run_lazy_git
  '';

}
