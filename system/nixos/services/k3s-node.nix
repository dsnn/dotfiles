{ ... }: {
  services.k3s = {
    enable = true;
    role = "server";
    token = "<randomized common secret>";
    serverAddr = "https://<ip of first node>:6443";
  };
}
