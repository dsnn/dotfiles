{ myvars, mylib, ... }@args:
let
  host = myvars.hosts.hostsAddr.anywhere;
  myargs = args // {
    inherit host;
  };
in
{
  nixos.${host.name} = mylib.nixosSystem myargs; # nixos-anywhere
}
