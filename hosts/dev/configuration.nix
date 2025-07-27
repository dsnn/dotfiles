{
  modulesPath,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    inputs.nix-ld.nixosModules.nix-ld
    ./disko.nix
  ];

  dsn = {
    i18n.enable = true;
    nix.enable = true;
    openssh.enable = true;
    prometheus.enable = true;
    security.enable = true;
    shells.enable = true;
    sops.enable = true;
    systemPackages.enable = true;
    user.enable = true;
    systemPackages = {
      enableMonitoringPkgs = true;
      enableNetworkingPkgs = true;
    };
  };

  environment.systemPackages = with pkgs; [
    k3s
  ];

  nix.settings.nix-path = "nixpkgs=flake:nixpkgs";
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
  programs.nix-ld.dev.enable = true;
  # programs.nix-ld = {
  #   enable = true;
  #   libraries = with pkgs; [
  #     stdenv.cc.cc
  #     volta
  #   ];
  # };
  # NIX_LD_LIBRARY_PATH = lib.makeLibraryPath (with pkgs; [ stdenv.cc.cc openssl ]);
  # NIX_LD = lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";

  services.qemuGuest.enable = true;

  networking = {
    hostName = "nixos-dev";
    dhcpcd.enable = true;
    interfaces.eth0.useDHCP = true;
  };

  system = {
    stateVersion = "25.05";
  };
}
