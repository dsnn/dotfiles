{ config, pkgs, ... }: {

  # enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "se";
  services.xserver.dpi = 120;
  services.xserver.xkbOptions = "eurosign:e";

  # enable gdm 
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = false;

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

}
