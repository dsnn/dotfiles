{ modulesPath, ... }: {
  # let keyPath = "/home/dsn/.config/sops/age";

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./dev-disk-config.nix
  ];

  dsn = {
    common.enable = true;
    openssh.enable = true;
    user.enable = true;
    sops.enable = true;
    # virtualisation.enable = true;
    gitea.enable = true;
    drone-server.enable = true;
    drone-runner-docker.enable = true;
    docker-registry.enable = true;
    homepage.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  boot = {
    loader.grub = {
      devices = [ ];
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
    isContainer = false;
  };

  programs.zsh.enable = true;

  services.qemuGuest.enable = true;

  networking = {
    hostName = "nixos-dev";
    dhcpcd.enable = true;
    interfaces.eth0.useDHCP = true;
  };

  system = { stateVersion = "24.05"; };
}
