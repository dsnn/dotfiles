{ ... }: {

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 3000 2222 ];
    # allowedUDPPortRanges = [
    #   {
    #     from = 4000;
    #     to = 4007;
    #   }
    #   {
    #     from = 8000;
    #     to = 8010;
    #   }
    # ];
  };

}
