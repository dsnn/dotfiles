{ lib }:
rec {

  ip = {
    mainGateway = "192.168.1.1"; # main router
    defaultGateway = "192.168.2.1";
    loopback = "127.0.0.1";
    allInterfaces = "0.0.0.0";
    defaultInterfaceName = "eth0";
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
    anywhere = {
      name = "anywhere";
      nixos-modules = [ ../hosts/anywhere/anywhere.nix ];
      system = "x86_64-linux";
    };
    iso = {
      name = "iso";
      generate-modules = [ ../hosts/iso/configuration.nix ];
      format = "iso";
      system = "x86_64-linux";
    };
    raw = {
      name = "raw";
      nixos-modules = [ ../hosts/raw/configuration.nix ];
      system = "x86_64-linux";
    };
    vma = {
      name = "vma";
      generate-modules = [ ../hosts/vma/proxmox-image.nix ];
      format = "proxmox";
      system = "x86_64-linux";
    };
    nixos1 = {
      name = "nixos01";
      hostname = "srv-nixos-01";
      ip = "192.168.2.111";
      nixos-modules = [ ../hosts/nixos1/configuration.nix ];
      home-modules = [ ../modules/home ];
      profiles = [ ../profiles/dsn.nix ];
      tags = [ "srv-nixos-01" ];
      system = "x86_64-linux";
    };
    silver = {
      name = "silver";
      hostname = "silver";
      darwin-modules = [ ../hosts/silver/configuration.nix ];
      home-modules = [ ../modules/home ];
      profiles = [ ../profiles/dsn.nix ];
      system = "aarch64-darwin";
    };
    dev = {
      name = "dev";
      hostname = "dev";
      ip = "192.168.2.10";
      nixos-modules = [ ../hosts/dev/configuration.nix ];
      home-modules = [ ../modules/home ];
      profiles = [ ../profiles/dsn.nix ];
      tags = [ "dev" ];
      system = "x86_64-linux";
    };
    bind = {
      name = "bind";
      hostname = "bind";
      ip = "192.168.2.101";
      nixos-modules = [ ../hosts/bind/configuration.nix ];
      home-modules = [ ../modules/home ];
      profiles = [ ../profiles/dsn.nix ];
      tags = [ "bind" ];
      system = "x86_64-linux";
    };
    cache = {
      name = "cache";
      hostname = "cache";
      ip = "192.168.2.102";
      nixos-modules = [ ../hosts/cache/configuration.nix ];
      home-modules = [ ../modules/home ];
      profiles = [ ../profiles/dsn.nix ];
      tags = [ "cache" ];
      system = "x86_64-linux";
    };
    monit = {
      name = "monit";
      hostname = "monit";
      ip = "192.168.2.103";
      nixos-modules = [ ../hosts/monit/configuration.nix ];
      home-modules = [ ../modules/home/default-sys-module.nix ];
      profiles = [ ../profiles/dsn-small.nix ];
      tags = [ "monit" ];
      system = "x86_64-linux";
    };
    k3smaster = {
      name = "k3smaster";
      hostname = "k3smaster01";
      ip = "192.168.2.121";
      nixos-modules = [ ../hosts/k3smaster/configuration.nix ];
      home-modules = [ ../modules/home/default-sys-module.nix ];
      profiles = [ ../profiles/dsn-small.nix ];
      tags = [ "k3s" ];
      system = "x86_64-linux";
    };
    # k3sagent01 = {
    #   name = "k3sagent01";
    #   hostname = "k3sagent01";
    #   ip = "192.168.2.122";
    #   nixos-modules = [ ../hosts/k3sagent/configuration.nix ];
    #   home-modules = [ ../modules/home/default-sys-module.nix ];
    #   profiles = [ ../profiles/dsn-small.nix ];
    #   tags = [ "k3s" ];
    #   system = "x86_64-linux";
    # };
    # k3sagent02 = {
    #   name = "k3sagent02";
    #   hostname = "k3sagent02";
    #   ip = "192.168.2.123";
    #   nixos-modules = [ ../hosts/k3sagent/configuration.nix ];
    #   home-modules = [ ../modules/home/default-sys-module.nix ];
    #   profiles = [ ../profiles/dsn-small.nix ];
    #   tags = [ "k3s" ];
    #   system = "x86_64-linux";
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

  # ssh = {
  #   # define the host alias for remote builders
  #   # this config will be written to /etc/ssh/ssh_config
  #   # ''
  #   #   Host server1
  #   #     HostName 192.168.2.100
  #   #     Port 22
  #   #
  #   #   Host server2
  #   #     HostName 192.168.2.101
  #   #     Port 22
  #   #   ...
  #   # '';
  #   extraConfig = lib.attrsets.foldlAttrs (
  #     acc: host: val:
  #     acc
  #     + ''
  #       Host ${host}
  #         HostName ${val.ipv4}
  #         Port 22
  #     ''
  #   ) "" hostsAddr;
  #
  #   # define the host key for remote builders so that nix can verify all the remote builders
  #   # this config will be written to /etc/ssh/ssh_known_hosts
  #   knownHosts =
  #     # Update only the values of the given attribute set.
  #     #
  #     #   mapAttrs
  #     #   (name: value: ("bar-" + value))
  #     #   { x = "a"; y = "b"; }
  #     #     => { x = "bar-a"; y = "bar-b"; }
  #     lib.attrsets.mapAttrs
  #       (host: value: {
  #         hostNames = [
  #           host
  #           hostsAddr.${host}.ipv4
  #         ];
  #         publicKey = value.publicKey;
  #       })
  #       {
  #         server1.publicKey = "";
  #         server2.publicKey = "";
  #         server3.publicKey = "";
  #       };
  # };
}
