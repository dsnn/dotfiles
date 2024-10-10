{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.dsn.nvim;
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

  options.dsn.nvim = { enable = mkEnableOption "Enable neovim"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # neovim
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
      ansible-lint
      commitlint
      docker-compose-language-service
      eslint_d
      jq
      lua-language-server
      markdownlint-cli
      nil
      nixd
      nixfmt-classic
      nixpkgs-fmt
      pre-commit
      prettierd
      proselint
      shellcheck
      shfmt
      statix
      stylelint
      stylua
      tailwindcss-language-server
      yaml-language-server
      yamllint
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
      "${config.home.homeDirectory}/dotfiles/modules/home/neovim/nvim";
  };
}
