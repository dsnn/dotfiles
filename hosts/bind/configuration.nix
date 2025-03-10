{
  modulesPath,
  lib,
  ...
}:
let
  hosts = {
    dev = {
      ip = "192.168.2.10";
      domain = "dev.home.dsnn.io";
    };
    docker = {
      ip = "192.168.2.110";
      domain = "docker.home.dsnn.io";
    };
  };

  zoneHosts = lib.concatMapStrings (
    { name, value }:
    ''
      ${name}         A             ${value.ip}
    ''
  ) (lib.attrsets.attrsToList hosts);

  # maps to environment.etc (e.g. /etc/bind/home.dsnn.io)
  envAttrs = {
    "bind/home.dsnn.io" = {
      user = "named";
      group = "named";
      mode = "644";
      text = ''
        $TTL 86400  ; 1 day
        $ORIGIN home.dsnn.io.

        @             IN      SOA   ns1.home.dsnn.io home.dsnn.io (
                        2001062618  ; serial
                        3600        ; refresh (1 hour)
                        3600        ; retry (1 hour)
                        2419200     ; expire (4 weeks)
                        3600        ; minimum (1 hour)
                        )
        @             IN      NS    ns1.home.dsnn.io.

        ns1           IN      A     192.168.2.101

        $ORIGIN home.dsnn.io.
        $TTL 86400  ; 1 day

        $ORIGIN home.dsnn.io.
        $TTL 300    ; 5 minutes
        *             A             192.168.2.101
        ${zoneHosts}
      '';
    };
  };

  zones = [
    {
      name = "home.dsnn.io";
      master = true;
      file = "/etc/bind/home.dsnn.io";
      masters = [ "192.168.2.1" ];
      slaves = [ ];
    }
  ];
  forwarders = [
    "1.1.1.1"
    "1.0.0.1"
  ];
  cacheNetworks = [
    # self
    "127.0.0.1"
    # docker
    "172.17.0.0/16"
    "172.18.0.0/16"
    "172.19.0.0/16"
    "172.20.0.0/16"
    "172.21.0.0/16"
    "172.22.0.0/16"
    "172.23.0.0/16"
    "172.24.0.0/16"
    # services
    "192.168.0.0/16"
  ];
in
{
  imports = [ (modulesPath + "/virtualisation/proxmox-lxc.nix") ];

  dsn = {
    i18n.enable = true;
    nix.enable = true;
    openssh.enable = true;
    prometheus.enable = true;
    security.enable = true;
    shells.enable = true;
    sops.enable = true;
    systemPackages.enable = true;
    user.enable = true;
  };

  programs.zsh.enable = true;

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

  system.stateVersion = "24.11";
}
