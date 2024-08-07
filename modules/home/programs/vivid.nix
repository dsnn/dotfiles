{ pkgs, ... }: {

  home.packages = with pkgs; [ vivid ];

  programs.zsh.initExtra = ''
    export LS_COLORS="$(vivid generate catppuccin-mocha)"
  '';
}
