{ pkgs, ...} : {

  # https://github.com/junegunn/fzf
  # https://github.com/nix-community/home-manager/blob/master/modules/programs/fzf.nix

  # deps
  home.packages = with pkgs; [ fd ];

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  programs.fzf.tmux.enableShellIntegration = true;
  programs.fzf.tmux.shellIntegrationOptions = [
    "-p80%,60%"
  ];

  programs.fzf.fileWidgetOptions = [
    "--preview 'bat -n --color=always {}'"
    "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
  ];
  programs.fzf.changeDirWidgetOptions = [
    "--preview 'tree -C {}'"
  ];
  programs.fzf.historyWidgetOptions = [
   "--preview 'echo {}' --preview-window up:3:hidden:wrap"
   "--bind 'ctrl-/:toggle-preview'"
   "--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
   "--color header:italic"
   "--header 'Press CTRL-Y to copy command into clipboard'"
  ];

  # catppuccin
  programs.fzf.colors = {
    "bg" = "#1e1e2e";
    "bg+" = "#313244";
    "fg" = "#cdd6f4";
    "header" = "#f38ba8";
    "hl" = "#f38ba8";
    "info" = "#cba6f7";
    "pointer" = "#f5e0dc";
    "spinner" = "#f5e0dc";
  };

  # [
  #   "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8"
  #   "--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc"
  #   "--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
  # ];
}
