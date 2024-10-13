{ config, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  config = {
    # Provide a default hostname
    networking.hostName = "nixos-cloud";
    networking = {
      useDHCP = false;
      dhcpcd.enable = false;
      interfaces.eth0.useDHCP = false;
    };

    # Enable QEMU Guest for Proxmox
    services.qemuGuest.enable = true;

    # Use the boot drive for grub
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";

    boot.growPartition = true;

    users.users.dsn = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };

    # Allow remote updates with flakes and non-root users
    nix.settings.trusted-users = [ "dsn" "root" "@wheel" ];
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable mDNS for `hostname.local` addresses
    # services.avahi.enable = true;
    # services.avahi.nssmdns4 = true;
    # services.avahi.publish = {
    #   enable = true;
    #   addresses = true;
    # };

    proxmox = {
      qemuConf = {
        virtio0 = "local:vm-903-disk-0";
        ostype = "cloud-init";
        cores = 1;
        memory = 4096;
        name = "nixos-cloud";
        net0 = "virtio=00:00:00:00:00:00,bridge=vmbr0,firewall=0";
        serial0 = "socket";
        agent = true;
      };
      filenameSuffix = config.proxmox.qemuConf.name;
    };

    # Some sane packages we need on every system
    environment.systemPackages = with pkgs; [
      vim # for emergencies
      git # for pulling nix flakes
      python3 # for ansible
    ];

    # Don't ask for passwords
    security.sudo.wheelNeedsPassword = false;

    # Enable ssh
    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };
    programs.ssh.startAgent = true;

    # Default filesystem
    fileSystems."/" = {
      label = "nixos";
      fsType = "ext4";
      autoResize = true;
    };

    services.cloud-init = {
      enable = true;
      network.enable = true;
      config = ''
        system_info:
          distro: nixos
          network:
            renderers: [ 'networkd' ]
          default_user:
            name: dsn
        users:
            - default
        ssh_pwauth: false
        chpasswd:
          expire: false
        cloud_init_modules:
          - migrator
          - seed_random
          - growpart
          - resizefs
        cloud_config_modules:
          - disk_setup
          - mounts
          - set-passwords
          - ssh
        cloud_final_modules: []
      '';
    };

    system.stateVersion = "24.05";
  };
}
