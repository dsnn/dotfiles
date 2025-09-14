{
  flake.modules.nixos.bluetooth =
    { pkgs, ... }:
    {
      services.blueman.enable = true;

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Enable = "Source,Sink,Media,Socket";
            Experimental = true;
          };
        };
      };

      environment.systemPackages = [
        pkgs.bluetui
      ];
    };
}
