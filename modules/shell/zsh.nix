{

  flake.modules = {
    darwin.zsh.programs.zsh.enable = true;
    nixos.zsh.programs.zsh.enable = true;
  };

  flake.modules.homeManager = {
    alpha = {
      programs.zsh.shellAliases = {
        cfc = "vim $HOME/dotfiles/modules/alpha/configurations.nix";
        cfh = "vim $HOME/dotfiles/modules/alpha/home.nix";
        cfg = "vim $HOME/dotfiles/modules/git.nix";
        cfz = "vim $HOME/dotfiles/modules/alpha/zsh.nix";
        rf = "home-manager switch --flake ~/dotfiles/#alpha; source ~/.config/zsh/.zshrc";
        rs = "sudo nixos-rebuild switch --flake ~/dotfiles/#alpha";
      };
    };

    silver = {
      programs.zsh = {
        shellAliases = {
          dotnet = "/usr/local/share/dotnet/dotnet";
          cfc = "vim $HOME/dotfiles/modules/silver/configurations.nix";
          cfh = "vim $HOME/dotfiles/modules/silver/home.nix";
          cfg = "vim $HOME/dotfiles/modules/git.nix";
          cfz = "vim $HOME/dotfiles/modules/silver/zsh.nix";
          rf = "home-manager switch --flake ~/dotfiles/#silver; source ~/.config/zsh/.zshrc";
          rs = "sudo darwin-rebuild switch --flake ~/dotfiles/#silver";
        };
      };
    };
  };

  flake.modules.homeManager.shell =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      zshPlugins = [
        {
          package = pkgs.nix-zsh-completions;
          url = "https://github.com/nix-community/nix-zsh-completions";
          subPath = "/share/zsh/plugins/nix/nix-zsh-completions.plugin.zsh";
        }
        {
          package = pkgs.zsh-fzf-tab;
          url = "https://github.com/Aloxaf/fzf-tab";
          subPath = "/share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ];
      pluginSources = builtins.concatStringsSep "\n" (
        map (p: "source ${p.package}${p.subPath}") zshPlugins
      );
    in
    {
      # deps
      home.packages =
        with pkgs;
        [
          trash-cli # https://github.com/andreafrancia/trash-cli
        ]
        ++ (map (p: p.package) zshPlugins);

      programs = {
        zsh = {
          enable = true;
          autocd = true;
          dotDir = "${config.home.homeDirectory}/.config/zsh";

          enableVteIntegration = true;
          enableCompletion = true;

          autosuggestion = {
            enable = true;
            strategy = [
              "match_prev_cmd"
              "completion"
              "history"
            ];
          };
          syntaxHighlighting.enable = true;

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
            EDITOR = "nvim";
            MANWIDTH = 79;
          };

          shellAliases = {
            nix-shell = "nix-shell --run ${lib.getExe pkgs.zsh}";
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
            rm = "trash-put";
            rmd = "trash-put";
            cp = "cp -v";
            df = "df -h";
            mkdir = "mkdir -pv";
            rl = "source ~/.config/zsh/.zshrc";

            # disk usage
            dud = "du --max-depth=1 --human-readable";
            duf = "du --summarize --human-readable *";

            # nix
            bir = "nix repl";
            biu = "nix run";
            bii = "nix-instansiate";
            bis = "nix shell";

            # Recursively delete `.DS_Store` files
            cleanup = "find . -name '*.DS_Store' -type f -ls -delete";

            # list the PATH separated by new lines
            lpath = "echo $PATH | tr ':' '\n'";

            # remove broken symlinks
            clsym = "find -L . -name . -o -type d -prune -o -type l -exec rm {} +";
          };

          # Similar to programs.zsh.shellAliases,
          # but are substituted anywhere on a line.
          shellGlobalAliases = {
            H = "| head";
            T = "| tail";
            G = "| grep";
            L = "| less";
            M = "| most";
            LL = "2>&1 | less";
            CA = "2>&1 | cat -A";
            NE = "2> /dev/null";
            NUL = "> /dev/null 2>&1";
            P = "2>&1| pygmentize -l pytb";
          };

          initContent = ''
            # make vi mode transitions faster
            export KEYTIMEOUT=1

            # ---------------------- #
            #         dotnet         #
            # ---------------------- #

            # export dotnet-ef for migrations
            export PATH="$PATH:${config.home.homeDirectory}/.dotnet/tools"

            # ---------------------- #
            #          accept        #
            # ---------------------- #

            # ctrl + space to accept
            bindkey '^ ' autosuggest-accept
            bindkey '^Y' autosuggest-accept

            # ---------------------- #
            #        extract         #
            # ---------------------- #

            ex ()
            {
              if [ -f $1 ] ; then
                case $1 in
                  *.tar.bz2)   tar xjf $1   ;;
                  *.tar.gz)    tar xzf $1   ;;
                  *.tar.xz)    tar xJf $1   ;;
                  *.bz2)       bunzip3 $1   ;;
                  *.rar)       unrar x $1   ;;
                  *.gz)        gunzip $1    ;;
                  *.tar)       tar xf $1    ;;
                  *.tbz2)      tar xjf $1   ;;
                  *.tgz)       tar xzf $1   ;;
                  *.zip)       unzip $1     ;;
                  *.Z)         uncompress $1;;
                  *.7z)        7z x $1      ;;
                  *)           echo "'$1' cannot be extracted via ex()" ;;
                esac
              else
                echo "'$1' is not a valid file"
              fi
            }

            # ---------------------- #
            #      fn bindings       #
            # ---------------------- #

            autoload -U edit-command-line; zle -N edit-command-line
            bindkey '^e' edit-command-line

            run-cd-command () { BUFFER="cd .."; zle accept-line }
            zle -N run-cd-command
            bindkey '^u' run-cd-command

            # ---------------------- #
            #      1Password         #
            # ---------------------- #

            if command -v op &> /dev/null
            then
              eval "$(op completion zsh)"; compdef _op op
            fi

            # ---------------------- #
            #      plugins (pkgs)    #
            # ---------------------- #

            ${pluginSources}

            # # ---------------------- #
            # #       zsh-fzf-tab      #
            # # ---------------------- #
            #
            # # disable sort when completing `git checkout`
            # zstyle ':completion:*:git-checkout:*' sort false
            #
            # # set descriptions format to enable group support
            # # NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
            # zstyle ':completion:*:descriptions' format '[%d]'
            #
            # # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
            # zstyle ':completion:*' menu no
            #
            # # preview directory's content with eza when completing cd
            # zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
            #
            # # custom fzf flags
            # # NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
            # zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
            #
            # # To make fzf-tab follow FZF_DEFAULT_OPTS.
            # # NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
            # zstyle ':fzf-tab:*' use-fzf-default-opts yes
            #
            # # switch group using `<` and `>`
            # zstyle ':fzf-tab:*' switch-group '<' '>'
          '';
        };
      };
    };
}
