{

  flake.modules.homeManager.i3 =
    { pkgs, ... }:
    {
      xsession.windowManager.i3 = {
        enable = true;
        config = {
          modifier = "Mod4";
        };
      };
    };

  flake.modules.nixos.i3 =
    { pkgs, ... }:
    {
      services.xserver = {
        enable = true;
        windowManager.i3.enable = true;
      };

      services.displayManager.defaultSession = "none+i3";
    };
}
