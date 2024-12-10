{
  modulesPath,
  host,
  ...
}:
let
  inherit (host) ip;
in
{
  imports = [
    "${modulesPath}/installer/scan/not-detected.nix"
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  dsn = {
    openssh.enable = true;
    user.enable = true;
    sops.enable = true;
    prometheus.enable = true;
    k3s-agent = {
      enable = true;
      serverAddr = "https://${ip}:6443";
    };
  };

  systemd.mounts = [
    {
      where = "/sys/kernel/debug";
      enable = false;
    }
  ];
}
