{ config, ... }: {

  # TODO: neovim install / handle dependencies
  # [
  #   fd
  #   jq
  #   nawk
  #   neovim
  #   nil
  #   nixd
  #   nixfmt
  #   nixpkgs-fmt
  #   ripgrep
  #   rnix-lsp
  # ];

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

  home.file."${config.home.homeDirectory}/.config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/modules/home/neovim/nvim";
}
