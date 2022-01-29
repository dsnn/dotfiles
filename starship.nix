{pkgs, lib, ...}:
{
  enable = true;
  settings = {
      add_newline = false;
      scan_timeout = 10;
      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_status"
        "$character"
      ];
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
}
