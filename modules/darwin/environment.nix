{ pkgs, ... }: {
  environment.shells = with pkgs; [ bash zsh ];
  environment.loginShell = pkgs.zsh;
  environment.systemPackages = with pkgs; [
    # _1password
    coreutils
    git
    home-manager
    htop
    neovim
    vim
  ];
  environment.systemPath = [ "/opt/homebrew/bin" ];
  environment.pathsToLink = [ "/Applications" ];
}
