{
  flake.modules.darwin.zsh = {
    programs.zsh.enable = true;
  };

  flake.modules.homeManager.shell =
    { config, pkgs, ... }:
    {
      # deps
      home.packages = with pkgs; [ zsh-fzf-tab ];

      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          dotDir = "${config.home.homeDirectory}/.config/zsh";
          autocd = true;

          history = {
            size = 10000;
            save = 10000;
            ignoreDups = true;
            share = true;
            extended = true;
            path = "${config.home.homeDirectory}/.config/zsh/history";
          };

          sessionVariables = {
            LC_CTYPE = "en_US.UTF-8";
            LEDGER_COLOR = "true";
            LESS = "-FRSXM";
            LESSCHARSET = "utf-8";
            PAGER = "less";
            PROMPT = "%m %~ $ ";
            PROMPT_DIRTRIM = "2";
            RPROMPT = "";
            TERM = "xterm-256color";
            TINC_USE_NIX = "yes";
            WORDCHARS = "";
            BROWSER = "chrome";
            MANWIDTH = 79;
          };

          shellAliases = {
            awk = "nawk";
            tracert = "trip";

            # folder shortcuts
            h = "cd ~/";
            d = "cd ~/dotfiles";
            cf = "cd ~/.config";
            cfp = "cd ~/projects/";

            # navigation
            ".." = "cd ..";
            "..." = "cd ../..";
            "...." = "cd ../../..";
            "....." = "cd ../../../..";
            "-- -" = "cd ~";
            "cd.." = "cd ..";

            # actions
            mv = "mv -v";
            rm = "rm -i -v";
            rmd = "rm -rf";
            cp = "cp -v";
            df = "df -h";
            mkdir = "mkdir -pv";
            rl = "source ~/.config/zsh/.zshrc";

            # nix
            bir = "nix repl";
            biu = "nix run";
            bii = "nix-instansiate";
            bis = "nix shell";
            "nix-shell" = "nix-shell --run zsh";

          };

          initContent = ''
            # make vi mode transitions faster
            export KEYTIMEOUT=1

            # export dotnet-ef for migrations
            export PATH="$PATH:/Users/dsn/.dotnet/tools"

            # enable vi-mode
            bindkey -v

            bindkey '^ ' autosuggest-accept

            autoload -U edit-command-line; zle -N edit-command-line
            bindkey '^e' edit-command-line

            # list the PATH separated by new lines
            alias lpath='echo $PATH | tr ":" "\n"'

            # Recursively delete `.DS_Store` files
            alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

            # remove broken symlinks
            alias clsym="find -L . -name . -o -type d -prune -o -type l -exec rm {} +"

            run-cd-command () { BUFFER="cd .."; zle accept-line }
            zle -N run-cd-command
            bindkey '^u' run-cd-command

              if command -v op &> /dev/null
            then
              eval "$(op completion zsh)"; compdef _op op
            fi
          '';
        };
      };
    };
}

# // optionalAttrs cfg.enable-docker-aliases {
#   ds = "docker ps -a";
#   di = "docker images";
#   drm = ''docker rm $(docker ps -qa --no-trunc --filter "status=exited")'';
#   drmi = "docker rmi $(docker images -q -f dangling=true)";
#   # dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
# };
