{ pkgs, ...}: {

  programs.zsh.shellAliases = {
    ds = "docker ps -a";
    di = "docker images";
    drm = ''docker rm $(docker ps -qa --no-trunc --filter "status=exited")'';
    drmi = "docker rmi $(docker images -q -f dangling=true)";
    # dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
  };
}
