{ config, pkgs, ... }: {

  # enable ssh daemon
  services.openssh.enable = true;

  # disable X11 connections to be forwarded
  # services.openssh.forwardX11 = false;

  # disable root login 
  # services.openssh.permitRootLogin = "no";

  # disable password auth
  # services.openssh.passwordAuthentication = false;
}
