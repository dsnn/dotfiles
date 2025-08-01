{
  flake.modules.homeManager.shell = {
    programs.zoxide.enable = true;
    programs.zoxide.enableZshIntegration = true;
  };
}
