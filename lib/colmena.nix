{
  inputs,
  unstable,
  myvars,
  ...
}:
let
  inherit (myvars) system sopsOptions;
  inherit (sopsOptions) keyName keyPath;
in
{
  defaults =
    { ... }:
    {
      imports = [
        inputs.disko.nixosModules.disko
        ../modules/sets/common.nix
        ../modules/nixos
      ];

      deployment = {
        keys = {
          "sops-key" = {
            name = keyName;
            keyFile = "${keyPath}/${keyName}";
            destDir = keyPath;
            user = "dsn";
          };
        };
      };
    };

  meta = {
    nixpkgs = import inputs.nixpkgs {
      system = system.x86_64-linux;
      overlays = [ ];
    };
    specialArgs = {
      unstable = unstable system.x86_64-linux;
      inherit inputs myvars;
    };
  };

  mkDeployment =
    host:
    { ... }:
    let
      inherit (host)
        name
        ip
        modules
        tags
        ;
    in
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ] ++ modules;

      deployment = {
        inherit tags;
        targetHost = ip;
        targetUser = myvars.username;
      };

      nixpkgs.config.allowUnfree = true;

      programs.zsh.enable = true;

      boot.isContainer = true;

      services = {
        qemuGuest.enable = true;
        openssh.enable = true;
      };

      security.sudo.wheelNeedsPassword = false;

      nix.settings.trusted-users = [ "dsn" ];

      networking = {
        usePredictableInterfaceNames = false;
        hostName = name;
        enableIPv6 = false;
        interfaces.eth0.ipv4.addresses = [
          {
            address = ip;
            prefixLength = 24;
          }
        ];
      };

      system = {
        stateVersion = "24.05";
      };

      home-manager = {
        # saves extra eval, consistency and rm dep on NIX_PATH
        useGlobalPkgs = true;
        useUserPackages = true;

        extraSpecialArgs = {
          unstable = unstable system.x86_64-linux;
          inherit inputs myvars;
        };

        sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];

        users.dsn.imports = [
          ../profiles/dsn-small.nix
          ../modules/home/default-sys-module.nix
        ];
      };
    };

}
