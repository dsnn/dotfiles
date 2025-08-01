{
  flake.modules.homeManager.volta =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ volta ];

      programs.zsh.initContent = ''
        export VOLTA_HOME="$HOME/.config/volta"
        export PATH="$VOLTA_HOME/bin:$PATH"

        PATH="$PATH:$HOME/.node_modules/bin"
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
