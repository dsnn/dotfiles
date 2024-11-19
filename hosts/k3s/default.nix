{ myvars, mylib, ... }@args:
let
  k3smaster01 = myvars.networking.hostsAddr.k3smaster01;
  k3sagent01 = myvars.networking.hostsAddr.k3sagent01;
  k3sagent02 = myvars.networking.hostsAddr.k3sagent02;
in
{
  colmena.${k3smaster01.name} = mylib.colmenaSystem args // {
    host = k3smaster01;
  };
  colmena.${k3sagent01.name} = mylib.colmenaSystem args // {
    host = k3sagent01;
  };
  colmena.${k3sagent02.name} = mylib.colmenaSystem args // {
    host = k3sagent02;
  };
}
