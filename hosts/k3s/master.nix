{ modulesPath, host, ... }:
let
  inherit (host) ip;
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./base.nix
  ];

  dsn = {
    common.enable = true;
    k3s-server = {
      enable = true;
      serverAddr = "https://${ip}:6443";
    };
  };
}
