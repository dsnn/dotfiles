{
  flake.modules.homeManager.shell =
    { lib, pkgs, ... }:
    {
      programs.starship =
        let
          flavour = "mocha"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
        in
        {
          enable = true;
          enableZshIntegration = true;
          settings = {
            add_newline = false;
            scan_timeout = 10;
            format = lib.concatStrings [
              "$username"
              "$hostname"
              "$directory"
              "$git_branch"
              "$git_status"
              "$nix_shell"
              "$character"
            ];

            username = {
              format = "[$user]($style)@";
              style_user = "bold grey";
            };

            hostname = {
              format = "[$hostname]($style)  ";
              style = "bold grey";
            };

            directory = {
              truncation_length = 1;
              truncate_to_repo = false;
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

            nix_shell = {
              format = "[$symbol]($style)";
              symbol = "❄️ ";
            };

            character = {
              success_symbol = "[➜](bold green)";
              error_symbol = "[➜](bold red)";
            };

            package = {
              disable = true;
            };

            # format = "$all"; # Remove this line to disable the default prompt format
            palette = "catppuccin_${flavour}";
          }
          // builtins.fromTOML (
            builtins.readFile (
              pkgs.fetchFromGitHub {
                owner = "catppuccin";
                repo = "starship";
                rev = "661c8a2c1cc43b1c0ba1f034ee1dd17442cce815"; # Replace with the latest commit hash
                sha256 = "nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
              }
              + /palettes/${flavour}.toml
            )
          );
        };
    };
}
