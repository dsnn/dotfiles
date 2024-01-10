{ config, ... }:
let flame = config.users.users.flame.name;
in {

  # sops.secrets = { "flame" = { owner = flame; }; };

  users.users.flame = {
    isSystemUser = true;
    group = flame;
  };
  users.groups.flame = { };

  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    flame = {
      autoStart = true;
      image = "pawelmalak/flame";
      # environmentFiles = [ config.sops.secrets.flame.path ];
      environment = { PASSWORD = "test"; };
      extraOptions = [ "--network=host" ];
      volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ];
      ports = [ "5005:5005" ];
    };
  };
}
