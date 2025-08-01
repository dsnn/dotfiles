{
  flake.modules.nixos.users =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      inherit (lib)
        mkIf
        mkOption
        types
        ;
      username = "dsn";
      pubKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF%"
      ];
      sopsFile = config.dsn.cifs.credentials.sopsFile;
      cfg = config.dsn.user;
    in
    {
      options.dsn.user = {
        initialHashedPassword = mkOption {
          type = types.str;
          default = "";
        };

        credentials = mkOption {
          type = types.submodule {
            options = {
              sopsFile = mkOption {
                type = types.path;
                default = ../../secrets/passwords.yaml;
                description = "Path to the sops file.";
              };

              targetPath = mkOption {
                type = types.str;
                default = "nixos/smb-secrets";
                description = "Path in /etc to link secret to.";
              };
            };
          };
          default = { };
          description = "Configuration for SMB/CIFS credentials via sops and /etc.";
        };
      };

      config = {
        sops.secrets = {
          "password/dsn" = {
            sopsFile = sopsFile;
            neededForUsers = true;
          };
          "password/root" = {
            sopsFile = sopsFile;
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
    };
}
