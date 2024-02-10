{ config, ... }: {

  networking.firewall.allowedTCPPorts = [ 3000 ];

  sops.secrets = {
    "postgres-gitea-db-pass" = { owner = config.services.gitea.user; };
  };

  services.postgresql = {
    ensureDatabases = [ config.services.gitea.user ];
    ensureUsers = [{
      name = config.services.gitea.database.user;
      ensureDBOwnership = true;
    }];
  };

  services.gitea = {
    enable = true;
    database = {
      type = "postgres";
      host = "/run/postgresql";
      port = 5432;
      passwordFile = config.sops.secrets."postgres-gitea-db-pass".path;
    };

    settings = {
      log.LEVEL = "Info";
      session.COOKIE_SECURE = true;
      service = { DISABLE_REGISTRATION = true; };
      server = {
        DOMAIN = "gitea.dsnn.io";
        HTTP_ADDR =
          "192.168.2.2"; # required. 127.0.0.1 doesn't work for some reason
        HTTP_PORT = 3000;
        ROOT_URL = "https://gitea.dsnn.io/";
      };
    };
  };

  services.nginx.virtualHosts."gitea.dsnn.io" = {
    locations."/".proxyPass = "http://127.0.0.1:3000";

    # extraConfig = ''
    #   # recommended HTTP headers according to https://securityheaders.io
    #   # NOTE: Gitea already does X-Frame-Options, so we don't need to
    #   add_header Strict-Transport-Security "max-age=15768000; includeSubDomains" always; # six months
    #   add_header X-XSS-Protection "1; mode=block" always;
    #   add_header X-Content-Type-Options "nosniff" always;
    #   add_header Referrer-Policy "no-referrer" always;
    #   add_header Feature-Policy "accelerometer 'none', ambient-light-sensor 'none', autoplay 'none', camera 'none', document-domain 'none', encrypted-media 'none', fullscreen 'none', geolocation 'none', gyroscope 'none', magnetometer 'none', microphone 'none', midi 'none', payment 'none', picture-in-picture 'none', sync-xhr 'none', usb 'none', vibrate 'none', vr 'none'" always;
    #   add_header Content-Security-Policy "default-src 'self' data:; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'" always; # Gitea uses inline CSS (ok), inline fonts via data: (well...) and inline JS (shame on you)
    #
    #   # hamper Google surveillance
    #   add_header Permissions-Policy "interest-cohort=()" always;
    # '';
  };
}
