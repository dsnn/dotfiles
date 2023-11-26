{ pkgs, ...}: {

    # TODO: https://github.com/catppuccin/bat
    # https://github.com/nix-community/home-manager/blob/master/modules/programs/bat.nix

    programs.bat.enable = true;
    programs.bat.config.theme = "TwoDark";

  programs.zsh.shellAliases = {
    cat = "bat";
  };
}
