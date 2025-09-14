{
  flake.modules.homeManager.user-dsn =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
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
    };
}
