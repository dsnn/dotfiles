{
  flake.modules.darwin.nix =
    { pkgs, ... }:
    {
      nix = {
        settings.trusted-users = [ "@admin" ];
        linux-builder = {
          enable = false;
          ephemeral = true;
          systems = [
            "x86_64-linux"
            "aarch64-linux"
          ];
          maxJobs = 4;
          package = pkgs.darwin.linux-builder-x86_64;
          config = {
            boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
            virtualisation = {
              cores = 6;
              darwin-builder = {
                diskSize = 40 * 1024;
                memorySize = 8 * 1024;
              };
            };
          };
        };
      };
    };
}
