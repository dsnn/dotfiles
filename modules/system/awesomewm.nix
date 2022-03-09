{ config, pkgs, ... }: {

  # enable the X11 windowing system
  services.xserver.enable = true;
  services.xserver.layout = "se, us";
  services.xserver.dpi = 120;
  services.xserver.xkbOptions = "eurosign:e,grp:alt_space_toggle";

  # enable gdm 
  services.xserver.displayManager.gdm.enable = true;

  # video drivers
  services.xserver.videoDrivers = [ " nvidia " ];

  # awesomewm
  services.xserver.displayManager.defaultSession = "none+awesome";
  services.xserver.windowManager.awesome = {
    enable = true;
    package = pkgs.awesome-git;
    luaModules = with pkgs.luaPackages; [
      luarocks # package manager for Lua modules
      luadbi-mysql # database abstraction layer
    ];
  };

  # services.xserver.displayManager.sessionCommands = ''
  #   ${pkgs.xorg.xrdb}/bin/xrdb -merge <${
  #     pkgs.writeText "Xresources" ''
  #       Xft.dpi: 192

  #       ! These might also be useful depending on your monitor and personal preference:
  #       Xft.autohint: 0
  #       Xft.lcdfilter:  lcddefault
  #       Xft.hintstyle:  hintfull
  #       Xft.hinting: 1
  #       Xft.antialias: 1
  #       Xft.rgba: rgb
  #     ''
  #   }
  # '';

}
