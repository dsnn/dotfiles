{ ... }: {
  imports = [
    ./avahi.nix
    ./cifs.nix
    ./cups.nix
    ./fail2ban.nix
    ./homepage-dashboard.nix
    ./jellyfin.nix
    ./k3s-node.nix
    ./k3s-srv.nix
    ./nginx.nix
    ./openssh.nix
    ./postgres.nix
    ./security.nix
    ./system.nix
    ./traefik.nix
    ./users.nix
    ./virtualisation.nix
    ./wireguard.nix
    ./cicd
    ./awesomewm
  ];
}
