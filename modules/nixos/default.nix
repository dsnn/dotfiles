{ ... }:
{
  imports = [
    ./avahi.nix
    ./awesomewm
    ./cicd
    ./cifs.nix
    ./cups.nix
    ./fail2ban.nix
    ./homepage-dashboard.nix
    ./jellyfin.nix
    ./k3s-agent.nix
    ./k3s-srv.nix
    ./nginx.nix
    ./openssh.nix
    ./postgres.nix
    ./prometheus.nix
    ./security.nix
    ./sops.nix
    ./system.nix
    ./traefik.nix
    ./users.nix
    ./virtualisation.nix
    ./wireguard.nix
  ];
}
