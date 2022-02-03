{ config, pkgs, ... }: {

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    # plugins = with pkgs.vimPlugins; [
    #   telescope-nvim
    #   telescope-fzf-native-nvim
    #   (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
    # ];
    # extraPackages = with pkgs; [ rnix-lsp gcc ripgrep fd ];
  };

}
