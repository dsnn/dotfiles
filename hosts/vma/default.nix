{ myvars, mylib, ... }@args:
let
  host = myvars.networking.hostsAddr.vma;
  myargs = args // {
    inherit host;
  };
in
{
  generate.${host.name} = mylib.generateSystem myargs;
}
