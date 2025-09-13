{ ... }:
let
  timeZone = "Europe/Stockholm";
in
{
  flake.modules = {
    nixos.time.time = { inherit timeZone; };
    darwin.time.time = { inherit timeZone; };
  };
}
