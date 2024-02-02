{ lib, config, pkgs, ... }:
let
  fromGitHub = rev: ref: repo:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
        rev = rev;
      };
    };
in {

  home.packages = with pkgs; [
    # neovim
    lua-language-server
    nil
    nixd
    nixfmt
    nixpkgs-fmt
    nodePackages."bash-language-server"
    nodePackages."diagnostic-languageserver"
    nodePackages."dockerfile-language-server-nodejs"
    nodePackages."pyright"
    nodePackages."typescript"
    nodePackages."typescript-language-server"
    nodePackages."vscode-langservers-extracted"
    nodePackages."yaml-language-server"
    prettierd
    rnix-lsp
    shfmt
    stylua
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-cmdline
      cmp-cmdline-history
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-nvim-lua
      cmp-path
      conform-nvim
      copilot-cmp
      copilot-lua
      diffview-nvim
      friendly-snippets
      gruvbox-material
      harpoon
      lspkind-nvim
      lualine-nvim
      luasnip
      mini-nvim
      neodev-nvim
      neogit
      nui-nvim
      nvim-compe
      nvim-lspconfig
      nvim-lspconfig
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      nvim-ts-context-commentstring
      nvim-web-devicons
      plenary-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      trouble-nvim
      vim-fugitive
      vim-surround
      vim-tmux-navigator
      (fromGitHub "e578fe7a5832421b0d2c5b3c0a7a1e40e0f6a47a" "main"
        "nvim-neo-tree/neo-tree.nvim")
      (fromGitHub "483019d251c31acd14102bc279f938f98d9a3de6" "main"
        "mrbjarksen/neo-tree-diagnostics.nvim")
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
