{ ... }: {
  imports = [
    ./docker-registry.nix
    ./drone-runner-docker.nix
    # ./drone-runner-exec.nix # binds to port 3000 by defeault. Change port for gitea (at port 3000 atm) ?
    ./drone-srv.nix
    ./gitea.nix
    ../nginx.nix
    ../postgres.nix
    ../virtualisation.nix
  ];
}
