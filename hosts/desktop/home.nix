{ pkgs, ... }: {

  imports = [
    ../../modules/home/git.nix
    ../../modules/home/neovim
    ../../modules/home/starship.nix
    ../../modules/home/tmux.nix
    ../../modules/home/zsh.nix
    ../../modules/home/dircolors
    ../../modules/home/xresources.nix
    ../../modules/home/polybar
    ../../modules/home/i3.nix
    ../../modules/home/rofi.nix
    ../../modules/home/fzf.nix
    ../../modules/home/xdg.nix
    ../../modules/home/lazygit.nix
  ];

  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.dircolors.enable = true;
  programs.keychain.enable = true;
  programs.firefox.enable = true;

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
  };
  home.stateVersion = "23.11";
  home.username = "dsn";
  home.homeDirectory = "/home/dsn";

  # create symlinks to local shares
  # home.file."private".source = config.lib.file.mkOutOfStoreSymlink /mnt/private;
  # home.file."share".source = config.lib.file.mkOutOfStoreSymlink /mnt/share;
  # home.file."share2".source = config.lib.file.mkOutOfStoreSymlink /mnt/share2;

  home.packages = with pkgs; [ feh sstp ];
}
