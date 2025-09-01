{
  flake.modules.homeManager.home-manager =
    { pkgs, ... }:
    {

      home.packages = with pkgs; [ home-manager ];

      programs.home-manager.enable = true;
    };
}
