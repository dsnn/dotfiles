{
  imports = [
    ./autocommands.nix
    ./colorscheme.nix
    ./keymaps.nix
    ./options.nix
    ./plugins
  ];

  globals = {
    mapleader = ",";
    maplocalleader = " ";
  };
}
