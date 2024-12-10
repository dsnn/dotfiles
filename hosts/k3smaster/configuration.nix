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
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
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
    k3s-server = {
      enable = true;
      serverAddr = "https://192.168.2.121:6443"; # TODO: get ip from hosts
    };
  };

  networking = {
    hostName = "k3smaster01";
    enableIPv6 = false;
    interfaces.ens18.ipv4.addresses = [
      {
        address = "192.168.2.121";
        prefixLength = 24;
      }
    ];
    defaultGateway = "192.168.2.1";
  };

  time.timeZone = "Europe/Stockholm";

  programs.zsh.enable = true;

  services.qemuGuest.enable = true;

  systemd.mounts = [
    {
      where = "/sys/kernel/debug";
      enable = false;
    }
  ];

  system.stateVersion = "24.11";
}
