{ config, pkgs, ... }: {

  # networkmanager
  networking.networkmanager.enable = true;

  # dont wait for network iface 
  systemd.services.NetworkManager-wait-online.enable = false;
}
