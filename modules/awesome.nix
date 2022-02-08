{ pkgs, ... }: {

  xsession = {
    enable = true;
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # package manager for Lua modules
        luadbi-mysql # database abstraction layer
      ];
    };
  };

}
