{ myvars, mylib, ... }@args:
let
  host = myvars.networking.hostsAddr.bind;
  myargs = args // {
    inherit host;
  };
in
{
  colmena.${host.name} = mylib.colmenaSystem myargs;
}
