{ lib }:
rec {
  username = "dsn";
  useremail = "dsn@dsnn.io";
  timeZone = "Europe/Stockholm";
  version = "24.11";

  networking = {
    mainGateway = "192.168.1.1"; # main router
    defaultGateway = "192.168.2.1";
    loopback = "127.0.0.1";
    allInterfaces = "0.0.0.0";
    defaultInterfaceName = "eth0";

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
  };

  hosts = import ./hosts.nix { inherit lib; };

  trustedUsers = [
    "root"
    "dsn"
    "@wheel"
  ];

  configurations = {
    nixos = "nixos";
    darwin = "darwin";
    home = "home";
    colmena = "colmena";
    generate = "generate";
  };

  system = {
    aarch64-darwin = "aarch64-darwin";
    x86_64-linux = "x86_64-linux";
  };

  generateOptions = {
    formats = {
      proxmox-lxc = "proxmox-lxc";
    };
  };

  deploymentKeys = {
    "sops-key" = {
      name = "keys.txt";
      keyFile = "/home/dsn/.config/sops/age/keys.txt";
      destDir = "/home/dsn/.config/sops/age";
      user = username;
    };
  };

  # generate with modules/scripts/generate-password
  initialHashedPassword = "$2b$05$yPIF0wnops49ceqHXaDsM.h.RdJ1TLbyNUvQrZFjEGI1wF1KWVORu"; # asd123

  pubKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF%"
  ];
}
