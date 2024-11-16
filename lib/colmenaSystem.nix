{
  inputs,
  myvars,
  host,
  ...
}:
let
  inherit (host) tags ip nixos-modules;
  defaultModules = [
    ../modules/sets/common.nix
    ../modules/nixos
  ];
in
{ ... }:
{
  imports = nixos-modules ++ defaultModules ++ [ inputs.home-manager.nixosModules.home-manager ];

  deployment = {
    tags = tags;
    targetHost = ip;
    targetUser = myvars.username;
    keys = myvars.deploymentKeys;
  };
}
