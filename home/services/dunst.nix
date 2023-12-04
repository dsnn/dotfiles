{ config, pkgs, ... }: {

  # TODO: https://github.com/catppuccin/dunst

  services.dunst.enable = true;

  services.dunst.settings.global = {
    browser = "${config.programs.firefox.package}/bin/firefox -new-tab";
    dmenu = "${pkgs.rofi}/bin/rofi -dmenu";
    follow = "mouse";
    font = "Robot Nerd Font 11";
    # format = "<b>%s</b>\\n%b";
    format = "%s %p %b";
    sort = "yes";
    frame_color = "#263238";
    frame_width = 2;
    geometry = "500x5-5+30";
    horizontal_padding = 8;
    icon_position = "left";
    line_height = 0;
    markup = "full";
    padding = 8;
    separator_color = "frame";
    separator_height = 2;
    transparency = 10;
    word_wrap = true;
    # icon_path =
    #   "/home/dsn/.nix-profile/share/icons/Nordzy/status/16/:/home/dsn/.nix-profile/share/icons/Nordzy/devices/16/";
  };

  services.dunst.settings.urgency_low = {
    background = "#5E81AC";
    foreground = "#263238";
    frame_color = "#5E81AC";
    timeout = 10;
  };

  services.dunst.settings.urgency_normal = {
    background = "#94AD7D";
    foreground = "#263238";
    frame_color = "#94AD7D";
    timeout = 15;
  };

  services.dunst.settings.urgency_critical = {
    background = "#BF616A";
    foreground = "#263238";
    frame_color = "#BF616A";
    timeout = 0;
  };

  services.dunst.settings.shortcuts = {
    context = "mod4+grave";
    close = "mod4+shift+space";
  };

}
