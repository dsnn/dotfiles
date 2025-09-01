{
  flake.modules.homeManager.karabiner =
    { config, pkgs, ... }:
    let
      source = "${config.home.homeDirectory}/dotfiles/modules/home/karabiner/src";
      destination = "${config.home.homeDirectory}.config/karabiner";
    in
    {

      home.packages = with pkgs; [ karabiner ];

      home.file.${destination}.source = config.lib.file.mkOutOfStoreSymlink "${source}";
    };
}
