{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        fira-code
        noto-fonts
      ];
    };
}
