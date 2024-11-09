{ ... }:
{
  # imports = scanPaths ./.;
  imports = [
    ./auto-upgrade.nix
    ./awesomewm
    ./cifs.nix
    ./i18n.nix
    ./nix.nix
    ./packages.nix
    ./security.nix
    ./service-avahi.nix
    ./service-cups.nix
    ./service-docker-registry.nix
    ./service-fail2ban.nix
    ./service-gitea.nix
    ./service-homepage-dashboard.nix
    ./service-jellyfin.nix
    ./service-k3s-agent.nix
    ./service-k3s-srv.nix
    ./service-nginx.nix
    ./service-openssh.nix
    ./service-postgres.nix
    ./service-prometheus.nix
    ./service-traefik.nix
    ./shells.nix
    ./sops.nix
    ./users.nix
    ./virtualisation.nix
    ./wireguard.nix
    ./zram.nix
  ];
}
