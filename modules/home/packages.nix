{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.dsn.packages;
  inherit (lib) mkEnableOption mkIf optionals;
  defaultPkgs = with pkgs; [
    cmake
    curl
    fd
    git-crypt
    gnumake
    gnused
    htop
    jq
    lsof
    mosh
    nawk
    ripgrep
    unzip
    vim
    wakeonlan
    xclip
  ];
  devPkgs = with pkgs; [
    _1password-cli
    ansible
    lazydocker
    nixos-generators
    colmena
    (
      with dotnetCorePackages;
      combinePackages [
        sdk_8_0
        sdk_9_0
      ]
    )
  ];
  fontPkgs = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "RobotoMono"
      ];
    })
  ];
in
{
  options.dsn.packages = {
    enable = mkEnableOption "Enable common stuff";
    enableDevPkgs = mkEnableOption "Enable development tools";
    enableFontPkgs = mkEnableOption "Enable font pkgs";
  };

  config = mkIf cfg.enable {
    home.packages =
      defaultPkgs ++ optionals cfg.enableDevPkgs devPkgs ++ optionals cfg.enableFontPkgs fontPkgs;
  };
}
