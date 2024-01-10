{ pkgs, lib, ... }:
let
  vhostOptions = { config, ... }: {
    options = {
      enableAuthelia = lib.mkEnableOption "Enable authelia location";
    };
    config = lib.mkIf config.enableAuthelia {
      locations."/authelia".extraConfig = ''
        # PUT WHATEVER CONFIGURATION YOU WANT, HERE
        internal;
        set $upstream_authelia http://127.0.0.1:9091/api/verify;
        proxy_pass_request_body off;
        proxy_pass $upstream_authelia;
        proxy_set_header Content-Length "";

        # Timeout if the real server is dead
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503;

        # [REQUIRED] Needed by Authelia to check authorizations of the resource.
        # Provide either X-Original-URL and X-Forwarded-Proto or
        # X-Forwarded-Proto, X-Forwarded-Host and X-Forwarded-Uri or both.
        # Those headers will be used by Authelia to deduce the target url of the     user.
        # Basic Proxy Config
        client_body_buffer_size 128k;
        proxy_set_header Host $host;
        proxy_set_header X-Original-URL $scheme://$http_host$request_uri;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        proxy_set_header X-Forwarded-Uri $request_uri;
        proxy_set_header X-Forwarded-Ssl on;
        proxy_redirect  http://  $scheme://;
        proxy_http_version 1.1;
        proxy_set_header Connection "";
        proxy_cache_bypass $cookie_session;
        proxy_no_cache $cookie_session;
        proxy_buffers 4 32k;

        # Advanced Proxy Config
        send_timeout 5m;
        proxy_read_timeout 240;
        proxy_send_timeout 240;
        proxy_connect_timeout 240;
      '';
    };
  };
in {
  # https://discourse.nixos.org/t/authelia-and-nginx-on-nixos/30601
  # TODO: https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/security/authelia.nix
  # TODO: https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/web-servers/traefik.nix

  # Example:
  # services.nginx.virtualHosts."auth.example.com" = {
  #   ...
  #   enableAuthelia = true;
  #   ...
  # };
  options.services.nginx.virtualHosts = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule vhostOptions);
  };

  systemd.services.authelia-main.preStart = ''
    [ -f /var/lib/authelia-main/jwt-secret ] || {
      "${pkgs.openssl}/bin/openssl" rand -base64 32 > /var/lib/authelia-main/jwt-secret
    }
    [ -f /var/lib/authelia-main/storage-encryption-file ] || {
      "${pkgs.openssl}/bin/openssl" rand -base64 32 > /var/lib/authelia-main/storage-encryption-file
    }
    [ -f /var/lib/authelia-main/session-secret-file ] || {
      "${pkgs.openssl}/bin/openssl" rand -base64 32 > /var/lib/authelia-main/session-secret-file
    }
  '';

  services.authelia.instances.main = {
    enable = true;
    # secrets = {
    #   jwtSecretFile = "${pkgs.writeText "jwtSecretFile" "supersecretkey"}";
    #
    #   storageEncryptionKeyFile =
    #     "${pkgs.writeText "storageEncryptionKeyFile" "supersecretkey"}";
    #
    #   sessionSecretFile =
    #     "${pkgs.writeText "sessionSecretFile" "supersecretkey"}";
    # };
    secrets = {
      jwtSecretFile = "/var/lib/authelia-main/jwt-secret";
      storageEncryptionKeyFile =
        "/var/lib/authelia-main/storage-encryption-file";
      sessionSecretFile = "/var/lib/authelia-main/session-secret-file";
    };
    settings = {
      theme = "dark";
      default_redirection_url = "https://example.com";

      server = {
        host = "127.0.0.1";
        port = 9091;
      };

      log = {
        level = "debug";
        format = "text";
      };

      authentication_backend = {
        file = { path = "/var/lib/authelia-main/users_database.yml"; };
      };

      access_control = {
        default_policy = "deny";
        rules = [
          {
            domain = [ "auth.example.com" ];
            policy = "bypass";
          }
          {
            domain = [ "*.example.com" ];
            policy = "one_factor";
          }
        ];
      };

      session = {
        name = "authelia_session";
        expiration = "12h";
        inactivity = "45m";
        remember_me_duration = "1M";
        domain = "example.com";
        redis.host = "/run/redis-authelia-main/redis.sock";
      };

      regulation = {
        max_retries = 3;
        find_time = "5m";
        ban_time = "15m";
      };

      storage = { local = { path = "/var/lib/authelia-main/db.sqlite3"; }; };

      notifier = {
        disable_startup_check = false;
        filesystem = { filename = "/var/lib/authelia-main/notification.txt"; };
      };
    };
  };

  services.redis.servers.authelia-main = {
    enable = true;
    user = "authelia-main";
    port = 0;
    unixSocket = "/run/redis-authelia-main/redis.sock";
    unixSocketPerm = 600;
  };

  services.nginx.virtualHosts."auth.example.com" = {
    enableACME = true;
    forceSSL = true;
    acmeRoot = null;

    locations."/" = {
      proxyPass = "http://127.0.0.1:9091";
      proxyWebsockets = true;
    };
  };

}

