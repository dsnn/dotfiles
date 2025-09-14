{
  flake.modules.homeManager.user-dsn =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nerd-fonts.meslo-lg
      ];
    };
}
