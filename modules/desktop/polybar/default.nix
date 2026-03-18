{
  flake.modules.homeManager.polybar =
    { config, pkgs, ... }:
    {
      home.packages = with pkgs; [
        polybarFull
        gsimplecal # simple calendar for polybar
      ];

      xdg.configFile."polybar".source =
        config.lib.file.mkOutOfStoreSymlink ~/dotfiles/modules/desktop/polybar/settings;
    };
}
