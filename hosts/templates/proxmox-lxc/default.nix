{
  modulesPath,
  inputs,
  unstable,
  vars,
  ...
}:
{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    inputs.home-manager.nixosModules.home-manager
  ];

  dsn = {
    common.enable = true;
    # openssh.enable = true;
    user = {
      enable = true;
      initialHashedPassword = vars.initialHashedPassword;
    };
    sops.enable = true;
    # nixvim.enable = true; # use system wide nixvim ?
  };

  boot = {
    isContainer = true;
  };

  nixpkgs.config.allowUnfree = true;

  services = {
    qemuGuest.enable = true;
    openssh.enable = true;
  };

  proxmoxLXC = {
    enable = true;
    privileged = true;
    manageNetwork = false;
  };

  networking.usePredictableInterfaceNames = false;

  programs = {
    zsh.enable = true;
  };

  home-manager = {
    # saves extra eval, consistency and rm dep on NIX_PATH
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit unstable inputs;
    };

    sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];

    users.dsn.imports = [
      ../../../profiles/dsn-small.nix
      ../../../modules/home/default-sys-module.nix
    ];
  };

  nix.settings.trusted-users = [ "dsn" ];

  security.sudo.wheelNeedsPassword = false;

  system = {
    stateVersion = "24.05";
  };
}
