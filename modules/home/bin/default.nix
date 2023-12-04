{ config, ... }: {
  home.file."${config.home.homeDirectory}/.local/bin".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/modules/home/bin/scripts";

  programs.zsh.initExtra = ''
    if [ -d "$HOME/.local/bin" ]; then
      export PATH="$HOME/.local/bin:$PATH"
    fi
  '';
}
