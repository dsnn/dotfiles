{ myvars, mylib, ... }@args:
let
  host = myvars.hosts.hostsAddr.iso;
  myargs = args // {
    inherit host;
  };
in
{
  generate.${host.name} = mylib.generateSystem myargs;
}
