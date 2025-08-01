{
  flake.modules.home.shell = {
    programs.zoxide.enable = true;
    programs.zoxide.enableZshIntegration = true;
  };
}
