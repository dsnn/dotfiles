{
  perSystem =
    {
      inputs,
      pkgs,
      system,
      ...
    }:
    {
      # packages.neovim = inputs.myflakes.packages.${system}.neovim;
    };
}
