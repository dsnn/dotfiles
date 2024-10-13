{ lib, config, pkgs, ... }:
with lib;
let cfg = config.dsn.packages;
in {

  options.dsn.packages = {
    enable = mkEnableOption "Enable common stuff";
    enable-dev-tools = mkEnableOption "Enable development tools";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
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
      ] ++ pkgs.lib.optionals cfg.enable-dev-tools [
        #_1password
        ansible
        dotnet-sdk_8
        lazydocker
        nixos-generators
      ];

    # [
    #   (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" ]; })
    # ];
  };
}
