{ config, pkgs, lib, ... }: {

  imports = [
    ../../modules/home/git
    ../../modules/home/neovim
    ../../modules/home/starship
    ../../modules/home/tmux
    ../../modules/home/zsh
    ../../modules/home/ssh
    ../../modules/home/dircolors
    ../../modules/home/xresources
    ../../modules/home/i3
    ../../modules/home/rofi
  ];

  # imports = [
  #   ../../modules/home/fzf.nix
  #   ../../modules/home/tmux.nix
  #   ../../modules/home/xdg.nix
  #   ../../modules/home/packages.nix
  #   ../../modules/home/kitty.nix
  #   ../../modules/home/lazygit.nix
  #   ../../modules/home/xresources.nix
  #   ../../modules/home/dunst.nix
  #   ../../modules/home/picom.nix
  # ];

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

  # enable network manager applet
  # services.network-manager-applet.enable = true;

  # create symlinks to local shares
  # home.file."private".source = config.lib.file.mkOutOfStoreSymlink /mnt/private;
  # home.file."share".source = config.lib.file.mkOutOfStoreSymlink /mnt/share;
  # home.file."share2".source = config.lib.file.mkOutOfStoreSymlink /mnt/share2;

  home.packages = with pkgs; [
  #  discord
     feh
  #  freerdp
     google-chrome
  #  remmina
     slack
     spotify
     sstp
  #  wireguard
     xfce.thunar
     xfce.tumbler # thunar thunbnails
     xfce.xfconf # thunar persist settings
     lxappearance # thunar & i3 (icons & cursor)
     nordzy-icon-theme # thunar
  #  nomacs
     libnotify # dunst
     eww
  #  gsimplecal # polybar
  #  polybarFull
  ];

}
