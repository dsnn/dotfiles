{ config, pkgs, ...}:{

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file."/Users/dsn/.config/nvim".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/modules/home/neovim/nvim";
}
