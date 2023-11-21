{ pkgs, lib, ... }: {

  programs.starship.enable = true;
  programs.starship.settings.add_newline = false;
  programs.starship.settings.scan_timeout = 10;
  programs.starship.settings.format = lib.concatStrings [
    "$username"
    "$hostname"
    "$directory"
    "$git_branch"
    "$git_status"
    "$character"
  ];

  programs.starship.settings.username = {
    format = "[$user]($style)@";
    style_user = "bold grey";
  };

  programs.starship.settings.hostname = {
    format = "[$hostname]($style)  ";
    style = "bold grey";
  };

  programs.starship.settings.directory = {
    truncation_length = 1;
    truncate_to_repo = false;
    format = "[$path]($style) [$read_only]($read_only_style)";
    style = "bold white";
    read_only = "🔒";
  };

  programs.starship.settings.git_branch = {
    format = "[$symbol$branch]($style) ";
    symbol = " ";
    style = "bold grey";
  };

  programs.starship.settings.git_status = {
    format = "$all_status$ahead_behind ";
    style = "bold grey";
  };

  programs.starship.settings.character = {
    success_symbol = "[➜](bold green)";
    error_symbol = "[➜](bold red)";
  };

  programs.starship.settings.package = { disable = true; };
}
