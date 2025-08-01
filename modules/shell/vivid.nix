{
  flake.modules.homeManager.shell = pkgs: {
    home.packages = with pkgs; [ vivid ];

    programs.zsh.initContent = ''
      export LS_COLORS="$(vivid generate catppuccin-mocha)"
    '';
  };
}
