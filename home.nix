{ config, pkgs, lib, ... }:

# for package and service info: 
# https://github.com/nix-community/home-manager/tree/master/

let 
  profileDirectory = config.home.profileDirectory;

in {
  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  home.username               = "dsn";
  home.homeDirectory          = "/home/dsn";
  home.stateVersion           = "22.05";

  xdg = {
    enable = true;
    cacheHome = ~/.local/cache;
    configHome = ~/.config;
    dataHome = ~/.local/share;
  };

  fonts.fontconfig.enable = true;

  # programs.fontconfig = {
  #   enable = true;
  # };

  # fonts = with pkgs; [
  #   (nerdfonts.override { fonts = [ "FiraCode" "Roboto" ]; })
  # ];


  home.packages = with pkgs; [
      bat
      fzf
      git
      htop
      jq
      keychain
      lazygit
      nawk
      neovim
      nixfmt
      nixpkgs-fmt
      nodePackages.npm
      nodejs
      ripgrep
      rnix-lsp
      starship
      tmux
      unzip
      vim
      wget
      xclip
      zsh
      (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" ]; })
  ];

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs.home-manager = {
    enable = true;
  };


  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink ~/dotfiles/nvim;
  # xdg.configFile."nvim" = {
  #   source = ~/dotfiles/nvim;
  #   recursive = true;
  # };

  programs.git = {
    enable    = true;
    userName  = "dsn";
    userEmail = "dsn@dsnn.io";
    ignores = [
      "node_modules"
      "npm-debug.log"
    ];
    aliases = {
      ba   = "branch -a";
      bl   = "branch --list";
      br   = "branch -r";
      cb   = "!${pkgs.git}/bin/git rev-parse --abbrev-ref HEAD";
      cm   = "commit -m";
      cma  = "commit --amend --no-edit";
      co   = "checkout";
      cob  = "checkout -b";
      gpf  = "push --force-with-lease";
      la   = "!${pkgs.git}/bin/git config -l | grep alias | cut -c 7-";
      ls   = "!${pkgs.git}/bin/git log --pretty=format:\"%h %Cblue%ad%Creset %an %Cgreen%s%Creset\" --decorate --date=short -10";
      lg   = "!${pkgs.git}/bin/git log --pretty=\"%C(yellow)%h%Creset | %cd %d %s (%C(cyan)%an)\" --date=format:\"%Y-%m-%d %H:%M:%S\" --graph";
      last = "!${pkgs.git}/bin/git log -\${1+}\${1-1} HEAD --pretty=format:\"%h %Cblue%ad%Creset %an %Cgreen%s%Creset\" --decorate --date=short -10";
      pr   = "!${pkgs.git}/bin/git checkout master;!${pkgs.git}/bin/git pull;git checkout @{-1};!${pkgs.git}/bin/git rebase master";
      pu   = "!${pkgs.git}/bin/git push -u origin $(!${pkgs.git}/bin/git cb)";
      rba  = "rebase --abort";
      rbc  = "rebase --continue";
      rbi  = "rebase --interactive";
      st   = "status -s";
      undo = "!${pkgs.git}/bin/git reset HEAD^";
    };
    extraConfig = {
      core.editor = "vim";
      pull.rebase = true;
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # defaultCommand = "rg --files --hidden --follow -g \"!{.git,node_modules}/*\" 2> /dev/null";
  };

  # programs.keychain  = {};
  # programs.lazygit   = {};
  # programs.z-lua     = {};


  programs.starship  = {
    enable = true;
    settings = {
       add_newline = false;
       format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_status"
        "$character"
       ];
       scan_timeout = 10;
       directory = {
        truncation_length = 1;
        truncate_to_repo = true;
        format = "[$path]($style) [$read_only]($read_only_style)";
        style = "bold white";
        read_only = "🔒";
       };
       git_branch = {
        format = "[$symbol$branch]($style) ";
        symbol = " ";
        style = "bold grey";
       };
       git_status = {
        format = "$all_status$ahead_behind ";
        style = "bold grey";
       };
       character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
       };
       package = {
          disable = true;
       };
    };
  };

  programs.dircolors = {
    enable = true;
  };

  programs.zsh = {
    enable                   = true;
    enableCompletion         = true; 
    enableAutosuggestions    = true;
    enableSyntaxHighlighting = true;
    dotDir                   = ".config/zsh";
    autocd                   = true;
    # cdpath                 = true;

    history = {
      size       = 10000;
      save       = 10000;
      path       = "/home/dsn/.config/zsh/history";
      ignoreDups = true;
      share      = true;
      extended   = true;
    };

    sessionVariables = {
      LC_CTYPE              = "en_US.UTF-8";
      LEDGER_COLOR          = "true";
      LESS                  = "-FRSXM";
      LESSCHARSET           = "utf-8";
      PAGER                 = "less";
      PROMPT                = "%m %~ $ ";
      PROMPT_DIRTRIM        = "2";
      RPROMPT               = "";
      TERM                  = "xterm-256color";
      TINC_USE_NIX          = "yes";
      WORDCHARS             = "";
      BROWSER               = "firefox";
      VISUAL                = "nvim";
      EDITOR                = "nvim";
      MANWIDTH              = 79;
      LIBGL_ALWAYS_INDIRECT = 1;
    };

    shellAliases = {
      # vim  = "/home/dsn/.local/bin/nvim/bin/nvim";
      # nvim = "/home/dsn/.local/bin/nvim/bin/nvim";
      cat  = "bat";
      awk  = "nawk";

      # scripts
      # update-nvim="bash /home/dsn/dotfiles/bin/get-nvim.sh";

      # file shortcuts
      cfc = "vim ~/dotfiles/home.nix";
      cfs = "vim ~/.ssh/config";
      cfz = "vim ~/dotfiles/home.nix";
      cfg = "vim ~/dotfiles/home.nix";

      # folder shortcuts
      h="cd ~/";
      d="cd ~/dotfiles";
      cf="cd ~/.config";

      # windows
      cwt="cd /mnt/c/Users/dsn/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/";
      cwp="cd /mnt/c/Users/dsn/Documents/PowerShell/";
      cwr="cd /mnt/c/root";

      # navigation
      ".."    = "cd ..";
      "..."   = "cd ../..";
      "...."  = "cd ../../..";
      "....." = "cd ../../../..";
      "-- -"  = "cd ~";
      "cd.."  = "cd ..";

      # actions
      mv    = "mv -v";
      rm    = "rm -i -v";
      rmd   = "rm -rf";
      cp    = "cp -v";
      df    = "df -h";
      mkdir = "mkdir -pv";
      rf    = "home-manager switch; source ~/.config/zsh/.zshrc";
      rl    = "source ~/.config/zsh/.zshrc";

      # listing
      l  = "ls -alh --color=auto";
      ll = "ls -alh --format=horizontal --color=auto";
      la = "ls -alh --color=auto";
      lt = "ls -alrth --color=auto";
      ls = "ls -hN --group-directories-first --color=auto";

      # git
      g   = "git";
      ga  = "git add .";
      gc  = "git commit -m";
      gd  = "git diff";
      gpl = "git pull";
      gl  = "git ls";
      gp  = "git push origin master";
      gpf = "git push --force-with-lease";
      gs  = "git st";
      cb  = "git cb";
      gam = "git commit --amend --no-edit";
      lzg = "lazygit";

      # npm
      ns="npm start";
      ni="npm install";
      nt="npm test";
      ntu="npm run test:update-snapshot";
      nrw="npm run workbench";
      nrt="npm run typecheck";
      nrl="npm run lint";

      # wget
      wget="wget --hsts-file=\"/home/dsn/.config/wget\"/wget-hsts";

      # docker
      ds="docker ps -a";
      di="docker images";
      drm="docker rm $(docker ps -qa --no-trunc --filter \"status=exited\")";
      drmi="docker rmi $(docker images -q -f dangling=true)";
      # dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

      # vagrant
      vu="vagrant up";
      vh="vagrant halt -f";
      vd="vagrant destroy -f";
      vs="vagrant ssh";
      vp="vagrant provision";

      # work
      web="/home/dsn/opto/Core/Code/ServerHtml5/Web";
      core="/home/dsn/opto/Core/Code";
    };
    initExtra = ''
      # Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
      export KEYTIMEOUT=1

      # keybinding for accepting autosuggestion
      bindkey '^ ' autosuggest-accept

      # edit current command in vim
      autoload -U edit-command-line; zle -N edit-command-line
      bindkey '^e' edit-command-line

      # keychain
      if [ -f ~/.ssh/id_rsa ]; then
        eval $(keychain --eval --quiet --quick id_rsa ~/.ssh/id_rsa)
      fi

      # keybinding for cd .. 
      function up_widget() {
        BUFFER="cd .."
        zle accept-line
      }
      zle -N up_widget
      bindkey "^u" up_widget

      # keybinding for nvim
      function run_nvim() {
        BUFFER="nvim && clear"
        zle accept-line
      }
      zle -N run_nvim 
      bindkey "^n" run_nvim 

      # keybinding for lazy git
      function run_lazy_git() {
        BUFFER="lazygit && clear"
        zle accept-line
      }
      zle -N run_lazy_git
      bindkey "^g" run_lazy_git

      # starship  prompt
      eval "$(starship init zsh)"
    '';
  };
}