{
  flake.modules.homeManager.polybar =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.writeShellApplication {
          name = "launch-polybar";
          text = ''
            for m in $(polybar --list-monitors | cut -d":" -f1); do
            	MONITOR=$m polybar mybar &
            done'';
        })
      ];
    };
}
