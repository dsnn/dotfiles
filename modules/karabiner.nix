{
  flake.modules.homeManager.karabiner =
    { config, ... }:
    let
      source = "${config.home.homeDirectory}/dotfiles/modules/home/karabiner/src";
      destination = "${config.home.homeDirectory}.config/karabiner";
    in
    {
      home.file.${destination}.source = config.lib.file.mkOutOfStoreSymlink "${source}";
    };
}
