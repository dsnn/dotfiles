{ myvars, mylib, ... }@args:
let
  host = myvars.networking.hostsAddr.raw;
  myargs = args // {
    inherit host;
  };
in
{
  nixos.${host.name} = mylib.nixosSystem myargs;
}
