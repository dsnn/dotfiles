{ config, ... }: {
  programs.dircolors.enable = true;

  home.file."${config.home.homeDirectory}/.config/dircolors".source = ./config;
}
