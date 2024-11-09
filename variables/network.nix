{ inputs }:
let
  lib = inputs.nixpkgs.lib;
in
rec {

  ip = {
    mainGateway = "192.168.1.1"; # main router
    defaultGateway = "192.168.1.1";
    loopback = "127.0.0.1";
    allInterfaces = "0.0.0.0";
  };

  fail2ban = {
    ignoreIP = [
      "10.0.0.0/24"
      "192.168.0.0/24"
    ];
    maxretry = 5;
  };

  nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  hostsAddr = {
    # srv-nixos-01 = {
    #   name = "";
    #   ip = "192.168.2.111";
    #   modules = [ ../hosts/srv-nixos-01 ];
    #   tags = [ "srv-nixos-01" ];
    # };
    bind = {
      name = "bind";
      ip = "192.168.2.101";
      modules = [ ../hosts/bind ];
      tags = [ "bind" ];
    };
    cache = {
      name = "cache";
      ip = "192.168.2.102";
      modules = [ ../hosts/cache ];
      tags = [ "cache" ];
    };
    monit = {
      name = "monit";
      ip = "192.168.2.103";
      modules = [ ../hosts/monit ];
      tags = [ "monit" ];
    };

    # srv-k3s-01 = {
    #   name = "srv-k3s-01";
    #   ip = "192.168.2.121";
    #   modules = [ ../hosts/k3s/master.nix ];
    #   tags = [ "k3s" ];
    # };
    # k3sagent01 = {
    #   name = "srv-k3s-agent-01";
    #   ip = "192.168.2.122";
    #   modules = [ ../hosts/k3s/agent.nix ];
    #   tags = [ "k3s" ];
    # };
    # k3sagent02 = {
    #   name = "srv-k3s-agent-01";
    #   ip = "192.168.2.123";
    #   modules = [ ../hosts/k3s/agent.nix ];
    #   tags = [ "k3s" ];
    # };
  };

  # hostsInterface = lib.attrsets.mapAttrs (key: val: {
  #   interfaces."${val.iface}" = {
  #     useDHCP = false;
  #     ipv4.addresses = [
  #       {
  #         inherit prefixLength;
  #         address = val.ipv4;
  #       }
  #     ];
  #   };
  # }) hostsAddr;

  bindOptions = {
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

    zones = [
      {
        name = "home.dsnn.io";
        master = true;
        file = "/etc/bind/home.dsnn.io";
        masters = [ "192.168.2.1" ];
        slaves = [ ];
      }
    ];

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
          ${bindOptions.zoneHosts}
        '';
      };
    };

    zoneHosts = lib.concatMapStrings (
      { name, value }:
      ''
        ${name}         A             ${value.ip}
      ''
    ) (lib.attrsets.attrsToList bindOptions.hosts);

    masters = [ "192.168.2.1" ];

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
  };

  ssh = {
    # define the host alias for remote builders
    # this config will be written to /etc/ssh/ssh_config
    # ''
    #   Host server1
    #     HostName 192.168.2.100
    #     Port 22
    #
    #   Host server2
    #     HostName 192.168.2.101
    #     Port 22
    #   ...
    # '';
    extraConfig = lib.attrsets.foldlAttrs (
      acc: host: val:
      acc
      + ''
        Host ${host}
          HostName ${val.ipv4}
          Port 22
      ''
    ) "" hostsAddr;

    # define the host key for remote builders so that nix can verify all the remote builders
    # this config will be written to /etc/ssh/ssh_known_hosts
    knownHosts =
      # Update only the values of the given attribute set.
      #
      #   mapAttrs
      #   (name: value: ("bar-" + value))
      #   { x = "a"; y = "b"; }
      #     => { x = "bar-a"; y = "bar-b"; }
      lib.attrsets.mapAttrs
        (host: value: {
          hostNames = [
            host
            hostsAddr.${host}.ipv4
          ];
          publicKey = value.publicKey;
        })
        {
          server1.publicKey = "";
          server2.publicKey = "";
          server3.publicKey = "";
        };
  };
}
