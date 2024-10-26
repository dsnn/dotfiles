{ modulesPath, pkgs, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./srv-nixos-01-disk-config.nix
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services = {
    qemuGuest.enable = true;
    openssh.enable = true;
  };

  networking = {
    hostName = "srv-nixos-01";
    enableIPv6 = false;
    interfaces.ens18.ipv4.addresses = [
      {
        address = "192.168.2.111";
        prefixLength = 24;
      }
    ];
    defaultGateway = "192.168.2.1";
  };

  environment.systemPackages = with pkgs; [
    curl
    vim
    git
  ];

  programs.zsh.enable = true;

  users.users.dsn = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$6$5yJAKBYR8tC8GnDl$pD2PrYdR6jUur.emf6cxoOQcT7J1GIDEBCurc4j4QJC8YYWybW7KftY5J6gR.Bj66z4AG0CKVLJeDy3FnrvRX/";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
    ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
  ];

  system = {
    stateVersion = "24.05";
  };
}
