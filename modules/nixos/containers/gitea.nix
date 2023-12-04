{ ... }: {

  services.nginx.virtualHosts."git.dsnn.io" = {
    # useACMEHost = "dsnn.io";
    # forceSSL = true;
    locations."/".extraConfig = ''
      proxy_pass http://localhost:3002;
    '';
  };

  services.gitea = {
    enable = true;
    database = {
      type = "postgres";
      host = "/run/postgresql";
      port = 5432;
    };
    # mailerPasswordFile = config.sops.secrets.gitea-mail.path;
    # settings.mailer = {
    #   ENABLED = true;
    #   FROM = "gitea@thalheim.io";
    #   USER = "gitea@thalheim.io";
    #   HOST = "mail.thalheim.io:587";
    # };
    settings.log.LEVEL = "Error";
    settings.service.DISABLE_REGISTRATION = true;
    settings.metrics.ENABLED = true;
    settings.server = {
      DISABLE_ROUTER_LOG = true;
      ROOT_URL = "https://git.dsnn.io";
      HTTP_PORT = 3002;
      DOMAIN = "dsnn.io";
    };
  };

  # virtualisation.oci-containers.backend = "docker";
  # virtualisation.oci-containers.containers = {
  #   gitea = {
  #     autoStart = true;
  #     image = "gitea/gitea:latest";
  #     environment = {
  #       USER_UID = "1000";
  #       USER_GID = "1000";
  #     };
  #     volumes = [
  #       "/home/dsn/containers/gitea:/data"
  #       "/etc/timezone:/etc/timezone:ro"
  #       "/etc/localtime:/etc/localtime:ro"
  #     ];
  #     ports = [ "3000:3000" "222:22" ];
  #   };
  # };
}
