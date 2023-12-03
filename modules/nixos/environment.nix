{ pkgs, ... }:
let is-darwin = pkgs.stdenv.isDarwin;
in {
  environment.shells = with pkgs; [ bash zsh ];
  environment.loginShell = pkgs.zsh;
  environment.systemPackages = with pkgs; [
    _1password
    coreutils
    git
    home-manager
    htop
    neovim
    vim
  ];
  environment.systemPath = if is-darwin then [ "/opt/homebrew/bin" ] else [ ];
  environment.pathsToLink = if is-darwin then [ "/Applications" ] else [ ];
}
