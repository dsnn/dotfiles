{ myvars, mylib, ... }@args:
let
  host = myvars.hosts.hostsAddr.bind;
  myargs = args // {
    inherit host;
  };
in
{
  colmena.${host.name} = mylib.colmenaSystem myargs;
}
