{
  colmena = {
    # srv-nixos-01 = {
    #   name = "";
    #   ip = "192.168.2.111";
    #   modules = [ ../hosts/srv-nixos-01 ];
    # };
    k3smaster01 = {
      name = "srv-k3s-01";
      ip = "192.168.2.121";
      modules = [ ../hosts/k3s/master ];
    };
    # k3sagent01 = {
    #   name = "srv-k3s-agent-01";
    #   ip = "192.168.2.122";
    #   modules = [ ../hosts/k3s/agent ];
    # };
    # k3sagent02 = {
    #   name = "srv-k3s-agent-01";
    #   ip = "192.168.2.123";
    #   modules = [ ../hosts/k3s/agent ];
    # };
  };
}
