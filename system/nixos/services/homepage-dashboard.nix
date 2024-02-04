{ ... }: {
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = 8082;
  };

  # systemd.services.homepage-dashboard.environment.HOMEPAGE_CONFIG_DIR
  #   = lib.mkForce “/whatever/path/you/want”;
}
