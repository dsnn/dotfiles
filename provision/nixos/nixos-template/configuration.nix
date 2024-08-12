({ lib, modulesPath, pkgs, ... }: {
  imports = [ "${modulesPath}/virtualisation/proxmox-image.nix" ];

  proxmox = {
    qemuConf = {
      name = "nixos";
      cores = 4;
      memory = 4096;
    };
  };

  networking = {
    hostName = lib.mkForce "";
    useDHCP = true;
  };

  services = {
    cloud-init = {
      enable = true;
      network.enable = true;
    };
    getty.autologinUser = "root";
    sshd.enable = true;
  };
})
