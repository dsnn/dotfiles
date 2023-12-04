{ ... }: {
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      gitea = {
        autoStart = true;
        image = "gitea/gitea:latest";
        environment = {
          USER_UID = "1000";
          USER_GID = "1000";
        };
        volumes = [
          "/containers/gitea:/data"
          "/etc/timezone:/etc/timezone:ro"
          "/etc/localtime:/etc/localtime:ro"
        ];
        ports = [ "3000:3000" "222:22" ];
      };
    };
  };
}
