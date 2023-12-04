{ pkgs, ... }: {

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  # security.acme = {
  #   acceptTerms = true;
  #   email = "letsencrypt@example.com";
  #   certs = {
  #     "git.my-domain.tld".email = "foo@bar.com";
  #     "drone.my-domain.tld".email = "foo@bar.com";
  #   };
  # };

  services.postgresql = { enable = true; };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    storageDriver = "zfs";
  };

  systemd = {
    timers.docker-prune = {
      wantedBy = [ "timers.target" ];
      partOf = [ "docker-prune.service" ];
      timerConfig.OnCalendar = "*-*-* 2:00:00";
    };
    services.docker-prune = {
      serviceConfig.Type = "oneshot";
      script = ''
        ${pkgs.docker}/bin/docker image prune --filter "until=72h"
      '';
      requires = [ "docker.service" ];
    };
  };
}
