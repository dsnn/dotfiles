{ config, pkgs, ... }: {

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs; [
      # vimPlugins.omnisharp-extended-lsp-nvim

      # languages
      vimPlugins.nvim-lspconfig
      vimPlugins.nvim-treesitter-context
      vimPlugins.nvim-treesitter.withAllGrammars

      # extra
      vimPlugins.oil-nvim
      vimPlugins.luasnip
      vimPlugins.vim-floaterm
      vimPlugins.gitsigns-nvim
      vimPlugins.lualine-nvim

      # ui
      vimPlugins.catppuccin-nvim
      vimPlugins.nvim-colorizer-lua
      vimPlugins.nvim-web-devicons

      # telescope
      vimPlugins.telescope-nvim
      vimPlugins.popup-nvim
      vimPlugins.plenary-nvim
    ];
  };

  programs.zsh.initExtra = ''
    function run_nvim() {
      BUFFER="nvim && clear"
      zle accept-line
    }
    zle -N run_nvim
    bindkey "^n" run_nvim
  '';

  home.file."${config.home.homeDirectory}/.config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/home/programs/neovim/nvim";
}
