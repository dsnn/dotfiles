# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ../shared-configuration.nix ];

  networking.hostId = "8d549888";
  networking.hostName = "dsn";

  services.xserver.displayManager.lightdm.enable = true;

  services.xrdp.enable = true;
  services.xrdp.port = 3389;
  services.xrdp.openFirewall = true;
  services.xrdp.defaultWindowManager = "${pkgs.i3-gaps}/bin/i3";

  users.users.dsn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" ];
  };
  users.users.dsn.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF"
  ];
}

