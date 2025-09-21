{ inputs, ... }:
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
        defaultSopsFile = "${inputs.nix-secrets}/secrets/secrets.yaml";
        validateSopsFiles = true;
      };
    };

  flake.modules.darwin.sops =
    { config, ... }:
    {
      imports = [
        inputs.sops-nix.darwinModules.sops
      ];

      sops.age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      sops.age.sshKeyPaths = [ ];
    };

  flake.modules.nixos.sops =
    { config, ... }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      sops.age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      sops.age.sshKeyPaths = [ ];
    };
}
