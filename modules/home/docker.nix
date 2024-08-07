{ config, lib, ... }:
with lib;
let cfg = config.dsn.docker;
in {

  options.dsn.docker = { enable = mkEnableOption "Enable docker"; };

  # TODO: move this as an option to zsh 

  config = mkIf cfg.enable {
    programs.zsh.shellAliases = {
      ds = "docker ps -a";
      di = "docker images";
      drm = ''docker rm $(docker ps -qa --no-trunc --filter "status=exited")'';
      drmi = "docker rmi $(docker images -q -f dangling=true)";
      # dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
    };
  };
}
