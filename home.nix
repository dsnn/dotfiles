{ config, pkgs, ... }:

# for package and service info: 
# https://github.com/nix-community/home-manager/tree/master/modules

{
  targets.genericLinux.enable = true;
  home.username               = "dsn";
  home.homeDirectory          = "/home/dsn";
  home.stateVersion           = "22.05";
  xdg.cacheHome               = "/home/dsn/.local/cache";
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
      starship
      tmux
      unzip
      vim
      wget
      xclip
      z-lua
  ];

  programs.home-manager = {
    enable = true;
  };

  programs.git = {
    enable    = true;
    userName  = "dsn";
    userEmail = "dsn@dsnn.io";
    ignores = [
      "node_modules"
      "npm-debug.log"
    ];
    aliases = {
      ls   = "!${pkgs.git}/bin/git log --pretty=format:\"%h %Cblue%ad%Creset %an %Cgreen%s%Creset\" --decorate --date=short -10";
      st   = "status -s";
      bl   = "branch --list";
      br   = "branch -r";
      ba   = "branch -a";
      cb   = "!${pkgs.git}/bin/git rev-parse --abbrev-ref HEAD";
      cm   = "commit -m";
      cma  = "commit --amend --no-edit";
      co   = "checkout";
      cob  = "checkout -b";
      undo = "reset HEAD^";
      la   = "!${pkgs.git}/bin/git config -l | grep alias | cut -c 7-";
      pr   = "!${pkgs.git}/bin/git checkout master;!${pkgs.git}/bin/git pull;git checkout @{-1};!${pkgs.git}/bin/git rebase master";
      pu   = "!${pkgs.git}/bin/git push -u origin $(!${pkgs.git}/bin/git cb)";
      gpf  = "push --force-with-lease";
      rbi  = "rebase --interactive";
      rbc  = "rebase --continue";
      rba  = "rebase --abort";
    };
    extraConfig = {
      core.editor = "vim";
      pull.rebase = true;
    };
  };


  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # programs.keychain  = {};
  # programs.lazygit   = {};
  # programs.starship  = {};
  # programs.z-lua     = {};
  programs.dircolors = {
    enable = true;
  };

  programs.zsh = {
    enable                   = true;
    enableCompletion         = false; # TODO: set environment.pathsToLink for e.g. systemd completion
    enableAutosuggestions    = true;
    enableSyntaxHighlighting = true;
    dotDir                   = ".config/zsh";
    autocd                   = true;
    # cdpath                 = true;

    history = {
      size       = 50000;
      save       = 500000;
      path       = "/home/dsn/.config/zsh/history";
      ignoreDups = true;
      share      = true;
      extended   = true;
    };

    sessionVariables = {
      LC_CTYPE         = "en_US.UTF-8";
      LEDGER_COLOR     = "true";
      LESS             = "-FRSXM";
      LESSCHARSET      = "utf-8";
      PAGER            = "less";
      PROMPT           = "%m %~ $ ";
      PROMPT_DIRTRIM   = "2";
      RPROMPT          = "";
      TERM             = "xterm-256color";
      TINC_USE_NIX     = "yes";
      WORDCHARS        = "";
    };

    shellAliases = {
      vim  = "/home/dsn/.local/bin/nvim/bin/nvim";
      nvim = "/home/dsn/.local/bin/nvim/bin/nvim";
      cat  = "bat";
      awk  = "nawk";

      # file shortcuts
      cfc = "vim ~/dotfiles/home.nix";
      cfs = "vim ~/.ssh/config";
      cfz = "vim ~/dotfiles/home.nix";
      cfg = "vim ~/dotfiles/home.nix";

      # folder shortcuts
      h="cd ~/";
      d="cd ~/dotfiles";
      cf="cd ~/.config";

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

      # listing
      l  = "ls -alh --color=auto";
      ll = "ls -alh --format=horizontal --color=auto";
      la = "ls -alh --color=auto";
      lt = "ls -alrth --color=auto";
      ls = "ls -hN --group-directories-first --color=auto";

      # git
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

      ns="npm start";
      ni="npm install";
      nt="npm test";
      ntu="npm run test:update-snapshot";
      nrw="npm run workbench";
      nrt="npm run typecheck";
      nrl="npm run lint";
    };
    initExtra = ''
      # Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
      export KEYTIMEOUT=1

      # keybinding for accepting autosuggestion
      bindkey '^ ' autosuggest-accept

      # edit current command in vim
      bindkey -M vicmd "^V" edit-command-line
      zle -N edit-command-line

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

    # envExtra = ''
    #  if [ -e /home/dsn/.nix-profile/etc/profile.d/nix.sh ]; then . /home/dsn/.nix-profile/etc/profile.d/nix.sh; fi
    #  if [ -e /home/dsn/.config/zsh/.zshrc ]; then . /home/dsn/.config/zsh/.zshrc; fi
    # '';
  };
}
