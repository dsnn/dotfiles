{
  flake.modules.homeManager.rider =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        jetbrains.rider
      ];
    };
}
