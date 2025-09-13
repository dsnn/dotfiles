{
  flake.modules.darwin.environment =
    { pkgs, ... }:
    {
      environment = {
        systemPackages = with pkgs; [
          age
          coreutils
          file
          findutils
          git
          home-manager
          htop
          man
          nix
          tree
          vim
          which
        ];

        shells = with pkgs; [
          bash
          zsh
        ];

        pathsToLink = [ "/Applications" ];
      };
    };

  flake.modules.nixos.environment =
    { pkgs, ... }:
    let
      defaultPkgs = with pkgs; [
        age
        coreutils
        file
        findutils
        git
        home-manager
        htop
        man
        nix
        tree
        vim
        which
      ];
      # # system monitoring
      monitoringPkgs = with pkgs; [
        btop
        iftop
        iotop
        nmon
        sysbench
        sysstat
      ];
      networkingPkgs = with pkgs; [
        wget
        aria2 # A lightweight multi-protocol & multi-source command-line download utility
        curl
        dnsutils # `dig` + `nslookup`
        ipcalc # it is a calculator for the IPv4/v6 addresses
        iperf3
        ldns # replacement of `dig`, it provide the command `drill`
        mtr # A network diagnostic tool
        nmap # A utility for network discovery and security auditing
        rsync
        socat # replacement of openbsd-netcat
        wget
      ];
    in
    {
      environment.systemPackages = defaultPkgs ++ monitoringPkgs ++ networkingPkgs;
    };
}
