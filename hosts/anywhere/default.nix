{ myvars, mylib, ... }@args:
let
  host = myvars.networking.hostsAddr.cloud;
  myargs = args // {
    inherit host;
  };
in
{
  nixos.${host.name} = mylib.nixosSystem myargs; # nixos-anywhere
}
