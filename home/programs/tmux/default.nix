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

    set -g allow-rename off
    set -g default-command zsh

    # vim-style copy-paste
    bind -n C-M-u copy-mode
    bind -n C-M-p paste-buffer
    bind -T copy-mode-vi v send-keys -X begin-selection
    bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    bind -T copy-mode-vi r send-keys -X rectangle-toggle
  '';
}
