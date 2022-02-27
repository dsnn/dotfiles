{

  # for more options, e.g. permissions: https://github.com/Mic92/sops-nix#deploy-example
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.age.keyFile = "/home/dsn/.config/sops/age/keys.txt";
}
