{ ... }: {
  # security.acme = {
  #   acceptTerms = true;
  #   email = "letsencrypt@example.com";
  #   certs = {
  #     "git.my-domain.tld".email = "foo@bar.com";
  #     "drone.my-domain.tld".email = "foo@bar.com";
  #   };
  # };

  # sudo.configFile = ''
  #   Defaults lecture=always
  #   Defaults lecture_file=${misc/groot.txt}
  # '';

  # TODO: Remove later.
  # Temp / testing workaround for remote deploy.
  # Insecure and not recommended
  security.sudo.extraRules = [{
    users = [ "dsn" ];
    commands = [{
      command = "ALL";
      options =
        [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
    }];
  }];

  # TODO: Review and try this later
  # security.sudo.extraRules = let
  #   storePrefix = "/nix/store/*";
  #   systemName = "nixos-system-${config.networking.hostName}-*";
  # in [
  #   {
  #     commands = [{
  #       command =
  #         "${storePrefix}-nix-*/bin/nix-env -p /nix/var/nix/profiles/system --set ${storePrefix}-${systemName}";
  #       options = [ "NOPASSWD" ];
  #     }];
  #     groups = [ "wheel" ];
  #   }
  #   {
  #     commands = [{
  #       command = "${storePrefix}-${systemName}/bin/switch-to-configuration";
  #       options = [ "NOPASSWD" ];
  #     }];
  #     groups = [ "wheel" ];
  #   }
  # ];

}
