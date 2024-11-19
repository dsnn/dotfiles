{ ... }:
{
  hostsAddr = {
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
    k3smaster01 = {
      name = "k3s";
      hostname = "srv-k3s-01";
      ip = "192.168.2.121";
      nixos-modules = [ ../hosts/k3s/master.nix ];
      home-modules = [ ../modules/home/default-sys-module.nix ];
      profiles = [ ../profiles/dsn-small.nix ];
      tags = [ "k3s" ];
      system = "x86_64-linux";
    };
    k3sagent01 = {
      name = "k3s";
      hostname = "srv-k3s-agent-01";
      ip = "192.168.2.122";
      nixos-modules = [ ../hosts/k3s/agent.nix ];
      home-modules = [ ../modules/home/default-sys-module.nix ];
      profiles = [ ../profiles/dsn-small.nix ];
      tags = [ "k3s" ];
      system = "x86_64-linux";
    };
    k3sagent02 = {
      name = "k3s";
      hostname = "srv-k3s-agent-01";
      ip = "192.168.2.123";
      nixos-modules = [ ../hosts/k3s/agent.nix ];
      home-modules = [ ../modules/home/default-sys-module.nix ];
      profiles = [ ../profiles/dsn-small.nix ];
      tags = [ "k3s" ];
      system = "x86_64-linux";
    };
  };
}
