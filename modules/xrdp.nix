{
  flake.modules.nixos.xrdp = {
    services.xrdp = {
      enable = true;
      openFirewall = true;
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
