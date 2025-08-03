{
  flake.modules.homeManager.sops =
    {
      inputs,
      config,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.sops-nix.homeManagerModules.sops
      ];

      home.packages = [ pkgs.sops ];

      sops = {
        age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        age.sshKeyPaths = [ ];
        age.generateKey = false;
        defaultSopsFile = ./sops.yml;
        validateSopsFiles = true;

        # secrets = {
        #   "ssh/id_ed25519" = {
        #     format = "binary";
        #     sopsFile = ./secrets/silver;
        #   };
        #   "ssh/sops_ssh_config" = {
        #     format = "binary";
        #     sopsFile = ./secrets/sshconf;
        #   };
        # };
      };
    };

  flake.modules.darwin.sops =
    { config }:
    {
      sops.age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      sops.age.sshKeyPaths = [ ];
    };

  flake.modules.nixos.sops =
    { config }:
    {
      sops.age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      sops.age.sshKeyPaths = [ ];
    };
}
