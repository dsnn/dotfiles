{ pkgs, ... }:
let is-darwin = pkgs.stdenv.isDarwin;
in {
  environment.shells = with pkgs; [ bash zsh ];
  environment.loginShell = pkgs.zsh;
  environment.systemPackages = [
    # _1password
    # fd
    # jq
    # nawk
    # nixfmt
    # nodePackages.npm
    # nodejs
    # ripgrep
    # unzip
    # xclip
    # (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" ]; })
    coreutils
    home-manager
    htop
    vim
    neovim
    git
  ];
  environment.systemPath = if is-darwin then [ "/opt/homebrew/bin" ] else [ ];
  environment.pathsToLink = if is-darwin then [ "/Applications" ] else [ ];
}
