{
  flake.modules.nixos.users =
    { pkgs, ... }:
    {
      users = {
        mutableUsers = false;
        defaultUserShell = pkgs.zsh;
      };
    };
}
