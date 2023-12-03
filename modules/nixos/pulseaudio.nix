{ config, pkgs, ... }: {

  # enable pulseaudio sound server 
  hardware.pulseaudio.enable = true;

  # include 32-bit pulseaudio libs
  hardware.pulseaudio.support32Bit = true;

  # enable extra features (e.g. bluetooth)
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
}
