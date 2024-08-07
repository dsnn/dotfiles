{ ... }: {
  services.k3s = {
    enable = true;
    role = "server";
    token = "<randomized common secret>";
    clusterInit = true;
  };
}
