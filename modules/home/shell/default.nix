{
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    ;
  cfg = config.dsn.shell;
in
{
  imports = [
    ../fzf
    ../git.nix
    ./bat.nix
    ./inputrc.nix
    ./lsd.nix
    ./starship.nix
    ./vivid.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  options.dsn.shell = {
    enable = mkEnableOption "Enable my default shell";
  };

  config = mkIf cfg.enable {
    dsn = {
      bat.enable = true;
      fzf.enable = true;
      git.enable = true;
      inputrc.enable = true;
      lsd.enable = true;
      starship.enable = true;
      vivid.enable = true;
      zoxide.enable = true;
      zsh = {
        enable = true;
        enable-docker-aliases = false;
      };
    };
  };
}
