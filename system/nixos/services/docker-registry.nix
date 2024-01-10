{ config, ... }: {

  networking.firewall.allowedTCPPorts = [ 5000 ];

  sops.secrets = {
    "docker-registry-http-secret" = { owner = "docker-registry"; };
  };

  services.dockerRegistry = {
    enable = true;
    listenAddress = "192.168.2.2";
    port = 5000;
    enableDelete = true;
    enableGarbageCollect = true;
    garbageCollectDates = "daily";
    extraConfig = {
      http.secret = config.sops.secrets."docker-registry-http-secret".path;
    };
    # enableRedisCache
    # redisUrl
    # redisPassword
  };

  services.nginx.virtualHosts."registry.dsnn.io" = let
    httpAddress = config.services.dockerRegistry.listenAddress;
    httpPort = config.services.dockerRegistry.port;
  in {
    locations."/".proxyPass = "http://${httpAddress}:${toString httpPort}";

    # extraConfig = ''
    #   if ($http_user_agent ~ "^(docker\/1\.(3|4|5(?!\.[0-9]-dev))|Go ).*$" ) {
    #     return 404;
    #   }
    #   proxy_set_header  Host              $http_host;   # required for docker client's sake
    #   proxy_set_header  X-Real-IP         $remote_addr; # pass on real client's IP
    #   proxy_set_header  X-Forwarded-For   $proxy_add_x_forwarded_for;
    #   proxy_set_header  X-Forwarded-Proto $scheme;
    #   proxy_read_timeout                  900;
    # '';
  };

}
