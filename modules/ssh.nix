{ config, pkgs, ... }: {
  services.openssh.enable = true;
  # services.openssh.forwardX11 = false;
  # services.openssh.permitRootLogin = "no";
  # services.openssh.passwordAuthentication = false;
  # services.openssh.kbdInteractiveAuthentication = false;
}
