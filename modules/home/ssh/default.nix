{config, pkgs, ...} : {

  programs.ssh.enable = true;
  programs.ssh.includes = [ "/Users/dsn/.ssh/config.d/*" ];
  programs.ssh.forwardAgent = true;
  programs.ssh.extraConfig = ''
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  '';

  home.file."/Users/dsn/.ssh/config.d/sshconfig.secrets".source = ../../../secrets/sshconfig.secrets;
}
