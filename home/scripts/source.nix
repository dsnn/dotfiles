{ config, ... }:
let
  binPath = "${config.home.homeDirectory}/.local/bin";
  scriptsPath = "${config.home.homeDirectory}/dotfiles/home/scripts";
in {
  home.file."${binPath}".source =
    config.lib.file.mkOutOfStoreSymlink "${scriptsPath}";

  programs.zsh.initExtra = ''
    if [ -d "$HOME/.local/bin" ]; then
      export PATH="${binPath}:$PATH"
    fi
  '';
}
