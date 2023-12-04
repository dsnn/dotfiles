{ pkgs, config, ... }: {

  # TODO: https://github.com/catppuccin/polybar

  home.packages = with pkgs; [ polybarFull gsimplecal ];

  home.file."${config.home.homeDirectory}/.config/polybar".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/modules/home/i3/polybar";

  xsession.windowManager.i3.config.startup = [{
    command = "/home/dsn/.config/polybar/launch.sh";
    always = true;
    notification = false;
  }];
}
