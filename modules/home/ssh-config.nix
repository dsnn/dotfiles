{
  config,
  pkgs,
  lib,
  myvars,
  mylib,
  ...
}:
with lib;
let
  cfg = config.dsn.ssh;
  inherit (pkgs.stdenv) isDarwin;
  inherit (mylib) generateSshHosts;
  inherit (myvars.hosts) hostsAddr sshHosts;
  linux-extra-config = ''
    IdentityAgent ~/.1password/agent.sock
  '';
  darwin-extra-config = ''
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  '';
  osSpecificConfig = if isDarwin then darwin-extra-config else linux-extra-config;
  allHosts = hostsAddr // sshHosts;
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
        (generateSshHosts allHosts)
      ];
    };

    sops.secrets.hosts = {
      sopsFile = ../../secrets/ssh.yaml;
      path = "${config.home.homeDirectory}/.ssh/config.d/private-ssh-hosts";
    };
  };
}
