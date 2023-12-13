{ ... }: {

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    openFirewall = true;
    settings = {
      X11Forwarding = false;
      StrictModes = true;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
    # extraConfig = "\n";
  };
}
