{ myvars, mylib, ... }@args:
let
  host = myvars.hosts.hostsAddr.vma;
  myargs = args // {
    inherit host;
  };
in
{
  generate.${host.name} = mylib.generateSystem myargs;
}
