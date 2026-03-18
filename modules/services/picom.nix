{
  flake.modules.nixos.picom =
    { config, pkgs, ... }:
    {
      # compositor for xorg
      services.picom.enable = true;
      # services.picom.activeOpacity = "0.9";
      # services.picom.blur = true;
      services.picom.settings = {
        cornerRadius = 0;
        blurMethod = "dual_kawase";
        blurStrength = "10";
        xineramaShadowCrop = true;
      };
      services.picom.shadowExclude = [ "bounding_shaped && !rounded_corners" ];
      services.picom.fade = true;
      services.picom.fadeDelta = 5;

      # enables rounded corners
      services.picom.package = pkgs.picom.overrideAttrs (o: {
        src = pkgs.fetchFromGitHub {
          repo = "picom";
          owner = "ibhagwan";
          rev = "c4107bb6cc17773fdc6c48bb2e475ef957513c7a";
          sha256 = "sha256-1hVFBGo4Ieke2T9PqMur1w4D0bz/L3FAvfujY9Zergw=";
        };
      });
    };
}
