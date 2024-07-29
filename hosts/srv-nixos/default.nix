{ pkgs, name, targetHost, ... }: {

  deployment = {
    targetHost = targetHost;
    targetPort = 22;
    targetUser = "root";
    tags = [ "cluster" ];
  };

  networking.hostName = name;

  programs.zsh.enable = true;

  users.users.dsn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };
}
