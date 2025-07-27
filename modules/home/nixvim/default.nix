{
  lib,
  config,
  inputs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.dsn.nixvim;
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./plugins
    ./options.nix
    ./keymaps.nix
    ./autocommands.nix
  ];

  options.dsn.nixvim = {
    enable = mkEnableOption "Enable nixvim";
  };

  config = mkIf cfg.enable {
    programs.zsh.initContent = ''
      function run_nvim() {
        BUFFER="nvim && clear"
        zle accept-line
      }
      zle -N run_nvim
      bindkey "^n" run_nvim
    '';

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      editorConfig.enable = true;

      globals = {
        mapleader = ",";
        maplocalleader = " ";
      };

      plugins = {
        web-devicons.enable = true;
        tmux-navigator.enable = true;
      };
    };
  };
}

# home.packages = [
#   # neovim
#   pkgs.nodePackages."bash-language-server"
#   pkgs.nodePackages."diagnostic-languageserver"
#   pkgs.nodePackages."dockerfile-language-server-nodejs"
#   pkgs.nodePackages."typescript"
#   pkgs.nodePackages."typescript-language-server"
#   pkgs.nodePackages."vscode-langservers-extracted"
#   pkgs.nodePackages."jsonlint"
#   pkgs.nodePackages."prettier"
#   pkgs.ansible-lint
#   pkgs.commitlint
#   pkgs.docker-compose-language-service
#   pkgs.eslint_d
#   pkgs.jq
#   pkgs.lua-language-server
#   pkgs.markdownlint-cli
#   pkgs.nil
#   unstable.nixd
#   pkgs.nixfmt-rfc-style
#   pkgs.pre-commit
#   pkgs.prettierd
#   pkgs.proselint
#   pkgs.shellcheck
#   pkgs.shfmt
#   pkgs.statix
#   pkgs.stylelint
#   pkgs.stylua
#   pkgs.tailwindcss-language-server
#   pkgs.yaml-language-server
#   pkgs.yamllint
#   # pkgs.vale
# ];
