{
  flake.modules.nixos.graphics =
    { pkgs, ... }:
    {
      nixpkgs.config.packageOverrides = pkgs: {
        vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
      };

      hardware.graphics = {
        extraPackages = with pkgs; [
          intel-media-driver
          libvdpau-va-gl
          libva
          libva-utils
        ];
      };
    };
}
