{
  lib,
  config,
  pkgs,
  unstable,
  ...
}:
with lib;
let
  cfg = config.dsn.nvim;
  fromGitHub =
    rev: ref: repo:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        inherit ref rev;
      };
    };
in
{

  options.dsn.nvim = {
    enable = mkEnableOption "Enable neovim";
  };

  config = mkIf cfg.enable {
    home.packages = [
      # neovim
      pkgs.nodePackages."bash-language-server"
      pkgs.nodePackages."diagnostic-languageserver"
      pkgs.nodePackages."dockerfile-language-server-nodejs"
      pkgs.nodePackages."graphql-language-service-cli"
      pkgs.nodePackages."typescript"
      pkgs.nodePackages."typescript-language-server"
      pkgs.nodePackages."vim-language-server"
      pkgs.nodePackages."vscode-langservers-extracted" # HTML/CSS/JSON/ESLint language servers extracted from vscode
      pkgs.nodePackages."jsonlint"
      pkgs.nodePackages."prettier"
      pkgs.ansible-lint
      pkgs.commitlint
      pkgs.docker-compose-language-service
      pkgs.eslint_d
      pkgs.jq
      pkgs.lua-language-server
      pkgs.markdownlint-cli
      pkgs.nil
      unstable.nixd
      pkgs.nixfmt-rfc-style
      pkgs.pre-commit
      pkgs.prettierd
      pkgs.proselint
      pkgs.shellcheck
      pkgs.shfmt
      pkgs.statix
      pkgs.stylelint
      pkgs.stylua
      pkgs.tailwindcss-language-server
      pkgs.yaml-language-server
      pkgs.yamllint
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
          "mrbjarksen/neo-tree-diagnostics.nvim"
        )
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

    home.file."${config.home.homeDirectory}/.config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/neovim/nvim";
  };
}
