{ myvars, mylib, ... }@args:
let
  host = myvars.hosts.hostsAddr.dev;
  myargs = args // {
    inherit host;
  };
in
{
  home.${host.name} = mylib.homeConfig myargs;

  nixos.${host.name} = mylib.nixosSystem myargs;
}
