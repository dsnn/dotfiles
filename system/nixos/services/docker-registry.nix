{ config, ... }: {

  networking.firewall.allowedTCPPorts = [ 5000 ];

  sops.secrets = {
    "docker-registry-http-secret" = { owner = "docker-registry"; };
  };

  services.dockerRegistry = {
    enable = true;
    listenAddress = "127.0.0.1";
    port = 5000;
    enableDelete = true;
    enableGarbageCollect = true;
    garbageCollectDates = "daily";
    extraConfig = {
      http.secret = config.sops.secrets."docker-registry-http-secret".path;
    };
  };

  services.nginx.virtualHosts."registry.dsnn.io" = {
    locations."/".proxyPass = "http://127.0.0.1:5000";
  };
}
