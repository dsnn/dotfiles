{
  flake.modules.homeManager.gh =
    { pkgs, ... }:
    {
      programs = {
        gh = {
          enable = true;
          extensions = [
            pkgs.gh-dash
            pkgs.gh-copilot
          ];
        };

        gh-dash = {
          enable = true;
          settings = {
            prSections = [
              {
                title = "To review";
                filters = "repo:NixOS/nixpkgs is:open draft:false status:success";
              }
              {
                title = "My PRs";
                filters = "is:open author:@me";
              }
              {
                title = "Needs my review";
                filters = "is:open review-requested:@me";
              }
              {
                title = "Involved";
                filters = "is:open involves:@me -author:@me";
              }
            ];
            defaults = {
              prsLimit = 25;
              issuesLimit = 10;
              view = "prs";
              preview = {
                open = false;
                width = 100;
              };
              refetchIntervalMinutes = 10;
            };
            keybindings = {
              prs = [
                {
                  key = "V";
                  command = "cd {{.RepoPath}} && nvim . && gh pr checkout {{.PrNumber}}";
                }
              ];
            };
            repoPaths = {
              "github/*" = "~/projects/gh/*";
            };
            theme.ui.table.showSeparator = false;
          };
        };
      };
    };
}
