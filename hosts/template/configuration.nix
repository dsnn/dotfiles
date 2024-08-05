{ pkgs, modulesPath, ... }:
let keyPath = "/home/dsn/.config/sops/age";
in {

  imports = [
    # ../../../system/nixos/services/openssh.nix
    # ../../../system/nixos/users.nix
    # ../../../system/nixos/services/k3s-node.nix
    # ../../../system/nixos/services/fail2ban.nix
    # ../../../system/nixos/system.nix
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    # (modulesPath + "/installer/scan/not-detected.nix")
    #   (modulesPath + "/profiles/qemu-guest.nix")
    #   ./disk-config.nix
  ];

  # boot.loader.grub = {
  #    # devices = [ ]; #  no need. handled by disko
  #    efiSupport = true;
  #    efiInstallAsRemovable = true;
  #  };

  sops.age.keyFile = "${keyPath}/keys.txt";

  services.openssh.enable = true;
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

  systemd.mounts = [{
    where = "/sys/kernel/debug";
    enable = false;
  }];

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

  # users.users.ops = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ];
  # };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25520 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
  ];

  users.users.dsn = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" "docker" ];
    hashedPassword =
      "$6$8CCpSyWNl2nlBSHa$8/QxBKPttbV47ItDhFNjq/Lv8kb3YiHdjy6f.TK19X4vFATnxlaUu6iv8YV6uxhtj9GKNRDMwyEOMgTmN8ljS."; # asd123

    openssh.authorizedKeys.keys = [
      "ssh-ed25520 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
      "ssh-rsa AAAAB4NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF"
    ];
  };

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
