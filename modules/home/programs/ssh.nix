{ config, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
  linux-extra-config = ''
    IdentityAgent ~/.1password/agent.sock
  '';
  darwin-extra-config = ''
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  '';
in {

  programs.ssh.enable = true;
  programs.ssh.includes = [ "${config.home.homeDirectory}/.ssh/config.d/*" ];
  programs.ssh.forwardAgent = true;
  programs.ssh.extraConfig =
    if isDarwin then darwin-extra-config else linux-extra-config;

  sops.secrets.hosts = {
    sopsFile = ../../../secrets/ssh.yaml;
    path = "${config.home.homeDirectory}/.ssh/config.d/ssh-hosts-internal";
  };
}
