{ modulesPath, myvars, ... }:
let
  inherit (myvars.networking.bindOptions)
    zones
    forwarders
    cacheNetworks
    envAttrs
    ;
in
{
  imports = [ (modulesPath + "/virtualisation/proxmox-lxc.nix") ];

  dsn = {
    # common.enable = true;
    openssh.enable = true;
    user.enable = true;
    sops.enable = true;
    prometheus.enable = true;
  };

  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };

  environment.etc = envAttrs;

  services = {
    bind = {
      enable = true;
      ipv4Only = true;
      extraOptions = ''
        dnssec-validation auto;
      '';
      inherit zones forwarders cacheNetworks;
    };
  };
}
