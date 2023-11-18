let
  dsn = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB";
  users = [ dsn ];
in
{
  "secret1.age".publicKeys = [ dsn ];
}
