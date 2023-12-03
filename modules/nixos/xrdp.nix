{ config, pkgs, ... }: {

  # enable rdp server
  services.xrdp.enable = true;
  services.xrdp.port = 3389;
  services.xrdp.openFirewall = true;
}
