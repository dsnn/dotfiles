{ config, pkgs, ... }: {
  # font
  console.font = "Lat2-Terminus16";

  # locale 
  i18n.defaultLocale = "en_US.UTF-8";

  # keyboard 
  console.keyMap = "sv-latin1";
}
