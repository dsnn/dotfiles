{ inputs, ... }: {

  load-home-modules = builtins.readFile./modules/home/default.nix;
  load-system-modules = builtins.readFile./modules/system/default.nix;
}

