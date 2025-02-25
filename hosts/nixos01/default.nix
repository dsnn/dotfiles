{ myvars, mylib, ... }@args:
let
  host = myvars.networking.hostsAddr.nixos01;
  myargs = args // {
    inherit host;
  };
in
{
  colmena.${host.name} = mylib.colmenaSystem myargs;
}
