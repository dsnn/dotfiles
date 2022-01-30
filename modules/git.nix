{ pkgs, ... }: {
  enable = true;
  userName = "dsn";
  userEmail = "dsn@dsnn.io";
  ignores = [ "node_modules" "npm-debug.log" ];
  aliases = {
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
      !${pkgs.git}/bin/git log --pretty=format:"%h %Cblue%ad%Creset %an %Cgreen%s%Creset" --decorate --date=short -10'';
    lg = ''
      !${pkgs.git}/bin/git log --pretty="%C(yellow)%h%Creset | %cd %d %s (%C(cyan)%an)" --date=format:"%Y-%m-%d %H:%M:%S" --graph'';
    last = ''
      !${pkgs.git}/bin/git log -''${1+}''${1-1} HEAD --pretty=format:"%h %Cblue%ad%Creset %an %Cgreen%s%Creset" --decorate --date=short -10'';
    pr =
      "!${pkgs.git}/bin/git checkout master;!${pkgs.git}/bin/git pull;git checkout @{-1};!${pkgs.git}/bin/git rebase master";
    pu = "!${pkgs.git}/bin/git push -u origin $(!${pkgs.git}/bin/git cb)";
    rba = "rebase --abort";
    rbc = "rebase --continue";
    rbi = "rebase --interactive";
    st = "status -s";
    undo = "!${pkgs.git}/bin/git reset HEAD^";
  };
  extraConfig = {
    core.editor = "vim";
    pull.rebase = true;
  };
}
