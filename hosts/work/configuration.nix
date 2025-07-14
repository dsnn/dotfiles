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

  services.qemuGuest.enable = true;

  dsn = {
    i18n.enable = true;
    nix.enable = true;
    openssh.enable = true;
    security.enable = true;
    shells.enable = true;
    sops.enable = true;
    user.enable = true;
    systemPackages = {
      enable = true;
      enableMonitoringPkgs = true;
      enableNetworkingPkgs = true;
    };
  };

  environment.systemPackages = with pkgs; [
    jetbrains.rider
    (
      with dotnetCorePackages;
      combinePackages [
        sdk_8_0
        sdk_9_0
      ]
    )
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

  networking = {
    hostName = "work";
    dhcpcd.enable = true;
    interfaces.eth0.useDHCP = true;
  };

  system = {
    stateVersion = "24.11";
  };
}
