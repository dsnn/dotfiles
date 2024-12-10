{ ... }:
{
  dsn = {
    openssh.enable = true;
    user.enable = true;
    sops.enable = true;
    prometheus.enable = true;
  };

  # required: fails on lxc
  systemd.mounts = [
    {
      where = "/sys/kernel/debug";
      enable = false;
    }
  ];
}
