{
  flake.modules.homeManager.direnv =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ direnv ];

      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
    };
}
