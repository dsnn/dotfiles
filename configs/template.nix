{ pkgs, modulesPath, ... }:
let keyPath = "/home/dsn/.config/sops/age";
in {

  imports = [
    ../../system/nixos/services/openssh.nix
    ../../system/nixos/users.nix
    # ../../../system/nixos/services/k3s-node.nix
    # ../../../system/nixos/services/fail2ban.nix
    # ../../../system/nixos/system.nix
    # (modulesPath + "/virtualisation/proxmox-lxc.nix")
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  boot.loader.grub = {
    devices = [ ]; # no need. handled by disko
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  sops.age.keyFile = "${keyPath}/keys.txt";

  # services.openssh.enable = true;
  # services.qemuGuest.enable = true;
  services.cloud-init = {
    enable = true;
    network.enable = true;
    # config = ''
    #   system_info:
    #     distro: nixos
    #     network:
    #       renderers: [ 'networkd' ]
    #     default_user:
    #       name: ops
    #   users:
    #       - default
    #   ssh_pwauth: false
    #   chpasswd:
    #     expire: false
    #   cloud_init_modules:
    #     - migrator
    #     - seed_random
    #     - growpart
    #     - resizefs
    #   cloud_config_modules:
    #     - disk_setup
    #     - mounts
    #     - set-passwords
    #     - ssh
    #   cloud_final_modules: []
    # '';
  };

  security.sudo.wheelNeedsPassword = false;

  # systemd.mounts = [{
  #   where = "/sys/kernel/debug";
  #   enable = false;
  # }];

  # networking = {
  #   hostName = "nixos-template";
  #   defaultGateway = {
  #     address = "192.168.2.200";
  #     interface = "eth0";
  #   };
  #   dhcpcd.enable = false;
  #   interfaces.eth0.useDHCP = false;
  # };

  # systemd.network.enable = true;

  boot.isContainer = true;
  time.timeZone = "Europe/Stockholm";
  programs.zsh.enable = true;

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25520 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
  ];

  environment.systemPackages = with pkgs; [
    age
    coreutils
    curl
    git
    home-manager
    htop
    man
    sops
    sudo
    vim
    wget
  ];

  system = { stateVersion = "24.05"; };
}
