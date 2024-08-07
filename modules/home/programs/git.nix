{ pkgs, config, ... }:
let inherit (pkgs.stdenv) isDarwin;
in {

  home.sessionVariables = {
    SSH_AUTH_SOCK = if isDarwin then
      "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else
      "${config.home.homeDirectory}/.1password/agent.sock";
  };

  programs.zsh.shellAliases = {
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

    # TODO: review this. not tested
    delete-merged-branches =
      "!f() { git checkout --quiet master && git branch --merged | grep --invert-match '\\*' | xargs -n 1 git branch --delete; git checkout --quiet @{-1}; }; f";

    # TODO: show commits for today
    day =
      "!sh -c 'git log --reverse --no-merges --branches --date=iso --after=\"yesterday 23:59\" --author=\"`git config --get user.name`\"'";

    # TODO: review this. not working.
    # order files by number of commits, ascending
    # Written by Corey Haines
    # Scriptified by Gary Bernhardt
    # Show churn for a time range:
    #   $ git churn --since='1 month ago'
    churn = ''
      !f() { git log --all -M -C --name-only --format='format:' "$@" | sort | grep -v '^$' | uniq -c | sort | awk 'BEGIN {print "count	file"} {print $1 "	" $2}' | sort -g; }; f'';
  };

  programs.git = {
    enable = true;
    userName = "dsn";
    userEmail = "dsn@dsnn.io";
    ignores = [ ".DS_Store" "node_modules" "npm-debug.log" ];

    extraConfig = {
      core.editor = "nvim";
      pull.rebase = true;
      merge = {
        tool = "vimdiff";
        conflictstyle = "diff3";
      };
      mergetool.prompt = false;
    };

    delta = {
      enable = true;
      options = {
        chameleon = {
          dark = true;
          line-numbers = true;
          side-by-side = true;
          keep-plus-minus-markers = true;
          syntax-theme = "Nord";
          file-style = "#434C5E bold";
          file-decoration-style = "#434C5E ul";
          file-added-label = "[+]";
          file-copied-label = "[==]";
          file-modified-label = "[*]";
          file-removed-label = "[-]";
          file-renamed-label = "[->]";
          hunk-header-style = "omit";
          line-numbers-left-format = " {nm:>1} │";
          line-numbers-left-style = "red";
          line-numbers-right-format = " {np:>1} │";
          line-numbers-right-style = "green";
          line-numbers-minus-style = "red italic black";
          line-numbers-plus-style = "green italic black";
          line-numbers-zero-style = "#434C5E italic";
          minus-style = "bold red";
          minus-emph-style = "bold red";
          plus-style = "bold green";
          plus-emph-style = "bold green";
          zero-style = "syntax";
          blame-code-style = "syntax";
          blame-format = "{author:<18} ({commit:>7}) {timestamp:^12} ";
          blame-palette = "#2E3440 #3B4252 #434C5E #4C566A";
        };
        features = "chameleon";
        side-by-side = true;
      };
    };

    aliases = {
      ba = "branch -a";
      bl = "branch --list";
      br = "branch -r";
      current = "!${pkgs.git}/bin/git rev-parse --abbrev-ref HEAD";
      cb = "!${pkgs.git}/bin/git rev-parse --abbrev-ref HEAD";
      cm = "commit -m";
      cma = "commit --amend --no-edit";
      co = "checkout";
      cob = "checkout -b";
      gpf = "push --force-with-lease";
      la = "!${pkgs.git}/bin/git config -l | grep alias | cut -c 7-";
      ls = ''
        !${pkgs.git}/bin/git log --pretty=format:"%h %Cblue%ad%Creset %an %Cgreen%s%Creset" --decorate --date=format:'%Y-%m-%d %H:%M:%S' -10'';
      lg = ''
        !${pkgs.git}/bin/git log --pretty="%C(yellow)%h%Creset | %cd %d %s (%C(cyan)%an)" --date=format:"%Y-%m-%d %H:%M:%S" --graph'';
      last = ''
        !${pkgs.git}/bin/git log -''${1+}''${1-1} HEAD --pretty=format:"%h %Cblue%ad%Creset %an %Cgreen%s%Creset" --decorate --date=format:'%Y-%m-%d %H:%M:%S' -10'';
      pr =
        "!${pkgs.git}/bin/git checkout master;!${pkgs.git}/bin/git pull;git checkout @{-1};!${pkgs.git}/bin/git rebase master";
      pu = "!${pkgs.git}/bin/git push -u origin $(!${pkgs.git}/bin/git cb)";
      rba = "rebase --abort";
      rbc = "rebase --continue";
      rbi = "rebase --interactive";
      st = "status -s";
      undo = "!${pkgs.git}/bin/git reset HEAD^";
    };

  };

}
