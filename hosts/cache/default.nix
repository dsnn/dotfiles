{
  modulesPath,
  config,
  inputs,
  ...
}:
{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    inputs.home-manager.nixosModules.home-manager
  ];

  sops.secrets."cache-private-key" = {
    sopsFile = ../../secrets/cache.yaml;
  };

  dsn = {
    # common.enable = true;
    openssh.enable = true;
    user.enable = true;
    sops.enable = true;
    prometheus.enable = true;
  };

  # TODO: HTTPS - https://nix.dev/tutorials/nixos/binary-cache-setup.html#serving-the-binary-cache-via-https

  services.nix-serve = {
    enable = true;
    # e.g. "/var/secrets/cache-private-key.pem";
    secretKeyFile = config.sops.secrets."cache-private-key".path;
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts.cache = {
      locations."/".proxyPass = "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
    };
  };

  networking.firewall.allowedTCPPorts = [ config.services.nginx.defaultHTTPListenPort ];
}
