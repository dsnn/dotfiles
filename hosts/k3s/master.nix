{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./base.nix
  ];

  dsn = {
    k3s-server.enable = true;
  };
}
