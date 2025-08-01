{
  flake.modules.nixos.sops =
    { inputs, pkgs }:
    let
      inherit (pkgs.stdenv) isDarwin;
      home = if isDarwin then "/Users/dsn" else "/home/dsn";
    in
    {
      sops.age.keyFile = "${home}/.config/sops/age/keys.txt";
      sops.age.sshKeyPaths = [ ];
    };

  flake.modules.homeManager.sops =
    {
      inputs,
      config,
      pkgs,
    }:
    {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];

      home.packages = [ pkgs.sops ];
      sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    };
}
