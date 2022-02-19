{ pkgs, ... }: {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    dotDir = ".config/zsh";
    autocd = true;
    # cdpath                 = true;

    history = {
      size = 10000;
      save = 10000;
      path = "/home/dsn/.config/zsh/history";
      ignoreDups = true;
      share = true;
      extended = true;
    };

    sessionVariables = {
      LC_CTYPE = "en_US.UTF-8";
      LEDGER_COLOR = "true";
      LESS = "-FRSXM";
      LESSCHARSET = "utf-8";
      PAGER = "less";
      # PROMPT = "%m %~ $ ";
      # PROMPT_DIRTRIM = "2";
      RPROMPT = "";
      TERM = "xterm-256color";
      TINC_USE_NIX = "yes";
      WORDCHARS = "";
      BROWSER = "firefox";
      VISUAL = "nvim";
      EDITOR = "nvim";
      MANWIDTH = 79;
      # LIBGL_ALWAYS_INDIRECT = 1;
    };

    shellAliases = {
      # vim  = "/home/dsn/.local/bin/nvim/bin/nvim";
      # nvim = "/home/dsn/.local/bin/nvim/bin/nvim";
      cat = "bat";
      awk = "nawk";

      # scripts
      # update-nvim="bash /home/dsn/dotfiles/bin/get-nvim.sh";

      # file shortcuts
      cfc = "vim ~/dotfiles/home.nix";
      cfs = "vim ~/.ssh/config";
      cfz = "vim ~/dotfiles/home.nix";
      cfg = "vim ~/dotfiles/home.nix";

      # folder shortcuts
      h = "cd ~/";
      d = "cd ~/dotfiles";
      cf = "cd ~/.config";

      # windows
      cwt =
        "cd /mnt/c/Users/dsn/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/";
      cwp = "cd /mnt/c/Users/dsn/Documents/PowerShell/";
      cwr = "cd /mnt/c/root";

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
      rf = "home-manager switch; source ~/.config/zsh/.zshrc";
      rl = "source ~/.config/zsh/.zshrc";

      # listing
      l = "ls -alh --color=auto";
      ll = "ls -alh --format=horizontal --color=auto";
      la = "ls -alh --color=auto";
      lt = "ls -alrth --color=auto";
      ls = "ls -hN --group-directories-first --color=auto";

      # git
      g = "git";
      ga = "git add .";
      gc = "git commit -m";
      gd = "git diff";
      gpl = "git pull";
      gl = "git ls";
      gp = "git push origin master";
      gpf = "git push --force-with-lease";
      gs = "git st";
      cb = "git cb";
      gam = "git commit --amend --no-edit";
      lzg = "lazygit";

      # npm
      ns = "npm start";
      ni = "npm install";
      nt = "npm test";
      ntu = "npm run test:update-snapshot";
      nrw = "npm run workbench";
      nrt = "npm run typecheck";
      nrl = "npm run lint";

      # wget
      wget = ''wget --hsts-file="/home/dsn/.config/wget"/wget-hsts'';

      # docker
      ds = "docker ps -a";
      di = "docker images";
      drm = ''docker rm $(docker ps -qa --no-trunc --filter "status=exited")'';
      drmi = "docker rmi $(docker images -q -f dangling=true)";
      # dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

      # vagrant
      vu = "vagrant up";
      vh = "vagrant halt -f";
      vd = "vagrant destroy -f";
      vs = "vagrant ssh";
      vp = "vagrant provision";

      # work
      web = "/home/dsn/opto/Core/Code/ServerHtml5/Web";
      core = "/home/dsn/opto/Core/Code";
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

      setxkbmap -option 'caps:ctrl_modifier' && xcape -e 'Caps_Lock=Escape' &
    '';
  };

}
