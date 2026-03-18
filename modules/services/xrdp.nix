{
  flake.modules.nixos.xrdp =
    { pkgs, ... }:
    {
      services.xrdp = {
        enable = true;
        openFirewall = true;
        defaultWindowManager = "${pkgs.i3}/bin/i3";
      };

      # Disable systemd targets for sleep and hibernation
      systemd.targets = {
        sleep.enable = false;
        suspend.enable = false;
        hibernate.enable = false;
        hybrid-sleep.enable = false;
      };
    };
}
