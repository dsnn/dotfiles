{ lib, runCommand, nixosOptionsDoc, pkgs, ... }:
let
  inherit (pkgs.lib) removePrefix;

  eval = lib.evalModules {
    check = false;
    modules = [ ../modules/common.nix ];
  };

  optionsDoc = nixosOptionsDoc {
    inherit (eval) options;
    transformOptions = opt:
      opt // {
        declarations = map (decl:
          let
            subpath =
              removePrefix "/" (removePrefix (toString ./..) (toString decl));
          in {
            url = "https://github.com/dsnn/dotfiles/blob/master/${subpath}";
            name = subpath;
          }) opt.declarations;
      };
  };
in runCommand "options-doc.md" { } ''
  cat ${optionsDoc.optionsCommonMark} >> $out
''
