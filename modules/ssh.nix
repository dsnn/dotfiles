{ config, pkgs, ... }: {
  services.openssh = {
    enable = true;
    forwardX11 = false;
    permitRootLogin = "no";
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };
}
