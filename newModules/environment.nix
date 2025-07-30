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
}
