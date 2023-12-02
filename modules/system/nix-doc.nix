{ pkgs, ... }: {

  # Does not work? crashes when buildning...
  # https://github.com/lf-/nix-doc/issues

  nix.extraOptions = ''
    plugin-files = ${pkgs.nix-doc}/lib/libnix_doc_plugin.so
  '';

  environment.systemPackages = with pkgs; [ nix-doc ];
}
