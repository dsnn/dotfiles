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
