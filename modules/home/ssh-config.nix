{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.dsn.ssh;
  inherit (pkgs.stdenv) isDarwin;

  generateSshHosts =
    hosts:
    lib.attrsets.foldlAttrs (
      acc: host: val:
      let
        user = lib.attrByPath [ "user" ] "dsn" val;
        port = lib.attrByPath [ "port" ] 22 val;
      in
      acc
      + ''
        Host ${host}
          HostName ${val.ip}
          Port ${toString port}
          User ${user}

      ''
    ) "" (lib.attrsets.filterAttrs (_: v: v ? ip) hosts);

  sshHosts = {
    "git" = {
      ip = "github.com";
      port = 22;
      user = "git";
      forwardAgent = "True";
    };
    "alpha" = {
      ip = "192.168.2.2";
      port = 22;
      user = "root";
    };
    "omega" = {
      ip = "192.168.2.3";
      port = 22;
      user = "root";
    };
    "nas" = {
      ip = "192.168.3.2";
      port = 11223;
      user = "dsn";
    };
    "docker1" = {
      ip = "192.168.2.110";
      port = 22;
      user = "dsn";
    };
    "docker2" = {
      ip = "192.168.2.104";
      port = 22;
      user = "dsn";
    };
  };
  linux-extra-config = ''
    IdentityAgent ~/.1password/agent.sock
  '';
  darwin-extra-config = ''
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  '';
  osSpecificConfig = if isDarwin then darwin-extra-config else linux-extra-config;
in
{

  options.dsn.ssh = {
    enable = mkEnableOption "Enable ssh";
  };

  config = mkIf cfg.enable {

    programs.ssh = {
      enable = true;
      includes = [ "${config.home.homeDirectory}/.ssh/config.d/*" ];
      forwardAgent = true;
      extraConfig = lib.strings.concatStrings [
        osSpecificConfig
        "\n"
        (generateSshHosts sshHosts)
      ];
    };
  };
}
