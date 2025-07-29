{ config, lib, ... }:
with lib;
let
  cfg = config.dsn.lsd;
in
{

  options.dsn.lsd = {
    enable = mkEnableOption "Enable lsd";
  };

  config = mkIf cfg.enable {

    programs = {
      lsd = {
        enable = true;
        settings = {
          date = "+%Y-%m-%d %H:%m:%S";
        };
      };
      zsh = {
        shellAliases = {
          l = "lsd -lA --group-dirs=first";
          # ls = "lsd -lA --group-dirs=first";
          lso = "lsd -lA --group-dirs=first --permission=octal";
          # la = "lsd -la";
          lst = "lsd -lAt";
          # lt = "lsd --tree";
          ltr = "lsd -lA --tree";
          lls = "lsd -lA --total-size";
        };
      };
    };
  };
}
