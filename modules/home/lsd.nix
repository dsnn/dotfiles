{ lib, config, ... }:
with lib;
let cfg = config.dotfiles.lsd;
in {
  options.dotfiles.lsd = {
    enable = mkEnableOption "Enable lsd";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    # https://github.com/nix-community/home-manager/blob/master/modules/programs/lsd.nix
    programs.lsd.enable = true;
    programs.lsd.settings = {
      date = "+%Y-%m-%d %H:%m:%S";
      # ignore-globs = [ ".git" ".hg" ];
    };

    # custom ls aliases
    programs.zsh.shellAliases = {
      l = "lsd -lA --group-dirs=first";
      ls = "lsd -lA --group-dirs=first";
      lso = "lsd -lA --group-dirs=first --permission=octal";
      la = "lsd -la";
      lst = "lsd -lAt";
      lt = "lsd --tree";
      ltr = "lsd -lA --tree";
      lls = "lsd -lA --total-size";
    };
  };
}
