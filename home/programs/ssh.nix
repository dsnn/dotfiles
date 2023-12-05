{ config, ... }: {
  programs.ssh.enable = true;
  programs.ssh.includes = [ "${config.home.homeDirectory}/.ssh/config.d/*" ];
  programs.ssh.forwardAgent = true;
  programs.ssh.extraConfig = ''
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  '';

  home.file."${config.home.homeDirectory}/.ssh/config.d/sshconfig.secrets".source =
    ../../home/secrets/sshconfig.secrets;
}
