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
    nixfmt-classic
    nixpkgs-fmt
    nodePackages."bash-language-server"
    nodePackages."diagnostic-languageserver"
    nodePackages."dockerfile-language-server-nodejs"
    nodePackages."graphql-language-service-cli"
    nodePackages."typescript"
    nodePackages."typescript-language-server"
    nodePackages."vim-language-server"
    nodePackages."vscode-langservers-extracted" # HTML/CSS/JSON/ESLint language servers extracted from vscode
    nodePackages."jsonlint"
    nodePackages."prettier"
    prettierd
    shfmt
    stylua
    tailwindcss-language-server
    yaml-language-server
    docker-compose-language-service
    ansible-lint
    yamllint
    eslint_d
    proselint
    shellcheck
    statix
    commitlint
    markdownlint-cli
    stylelint
    jq
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
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-nvim-lua
      cmp-path
      cmp_luasnip
      conform-nvim
      nvim-lint
      copilot-cmp
      copilot-lua
      diffview-nvim
      friendly-snippets
      gruvbox-material
      catppuccin-nvim
      kanagawa-nvim
      harpoon
      lspkind-nvim
      lualine-nvim
      luasnip
      mini-nvim
      neo-tree-nvim
      neodev-nvim
      neogit
      nui-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      nvim-ts-context-commentstring
      nvim-web-devicons
      plenary-nvim
      persistence-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim # review (not used atm)
      telescope-nvim
      trouble-nvim
      vim-fugitive
      vim-surround
      vim-tmux-navigator
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
