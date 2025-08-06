{
  flake.modules.homeManager.volta =
    { config, pkgs, ... }:
    {
      home.packages = with pkgs; [ volta ];

      programs.zsh.initContent = ''
        export VOLTA_HOME="${config.home.homeDirectory}/.config/volta"
        export PATH="$VOLTA_HOME/bin:$PATH"

        PATH="$PATH:${config.home.homeDirectory}/.node_modules/bin"
        export npm_config_prefix=~/.node_modules
      '';

      programs.zsh.shellAliases = {
        ns = "npm start";
        nd = "npm run dev";
        ni = "npm install";
        nt = "npm test";
        ntu = "npm run test:update-snapshot";
        nrt = "npm run typecheck";
        nrl = "npm run lint";
      };
    };
}
