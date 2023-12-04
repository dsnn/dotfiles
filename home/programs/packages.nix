{ pkgs, ... }: {

  home.packages = with pkgs;
    [
      (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" ]; })
      # htop
      # nawk
      # unzip
      # vim
      # xclip
      # jq
      # nixfmt
      # nodePackages.npm
      # nodejs
      # ripgrep
      # fd
      # _1password
    ];
}
