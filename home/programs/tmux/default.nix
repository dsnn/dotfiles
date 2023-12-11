{ pkgs, ... }: {
  imports = [ ./tmuxp ];

  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    reverseSplit = false;
    sensibleOnTop = false;
    terminal = "tmux-256color";
    resizeAmount = 10;
    historyLimit = 5000;
  };

  programs.tmux.plugins = with pkgs.tmuxPlugins; [
    better-mouse-mode
    yank
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

  programs.tmux.extraConfig = ''
    set -g status-interval 0
    set -g status-justify left
    set -g status-position top

    # don't exit from tmux when closing a session
    set -g detach-on-destroy off

    # disabled activity monitoring
    setw -g monitor-activity off
    set -g visual-activity off

    # disable programs change name
    set -g allow-rename off

    # synchronize all panes in a window
    bind y setw synchronize-panes

    # pane movement
    bind -r C-h select-window -t :-
    bind -r C-l select-window -t :+

    # open lazygit in a new window
    bind-key g display-popup -w "80%" -h "80%" -d "#{pane_current_path}" -E "lazygit"

    unbind s
    bind s display-popup -E "\
      tmux list-sessions -F '#{?session_attached,,#{session_name}} ' |\
      sed '/^\s*$/d' |\
      fzf --reverse --header jump-to-session |\
      xargs tmux switch-client -t"

    # vim-style copy-paste
    bind -n C-M-u copy-mode
    bind -n C-M-p paste-buffer
    bind -T copy-mode-vi v send-keys -X begin-selection
    bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    bind -T copy-mode-vi r send-keys -X rectangle-toggle
  '';
}
