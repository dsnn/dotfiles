{
  modulesPath,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/scan/not-detected.nix"
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  boot = {
    loader.grub = {
      devices = [ "/dev/vda" ];
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-partlabel/disk-disk1-root";
    autoResize = true;
    fsType = "ext4";
  };

  dsn = {
    i18n.enable = true;
    nix.enable = true;
    openssh.enable = true;
    prometheus.enable = true;
    security.enable = true;
    shells.enable = true;
    k3s-server = {
      enable = true;
      services = {
        traefik = false;
      };
    };
    sops.enable = true;
    systemPackages.enable = true;
    user = {
      enable = true;
      initialHashedPassword = "$2b$05$yPIF0wnops49ceqHXaDsM.h.RdJ1TLbyNUvQrZFjEGI1wF1KWVORu";
    };
  };

  time.timeZone = "Europe/Stockholm";
  programs.zsh.enable = true;
  services.qemuGuest.enable = true;

  networking = {
    hostName = "k3s";
    enableIPv6 = false;
    defaultGateway = "192.168.2.1";
  };

  systemd.mounts = [
    {
      where = "/sys/kernel/debug";
      enable = false;
    }
  ];

  system.stateVersion = "24.11";
}
