{
  flake.modules.homeManager.user-dsn =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        cmake
        curl
        fd
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
        pciutils
      ];
    };
}
