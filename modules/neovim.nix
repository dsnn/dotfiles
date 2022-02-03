{ config, pkgs, ... }: {

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    # plugins = with pkgs.vimPlugins; [
    #   nord-nvim
    #   lightline-vim
    #   vim-nix
    #   nvim-colorizer-lua
    #   nvim-autopairs
    #   nvim-lspconfig
    #   nvim-tree-lua
    #   telescope-nvim
    #   telescope-fzf-native-nvim
    #   (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
    #   nvim-cmp
    #   cmp-nvim-lsp
    #   cmp-buffer
    #   cmp-path
    #   cmp-treesitter
    #   neogit
    # ];
    # extraPackages = with pkgs; [ rnix-lsp gcc ripgrep fd ];

  };

}
