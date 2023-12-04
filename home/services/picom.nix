{ pkgs, ... }: {

  # compositor for xorg
  services.picom.enable = true;

  # services.picom.activeOpacity = "0.9";
  # services.picom.blur = true;

  services.picom.extraOptions = ''
    corner-radius = 0;
    blur-method = "dual_kawase";
    blur-strength = "10";
    xinerama-shadow-crop = true;
  '';

  services.picom.experimentalBackends = true;

  services.picom.shadowExclude = [ "bounding_shaped && !rounded_corners" ];

  services.picom.fade = true;
  services.picom.fadeDelta = 5;

  # services.picom.vsync = true;

  # services.picom.opacityRule = [
  #   "100:class_g   *?= 'Firefox'"
  #   "100:class_g   *?= 'slack'"
  # ];

  # enables rounded corners
  services.picom.package = pkgs.picom.overrideAttrs (o: {
    src = pkgs.fetchFromGitHub {
      repo = "picom";
      owner = "ibhagwan";
      rev = "c4107bb6cc17773fdc6c48bb2e475ef957513c7a";
      sha256 = "sha256-1hVFBGo4Ieke2T9PqMur1w4D0bz/L3FAvfujY9Zergw=";
    };
  });
}
