{
  inputs,
  pkgs,
  system,
  ...
}:
{
  # move to shell:
  # nixos-generators
  # colmena

  home.packages = with pkgs; [
    inputs.myflakes.packages.${system}.neovim

    # default
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

    # dev
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

    # neovim
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
}
