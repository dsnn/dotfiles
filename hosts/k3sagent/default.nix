{ myvars, mylib, ... }@args:
let
  host = myvars.networking.hostsAddr.k3sagent01;
  myargs = args // {
    inherit host;
  };
in
{
  colmena.${host.name} = mylib.colmenaSystem myargs;
}
