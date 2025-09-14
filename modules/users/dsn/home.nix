{
  flake.modules.homeManager.user-dsn = {
    home = {
      username = "dsn";
      stateVersion = "25.05";
      sessionVariables.NIXD_FLAGS = "-log=error";
    };
  };
}
