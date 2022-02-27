{ config, pkgs, ... }: {

  # secrets specifications
  sops.secrets.nmconnection-work-vpn = { };

  # networkmanager
  networking.networkmanager.enable = true;

  # dont wait for network iface 
  systemd.services.NetworkManager-wait-online.enable = false;

  # work vpn profile
  environment.etc."NetworkManager/system-connections/work.nmconnection".source =
    "${config.sops.secrets.nmconnection-work-vpn.path}";
}
