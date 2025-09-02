{
  flake.modules.homeManager.ssh =
    {
      config,
      pkgs,
      ...
    }:
    let
      inherit (pkgs.stdenv) isDarwin;
      linux-extra-config = ''
        IdentityAgent ~/.1password/agent.sock
      '';
      darwin-extra-config = ''
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      '';
      osSpecificConfig = if isDarwin then darwin-extra-config else linux-extra-config;
    in
    {

      # home.packages = with pkgs; [ ssh ];

      # todo: handle colima hosts config (.config/colima/..)

      programs.ssh = {
        enable = true;
        includes = [ "${config.home.homeDirectory}/.ssh/config.d/*" ];
        extraConfig = osSpecificConfig;
        enableDefaultConfig = false;
        matchBlocks = {
          "*" = {
            forwardAgent = true;
            addKeysToAgent = "true";
            compression = false;
            serverAliveInterval = 0;
            serverAliveCountMax = 3;
            hashKnownHosts = false;
            userKnownHostsFile = "~/.ssh/known_hosts";
            controlMaster = "no";
            controlPath = "~/.ssh/master-%r@%n:%p";
            controlPersist = "no";
          };
          "git" = {
            hostname = "github.com";
            port = 22;
            user = "git";
            forwardAgent = true;
          };
          "alpha" = {
            hostname = "192.168.2.2";
            port = 22;
            user = "root";
          };
          "omega" = {
            hostname = "192.168.2.3";
            port = 22;
            user = "root";
          };
          "nas" = {
            hostname = "192.168.3.2";
            port = 11223;
            user = "dsn";
          };
          "docker1" = {
            hostname = "192.168.2.110";
            port = 22;
            user = "dsn";
          };
          "docker2" = {
            hostname = "192.168.2.104";
            port = 22;
            user = "dsn";
          };
        };
      };
    };
}
