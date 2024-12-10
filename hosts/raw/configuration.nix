{
  config,
  lib,
  ...
}:
{
  imports = [
    ./disko.nix
  ];

  # Since we aren't letting Disko manage fileSystems.*, we need to configure it ourselves
  # Root partition, third partition on the disk image. Since my VPS recognizes
  # hard drive as "sda", I specify "sda3" here. If your VPS recognizes the drive
  # differently, change accordingly
  fileSystems."/" = {
    device = "/dev/vda3";
    fsType = "btrfs";
    options = [
      "compress-force=zstd"
      "nosuid"
      "nodev"
    ];
  };

  # /boot partition, second partition on the disk image. Since my VPS recognizes
  # hard drive as "sda", I specify "sda2" here. If your VPS recognizes the drive
  # differently, change accordingly
  fileSystems."/boot" = {
    device = "/dev/vda2";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  # Kernel parameters I use
  boot.kernelParams = [
    # Disable auditing
    "audit=0"
    # Do not generate NIC names based on PCIe addresses (e.g. enp1s0, useless for VPS)
    # Generate names based on orders (e.g. eth0)
    "net.ifnames=0"
  ];

  # My Initrd config, enable ZSTD compression and use systemd-based stage 1 boot
  boot.initrd = {
    compressor = "zstd";
    compressorArgs = [
      "-19"
      "-T0"
    ];
    systemd.enable = true;
  };

  # Install Grub
  boot.loader.grub = {
    enable = !config.boot.isContainer;
    default = "saved";
    devices = [ "/dev/vda" ];
  };

  # Timezone, change based on your location
  time.timeZone = "Europe/Stockholm";

  # Root password and SSH keys. If network config is incorrect, use this password
  # to manually adjust network config on serial console/VNC.
  users.mutableUsers = false;
  users.users.dsn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$2b$05$yPIF0wnops49ceqHXaDsM.h.RdJ1TLbyNUvQrZFjEGI1wF1KWVORu";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
    ];
  };

  users.users.root = {
    hashedPassword = "$2b$05$yPIF0wnops49ceqHXaDsM.h.RdJ1TLbyNUvQrZFjEGI1wF1KWVORu";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
    ];
  };

  # Manage networking with systemd-networkd
  systemd.network.enable = true;
  services.resolved.enable = false;
  services.cloud-init.enable = true;
  programs.zsh.enable = true;
  security.sudo.wheelNeedsPassword = false;
  services.openssh.enable = true;
  services.qemuGuest.enable = true;

  # Configure network IP and DNS
  systemd.network.networks.eth0 = {
    address = [ "123.45.678.90/24" ];
    gateway = [ "123.45.678.1" ];
    matchConfig.Name = "eth0";
  };
  networking.nameservers = [
    "8.8.8.8"
  ];

  # Disable NixOS's builtin firewall
  networking.firewall.enable = false;

  # Disable DHCP and configure IP manually
  networking.useDHCP = false;

  # Hostname, can be set as you wish
  networking.hostName = "nixos-cloud";

  # Latest NixOS version on your first install. Used to prevent backward
  # incompatibilities on major upgrades
  system.stateVersion = "24.11";

  # Kernel modules required by QEMU (KVM) virtual machine
  boot.initrd.postDeviceCommands = lib.mkIf (!config.boot.initrd.systemd.enable) ''
    # Set the system time from the hardware clock to work around a
    # bug in qemu-kvm > 1.5.2 (where the VM clock is initialised
    # to the *boot time* of the host).
    hwclock -s
  '';

  boot.initrd.availableKernelModules = [
    "virtio_net"
    "virtio_pci"
    "virtio_mmio"
    "virtio_blk"
    "virtio_scsi"
  ];
  boot.initrd.kernelModules = [
    "virtio_balloon"
    "virtio_console"
    "virtio_rng"
  ];
}
