{
  flake.modules.home.karabiner =
    { config }:
    let
      destination = "${config.home.homeDirectory}.config/karabiner";
      source = "${config.home.homeDirectory}/dotfiles/modules/home/_karabiner/src";
    in
    {
      home.file.${destination}.source = config.lib.file.mkOutOfStoreSymlink "${source}";
    };
}
