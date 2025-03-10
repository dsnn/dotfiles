{ lib }:
{
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

  sshHosts = {
    "git" = {
      ip = "github.com";
      port = 22;
      user = "git";
      forwardAgent = "True";
    };
    "alpha" = {
      ip = "192.168.2.2";
      port = 22;
      user = "root";
    };
    "omega" = {
      ip = "192.168.2.3";
      port = 22;
      user = "root";
    };
    "nas" = {
      ip = "192.168.3.2";
      port = 11223;
      user = "dsn";
    };
    "docker1" = {
      ip = "192.168.2.110";
      port = 22;
      user = "dsn";
    };
    "docker2" = {
      ip = "192.168.2.104";
      port = 22;
      user = "dsn";
    };
  };

  hostsAddr = {
    anywhere = {
      name = "anywhere";
      nixos-modules = [ ../hosts/anywhere/anywhere.nix ];
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
    iso = {
      name = "iso";
      generate-modules = [ ../hosts/iso/configuration.nix ];
      format = "iso";
      system = "x86_64-linux";
    };
    k3s = {
      name = "k3s";
      hostname = "k3s";
      ip = "192.168.2.121";
      nixos-modules = [ ../hosts/k3s/configuration.nix ];
      home-modules = [ ../modules/home/default-sys-module.nix ];
      profiles = [ ../profiles/dsn-small.nix ];
      tags = [ "k3s" ];
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
    vma = {
      name = "vma";
      generate-modules = [ ../hosts/vma/proxmox-image.nix ];
      format = "proxmox";
      system = "x86_64-linux";
    };
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
}
