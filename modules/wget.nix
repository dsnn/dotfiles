{
  flake.modules.homeManager.wget = pkgs: {
    home.packages = with pkgs; [ wget ];

    programs.zsh.shellAliases = {
      wget = ''wget --hsts-file="$HOME/.config/wget"/wget-hsts'';
    };
  };
}
