{ myvars, mylib, ... }@args:
let
  host = myvars.networking.hostsAddr.k3s;
  myargs = args // {
    inherit host;
  };
in
{
  nixos.${host.name} = mylib.nixosSystem myargs; # nixos-anywhere

  colmena.${host.name} = mylib.colmenaSystem myargs;
}
