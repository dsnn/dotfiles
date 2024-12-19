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
    systemPackages.enable = true;
    security.enable = true;
    shells.enable = true;
    openssh.enable = true;
    sops.enable = true;
    prometheus.enable = true;
    user = {
      enable = true;
      initialHashedPassword = "$2b$05$yPIF0wnops49ceqHXaDsM.h.RdJ1TLbyNUvQrZFjEGI1wF1KWVORu";
    };
  };

  # ------ k3s

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
      # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
      # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
      80
      443
    ];
    allowedUDPPorts = [
      # 8472 # k3s, flannel: required if using multi-node for inter-node networking
    ];
  };

  services.k3s = {
    enable = true;
    role = "server";
    clusterInit = true;
    extraFlags = toString [
      # "--debug" # Optionally add additional args to k3s
    ];
  };

  # ------

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
