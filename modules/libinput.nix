{ config, pkgs, ... }: {
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.accelSpeed = "0.6";
  services.xserver.libinput.touchpad.additionalOptions = ''
    Option "TappingDrag" "0"
  '';

}
