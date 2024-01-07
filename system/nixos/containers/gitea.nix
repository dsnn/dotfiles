{ ... }: {

  services.nginx.virtualHosts."git.dsnn.io" = {
    # useACME = "dsnn.io";
    # forceSSL = true;
    locations."/".extraConfig = ''
      proxy_pass http://localhost:3000;
    '';
  };

  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    gitea = {
      autoStart = true;
      image = "gitea/gitea:latest";
      environment = {
        USER_UID = "1000";
        USER_GID = "1000";
      };
      volumes = [
        "/home/dsn/containers/gitea:/data"
        "/etc/timezone:/etc/timezone:ro"
        "/etc/localtime:/etc/localtime:ro"
      ];
      ports = [ "3000:3000" "222:22" ];
    };
  };
}
