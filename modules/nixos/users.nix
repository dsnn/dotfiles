{
  config,
  pkgs,
  lib,
  myvars,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    types
    ;
  inherit (myvars) username pubKeys;
  cfg = config.dsn.user;
in
{
  options.dsn.user = {
    enable = mkEnableOption "Enable users";
    initialHashedPassword = mkOption {
      type = types.str;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    sops.secrets = {
      "password/dsn" = {
        sopsFile = ../../secrets/passwords.yaml;
        neededForUsers = true;
      };
      "password/root" = {
        sopsFile = ../../secrets/passwords.yaml;
        neededForUsers = true;
      };
    };

    users = {
      mutableUsers = false;
      defaultUserShell = pkgs.zsh;
    };

    users.users.dsn = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [
        username
        "users"
        "wheel"
        "networkmanager"
        "docker"
      ];

      initialHashedPassword = mkIf (cfg.initialHashedPassword != "") cfg.initialHashedPassword;
      hashedPasswordFile = mkIf (cfg.initialHashedPassword == "") config.sops.secrets."password/dsn".path;
      openssh.authorizedKeys.keys = pubKeys;

    };

    users.users.root = {
      hashedPasswordFile = config.sops.secrets."password/root".path;
      openssh.authorizedKeys.keys = pubKeys;
    };
  };
}
