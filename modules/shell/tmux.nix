{
  flake.modules.homeManager.shell =
    { inputs, ... }:
    {
      home.packages = [
        inputs.myflakes.packages."aarch64-darwin".tmux
      ];

      programs.zsh.shellAliases = {
        tmux = "tmux-wrapper";
      };
    };
}
