{ config, pkgs, lib, ... }: {

  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  imports = [
    ../../modules/home/git.nix
    ../../modules/home/starship.nix
    ../../modules/home/zsh.nix
    ../../modules/home/fzf.nix
    ../../modules/home/tmux.nix
    ../../modules/home/xdg.nix
    ../../modules/home/rofi.nix
    ../../modules/home/packages.nix
    ../../modules/home/kitty.nix
    ../../modules/home/lazygit.nix
  ];

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.dircolors.enable = true;
  programs.keychain.enable = true;

  # enable network manager applet
  services.network-manager-applet = { enable = true; };

  # create symlinks to local shares
  home.file."private".source = config.lib.file.mkOutOfStoreSymlink /mnt/private;
  home.file."share".source = config.lib.file.mkOutOfStoreSymlink /mnt/share;
  home.file."share2".source = config.lib.file.mkOutOfStoreSymlink /mnt/share2;

  # compositor for xorg
  services.picom.enable = true;
  # services.picom.activeOpacity = "0.9";
  # services.picom.blur = true;
  services.picom.extraOptions = ''
    corner-radius = 0;
    blur-method = "dual_kawase";
    blur-strength = "10";
    xinerama-shadow-crop = true;
  '';
  services.picom.experimentalBackends = true;
  services.picom.shadowExclude = [ "bounding_shaped && !rounded_corners" ];
  services.picom.fade = true;
  services.picom.fadeDelta = 5;
  # services.picom.vsync = true;
  # services.picom.opacityRule = [
  #   "100:class_g   *?= 'Firefox'"
  #   "100:class_g   *?= 'slack'"
  # ];
  services.picom.package = pkgs.picom.overrideAttrs (o: {
    src = pkgs.fetchFromGitHub {
      repo = "picom";
      owner = "ibhagwan";
      rev = "c4107bb6cc17773fdc6c48bb2e475ef957513c7a";
      sha256 = "sha256-1hVFBGo4Ieke2T9PqMur1w4D0bz/L3FAvfujY9Zergw=";
    };
  });

  home.packages = with pkgs; [
    discord
    spotify
    kodi
    google-chrome
    sstp
    teamspeak_client
    remmina
    xfce.thunar
    feh
    wireguard
    freerdp
    slack
  ];
  # eww
}
