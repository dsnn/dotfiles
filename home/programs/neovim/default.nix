{ config, pkgs, ... }: {

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs; [
      # vimPlugins.omnisharp-extended-lsp-nvim
      vimPlugins.catppuccin-nvim
      vimPlugins.gitsigns-nvim
      vimPlugins.lualine-nvim
      vimPlugins.nvim-colorizer-lua
      vimPlugins.nvim-lspconfig
      vimPlugins.nvim-treesitter-context
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.nvim-web-devicons
      vimPlugins.oil-nvim
      vimPlugins.plenary-nvim
      vimPlugins.popup-nvim
      vimPlugins.telescope-nvim
      vimPlugins.vim-floaterm
      vimPlugins.luasnip
    ];

    extraPackages = with pkgs; [
      # dotnet-sdk_8
      # omnisharp-roslyn
      fd
      lazydocker
      lua-language-server
      nil
      nil
      nixd
      nixfmt
      nixpkgs-fmt
      # nodePackages."bash-language-server"
      # nodePackages."diagnostic-languageserver"
      # nodePackages."dockerfile-language-server-nodejs"
      # nodePackages."pyright"
      # nodePackages."typescript"
      # nodePackages."typescript-language-server"
      # nodePackages."vscode-langservers-extracted"
      # nodePackages."yaml-language-server"
      ripgrep
      rnix-lsp
      shfmt
      # terraform
      # terraform-ls
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
