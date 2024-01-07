{ pkgs, config, ... }:
let
  droneserver = config.users.users.droneserver.name;
  domain = "drone.dsnn.io";
in {

  networking.firewall.allowedTCPPorts = [ 3030 ];

  sops.secrets = { "drone" = { owner = droneserver; }; };

  users.users.droneserver = {
    isSystemUser = true;
    createHome = true;
    group = droneserver;
  };
  users.groups.droneserver = { };

  services.postgresql = {
    ensureDatabases = [ droneserver ];
    ensureUsers = [{
      name = droneserver;
      ensureDBOwnership = true;
    }];
  };

  systemd.services.drone-server = {
    wantedBy = [ "multi-user.target" ];
    script = ''
      ${pkgs.drone}/bin/drone-server
    '';
    serviceConfig = {
      EnvironmentFile = [ config.sops.secrets.drone.path ];
      Environment = [
        "DRONE_DATABASE_DATASOURCE=postgres:///droneserver?host=/run/postgresql"
        "DRONE_DATABASE_DRIVER=postgres"
        "DRONE_SERVER_PORT=:3030"
        "DRONE_SERVER_HOST=drone.dsnn.io"
        "DRONE_SERVER_PROTO=https"
      ];
      User = droneserver;
      Group = droneserver;
    };
  };

  services.nginx.virtualHosts.${domain} = {
    locations."/".proxyPass = "http://127.0.0.1:3030";

    extraConfig = ''
      # recommended HTTP headers according to https://securityheaders.io
      # NOTE: Gitea already does X-Frame-Options, so we don't need to
      add_header Strict-Transport-Security "max-age=15768000; includeSubDomains" always; # six months
      add_header X-XSS-Protection "1; mode=block" always;
      add_header X-Content-Type-Options "nosniff" always;
      add_header Referrer-Policy "no-referrer" always;
      add_header Feature-Policy "accelerometer 'none', ambient-light-sensor 'none', autoplay 'none', camera 'none', document-domain 'none', encrypted-media 'none', fullscreen 'none', geolocation 'none', gyroscope 'none', magnetometer 'none', microphone 'none', midi 'none', payment 'none', picture-in-picture 'none', sync-xhr 'none', usb 'none', vibrate 'none', vr 'none'" always;
      add_header Content-Security-Policy "default-src 'self' data:; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'" always; # Gitea uses inline CSS (ok), inline fonts via data: (well...) and inline JS (shame on you)

      # hamper Google surveillance
      add_header Permissions-Policy "interest-cohort=()" always;
    '';
  };
}
