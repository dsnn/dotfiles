{
  lib,
  runCommand,
  nixosOptionsDoc,
  inputs,
  pkgs,
  ...
}:
let
  inherit (pkgs.lib) hasPrefix removePrefix;

  eval = lib.evalModules {
    specialArgs = {
      inherit pkgs inputs;
    };
    modules = [
      ../modules/nixos
      (_: { _module.check = false; })
    ];
  };

  optionsDoc = nixosOptionsDoc {
    inherit (eval) options;
    transformOptions =
      opt:
      opt
      // {
        # Clean up declaration sites to not refer to the NixOS source tree.
        declarations = map (
          decl:
          if hasPrefix (toString ../../..) (toString decl) then
            let
              subpath = removePrefix "/" (removePrefix (toString ../../..) (toString decl));
            in
            {
              url = "https://github.com/dsnn/dotfiles/blob/master/${subpath}";
              name = subpath;
            }
          else
            decl
        ) opt.declarations;
      };
    # transformOptions =
    #   opt:
    #   opt
    #   // {
    #     declarations = map (
    #       decl:
    #       let
    #         subpath = removePrefix "/" (removePrefix (toString ./..) (toString decl));
    #       in
    #       {
    #         url = "https://github.com/dsnn/dotfiles/blob/master/${subpath}";
    #         name = subpath;
    #       }
    #     ) opt.declarations;
    #   };
  };
in
runCommand "options-doc.md" { } ''
  cat ${optionsDoc.optionsCommonMark} >> $out
''
