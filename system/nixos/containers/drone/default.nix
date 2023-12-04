{ ... }: {
  imports = [ ./server.nix ./exec-runner.nix ./docker-runner.nix ];
  sops.secrets.drone = { };
}
