{ myvars, mylib, ... }@args:
let
  host = myvars.networking.hostsAddr.silver;
  myargs = args // {
    inherit host;
  };
in
{
  darwin.${host.name} = mylib.darwinSystem myargs;
}
