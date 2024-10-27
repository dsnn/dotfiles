{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
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

    users.users.root = {
      hashedPasswordFile = config.sops.secrets."password/root".path;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
      ];
    };

    users.users.dsn = {
      shell = pkgs.zsh;
      isNormalUser = true;
      group = "users";
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "disk"
        "networkmanager"
        "docker"
      ];
      initialHashedPassword = mkIf (cfg.initialHashedPassword != "") cfg.initialHashedPassword;
      hashedPasswordFile = mkIf (cfg.initialHashedPassword == "") config.sops.secrets."password/dsn".path;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF%"
      ];
    };

    security.sudo.wheelNeedsPassword = false;

    # nix.settings.trusted-users = [ "@wheel" ];
    users.groups.docker.members = config.users.groups.wheel.members;
  };
}
