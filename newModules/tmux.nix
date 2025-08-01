# https://github.com/jabirali/tmux-tilish
{
  lib,
  pkgs,
  ...
}:
with lib;
let
  tmux-smart-session-manager = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "t-smart-tmux-session-manager";
    version = "unstable-2023-10-23";
    rtpFilePath = "t-smart-tmux-session-manager.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "t-smart-tmux-session-manager";
      rev = "01b60128b4bebeedd7dc3a4b95d3257f70d4a417";
      sha256 = "0l+2ZRj9knjDRUiGePTt14UxrI0FNVHIdIZtKZs8bek=";
    };
  };
in
{

  flake.modules.home.tmux = {
    programs = {
      zsh.initContent = ''
        export PATH=${tmux-smart-session-manager}/share/tmux-plugins/t-smart-tmux-session-manager/bin/:$PATH
      '';

      tmux = {
        enable = true;
        aggressiveResize = true;
        baseIndex = 1;
        clock24 = true;
        customPaneNavigationAndResize = false;
        disableConfirmationPrompt = true;
        escapeTime = 0;
        keyMode = "vi";
        mouse = true;
        prefix = "C-a";
        reverseSplit = false;
        sensibleOnTop = false;
        terminal = "xterm-256color";
        resizeAmount = 10;
        historyLimit = 5000;

        plugins = with pkgs.tmuxPlugins; [
          better-mouse-mode
          yank
          {
            plugin = tmux-smart-session-manager;
            extraConfig = ''
              set -g @t-fzf-prompt '  '
              set -g @t-fzf-default-results 'sessions'
              set -g @t-bind "space"
            '';
          }
          {
            plugin = tmux-thumbs;
            extraConfig = ''
              set -g @plugin 'fcsonline/tmux-thumbs'
              set -g @thumbs-command 'echo -n {} | pbcopy' # copy to clipboard
              set -g @thumbs-key C
              set -g @thumbs-contrast 1
            '';
          }
          {
            plugin = fzf-tmux-url;
            extraConfig = ''
              set -g @plugin 'wfxr/tmux-fzf-url'
              set -g @fzf-url-bind 'u'
              set -g @fzf-url-history-limit '2000'
              set -g @fzf-url-fzf-options '-w 50% -h 50% --multi -0 --no-preview --no-border'
            '';
          }
          {
            plugin = tilish;
            extraConfig = ''
              set -g @plugin 'jabirali/tmux-tilish'
            '';
          }
          {
            plugin = vim-tmux-navigator;
            extraConfig = ''
              set -g @plugin 'christoomey/vim-tmux-navigator'
              set -g @tilish-navigator 'on'
            '';
          }
          {
            plugin = tmux-fzf;
            extraConfig = ''
              TMUX_FZF_LAUNCH_KEY="f"
            '';
          }
          {
            plugin = catppuccin;
            extraConfig = ''
              set -g @catppuccin_flavour 'mocha'
              set -g @catppuccin_window_tabs_enabled on
              set -g @catppuccin_status_modules_right "application session"
            '';
          }
        ];

        extraConfig = ''
          set -g status-interval 0
          set -g status-justify left
          set -g status-position top

            set -ga terminal-overrides ',*:Tc' # this is for 256 color
          set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q' # this is for the cursor shape

          # don't exit from tmux when closing a session
          set -g detach-on-destroy off

          # disabled activity monitoring
          setw -g monitor-activity off
          set -g visual-activity off

          # disable programs change name
          set -g allow-rename off

          # open lazygit in a new window
          bind-key g display-popup -w "80%" -h "80%" -d "#{pane_current_path}" -E "lazygit"

          # synchronize all panes in a window
          bind -n C-M-y setw synchronize-panes

          # Set new panes to open in current directory
          bind c new-window -c "#{pane_current_path}"
          bind 's' split-window -c "#{pane_current_path}"
          bind 'v' split-window -h -c "#{pane_current_path}"

          # vim-style copy-paste
          bind -n C-M-u copy-mode
          bind -n C-M-p paste-buffer
          bind -T copy-mode-vi v send-keys -X begin-selection
          bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
          bind -T copy-mode-vi r send-keys -X rectangle-toggle
        '';
      };
    };
  };
}
