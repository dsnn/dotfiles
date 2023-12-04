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
  };

  programs.git.enable = true;
  programs.git.userName = "dsn";
  programs.git.userEmail = "dsn@dsnn.io";
  programs.git.ignores = [ ".DS_Store" "node_modules" "npm-debug.log" ];
  programs.git.delta.enable = true;

  programs.git.aliases = {
    ba = "branch -a";
    bl = "branch --list";
    br = "branch -r";
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

  programs.git.extraConfig = {
    core.editor = "vim";
    pull.rebase = true;
    merge = {
      tool = "vimdiff";
      conflictstyle = "diff3";
    };
    mergetool.prompt = false;
  };
}
