# https://github.com/junegunn/fzf
# https://github.com/nix-community/home-manager/blob/master/modules/programs/fzf.nix

# TODO: Add options for integrations with other apps.
# E.g tmux, zsh etc.
# Review and add more cool integrations like zsh-fzf-tab, alot of nice stuff out there!
{
  flake.modules.homeManager.shell =
    { pkgs, ... }:
    {
      # deps
      home.packages = with pkgs; [
        fd
        sysz # fzf for systemctl
      ];

      programs = {
        fzf = {
          enable = true;
          enableZshIntegration = true;
          tmux.enableShellIntegration = true;
          tmux.shellIntegrationOptions = [ "-p80%,60%" ];
          fileWidgetOptions = [
            "--preview 'bat -n --color=always {}'"
            "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
          ];
          changeDirWidgetOptions = [ "--preview 'tree -C {}'" ];
          historyWidgetOptions = [
            "--preview 'echo {}' --preview-window up:3:hidden:wrap"
            "--bind 'ctrl-/:toggle-preview'"
            "--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
            "--color header:italic"
            "--header 'Press CTRL-Y to copy command into clipboard'"
          ];
          colors = {
            "bg" = "#1e1e2e";
            "bg+" = "#313244";
            "fg" = "#cdd6f4";
            "header" = "#f38ba8";
            "hl" = "#f38ba8";
            "info" = "#cba6f7";
            "pointer" = "#f5e0dc";
            "spinner" = "#f5e0dc";
          };

        };
      };
    };
}
