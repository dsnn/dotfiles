{ pkgs, modulesPath, ... }: {
  # let keyPath = "/home/dsn/.config/sops/age";

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./template-disk-config.nix
  ];

  dsn = {
    common.enable = true;
    openssh.enable = true;
    user.enable = true;
    # fail2ban.enable = true;
    sops.enable = true;
  };

  boot = {
    loader.grub = {
      devices = [ ]; # no need. handled by disko
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
    isContainer = false;
  };

  # sops.age.keyFile = "${config.users.users.dsn.home}/.config/sops/age/keys.txt";

  time.timeZone = "Europe/Stockholm";
  programs.zsh.enable = true;

  # services.qemuGuest.enable = true;

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25520 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
  ];

  system = { stateVersion = "24.05"; };

  networking = {
    hostName = "template";
    # defaultGateway = {
    #   address = "192.168.2.200";
    #   interface = "eth0";
    # };
    dhcpcd.enable = true;
    interfaces.eth0.useDHCP = true;
  };

  # services.cloud-init = {
  #   enable = true;
  #   network.enable = true;
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
  # };

  # systemd.mounts = [{
  #   where = "/sys/kernel/debug";
  #   enable = false;
  # }];

  # systemd.network.enable = true;

  # environment.systemPackages = with pkgs; [
  #   age
  #   coreutils
  #   curl
  #   git
  #   home-manager
  #   htop
  #   man
  #   sops
  #   sudo
  #   vim
  #   wget
  # ];

}
