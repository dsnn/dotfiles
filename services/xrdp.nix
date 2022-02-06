{ config, pkgs, ... }: {
  services.xrdp = {
    enable = true;
    port = 3389;
    openFirewall = true;
    defaultWindowManager = "xterm";
  };
}
