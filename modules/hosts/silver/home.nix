{
  flake.modules.homeManager.silver =
    { inputs, pkgs, ... }:
    let
      default-packages = with pkgs; [
        cmake
        curl
        fd
        gnumake
        gnused
        htop
        jq
        lsof
        mosh
        nawk
        ripgrep
        unzip
        vim
        wakeonlan
        xclip
      ];

      dev-packages = with pkgs; [
        nixos-generators
        colmena
        watchexec

        _1password-cli
        lazydocker
        (
          with dotnetCorePackages;
          combinePackages [
            sdk_8_0
            sdk_9_0
          ]
        )
        ansible
      ];

      neovim-package = with pkgs; [
        inputs.myflakes.packages."aarch64-darwin".neovim
        inputs.myflakes.packages."aarch64-darwin".tmux
        ansible-lint
        commitlint
        docker-compose-language-service
        eslint_d
        jq
        lua-language-server
        markdownlint-cli
        nil
        nixfmt-rfc-style
        pre-commit
        prettierd
        proselint
        shellcheck
        shfmt
        statix
        stylelint
        stylua
        vale
        yamllint
      ];
    in
    {
      home = {
        username = "dsn";
        homeDirectory = "/Users/dsn";
        stateVersion = "25.05";
        sessionVariables.NIXD_FLAGS = "-log=error";

        packages = default-packages ++ dev-packages ++ neovim-package;
      };
    };
}
