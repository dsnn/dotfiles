{ modulesPath, myvars, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./base.nix
  ];

  dsn = {
    k3s-agent = {
      enable = true;
      serverAddr = "https://${myvars.networking.hostsAddr.srv-k3s-01.ip}:6443";
    };
  };
}
