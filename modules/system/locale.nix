{ config, pkgs, ... }: {

  # font used for the virtual consoles
  console.font = "Lat2-Terminus16";

  # default locale for programs, dates, sort etc 
  i18n.defaultLocale = "en_US.UTF-8";

  # keyboard mapping table for the virtual consoles 
  console.keyMap = "sv-latin1";
}
