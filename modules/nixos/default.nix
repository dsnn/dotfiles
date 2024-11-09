{ ... }:
{
  # imports = scanPaths ./.;
  imports = [
    ./auto-upgrade.nix
    ./avahi.nix
    ./awesomewm
    ./cifs.nix
    ./cups.nix
    ./docker-registry.nix
    ./fail2ban.nix
    ./gitea.nix
    ./homepage-dashboard.nix
    ./i18n.nix
    ./jellyfin.nix
    ./k3s-agent.nix
    ./k3s-srv.nix
    ./nginx.nix
    ./nix.nix
    ./packages.nix
    ./postgres.nix
    ./prometheus.nix
    ./security.nix
    ./shells.nix
    ./sops.nix
    ./openssh.nix
    ./traefik.nix
    ./users.nix
    ./virtualisation.nix
    ./wireguard.nix
    ./zram.nix
  ];
}
