{ myvars, mylib, ... }@args:
let
  host = myvars.networking.hostsAddr.silver;
  myargs = args // { inherit host; };
in {
  home.${host.name} = mylib.homeConfig myargs;
  darwin.${host.name} = mylib.darwinSystem myargs;
}
