{ config, lib, ... }:
with lib;
let cfg = config.dsn.awesomewm;
in {
  options.dsn.awesomewm = {
    enable = mkEnableOption "Enable awesome window manager";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      layout = "se, us";
      dpi = 120;
      xkbOptions = "eurosign:e,grp:alt_space_toggle";
      displayManager.gdm.enable = true;
      videoDrivers = [ " nvidia " ];
      displayManager.defaultSession = "none+awesome";
    };

    services.xserver.windowManager.awesome = {
      enable = true;
      package = pkgs.awesome-git;
      luaModules = with pkgs.luaPackages; [
        luarocks # package manager for Lua modules
        luadbi-mysql # database abstraction layer
      ];
    };

    # xdg.configFile."awesome".source =
    #   config.lib.file.mkOutOfStoreSymlink ~/dotfiles/modules/home/awesome;
  };
}
