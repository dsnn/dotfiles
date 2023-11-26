{ pkgs, ...}:{

  # https://github.com/nix-community/home-manager/blob/master/modules/programs/lsd.nix

  programs.lsd.enable = true;
  # programs.lsd.enableAliases = true;

  # custom ls aliases
  programs.zsh.shellAliases = {
    l="lsd -l";
    ls="lsd -lA";
    la="lsd -la";
    lt="lsd --tree";
    llt="lsd -l --tree";
  };
}
