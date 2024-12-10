{ myvars, mylib, ... }@args:
let
  host = myvars.networking.hostsAddr.iso;
  myargs = args // {
    inherit host;
  };
in
{
  generate.${host.name} = mylib.generateSystem myargs;
}
