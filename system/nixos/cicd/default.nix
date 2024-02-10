{ ... }: {

  imports = [
    ./docker-registry.nix
    ./drone-runner-docker.nix
    ./drone-runner-exec.nix
    ./drone-srv.nix
    ./gitea.nix
    ../services/nginx.nix
    ../services/postgres.nix
    ../virtualisation.nix
  ];

}
