{
  flake.modules.nixos.hyprland =
    { pkgs, ... }:
    {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      # set no update news

      # wayland.windowManager.hyprland.plugins = [
      #   # pkgs.hyprlandPlugins.<plugin>
      # ];

      # nix.settings = {
      #   substituters = [ "https://hyprland.cachix.org" ];
      #   trusted-substituters = [ "https://hyprland.cachix.org" ];
      #   trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      # };

      programs.hyprlock.enable = true;

      services.rustdesk-server = {
        enable = true;
        openFirewall = true;
        signal.relayHosts = [ "127.0.0.1" ];
      };

      # services.xserver = {
      #   enable = true;
      #   displayManager.gdm = {
      #     enable = true;
      #     wayland = true;
      #   };
      # };

      services.displayManager.gdm = {
        enable = true;
        wayland = true;
      };

      hardware = {
        nvidia.modesetting.enable = true;

        graphics = {
          enable = true;
          extraPackages = with pkgs; [
            intel-media-driver
            libvdpau-va-gl
            libva
            libva-utils
          ];
        };
      };
    };
}
