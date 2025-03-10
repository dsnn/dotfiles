{ myvars, mylib, ... }@args:
let
  host = myvars.hosts.hostsAddr.k3s;
  myargs = args // {
    inherit host;
  };
in
{
  nixos.${host.name} = mylib.nixosSystem myargs; # nixos-anywhere

  colmena.${host.name} = mylib.colmenaSystem myargs;
}
