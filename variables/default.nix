{ inputs }:
{
  username = "dsn";
  useremail = "dsn@dsnn.io";

  networking = import ./network.nix { inherit inputs; };

  system = {
    aarch64-darwin = "aarch64-darwin";
    x86_64-linux = "x86_64-linux";
  };

  generateOptions = {
    formats = {
      proxmox-lxc = "proxmox-lxc";
    };
  };

  sopsOptions = {
    keyName = "keys.txt";
    keyPath = "/home/dsn/.config/sops/age";
  };

  # generate with modules/scripts/generate-password
  initialHashedPassword = "$2b$05$yPIF0wnops49ceqHXaDsM.h.RdJ1TLbyNUvQrZFjEGI1wF1KWVORu"; # asd123

  pubKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB" ];
}
