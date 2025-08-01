{ inputs }:
{
  flake.modules.home.sops =
    { config, pkgs }:
    {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];

      home.packages = [ pkgs.sops ];
      sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    };
}
