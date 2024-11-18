{ myvars, mylib, ... }@args:
let
  host = myvars.networking.hostsAddr.monit;
  myargs = args // {
    inherit host;
  };
in
{
  colmena.${host.name} = mylib.colmenaSystem myargs;
}
