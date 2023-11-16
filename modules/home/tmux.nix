{ config, pkgs, ... }: {

  programs.tmux.enable = true;

  home.packages = with pkgs; [ tmuxp ];
  home.file.".config/tmuxp".source = ./tmuxp;

  #  programs.tmuxp.enable = true;
  # programs.tmux.enableFzf = true;
  # programs.tmux.enableMouse = true;
  # programs.tmux.enableSensible = true;
  # programs.tmux.enableVim = true;
  # programs.tmux.iTerm2 = true;

  # ctrl following by this key is used as the main shortcut
  programs.tmux.shortcut = "a";

  # set the $TERM variable
  programs.tmux.terminal = "screen-256color";
  # programs.tmux.terminal = "tmux-256color";
  # programs.tmux.historyLimit = 100000;

  # vi  style shortcuts
  programs.tmux.keyMode = "vi";
  programs.tmux.clock24 = true;
  programs.tmux.baseIndex = 1;

  # time in milliseconds for which tmux waits after an escape is input 
  programs.tmux.escapeTime = 0;

  programs.tmux.plugins = with pkgs;
  [
    # tmux-nvim
    # tmuxPlugins.tmux-thumbs
    # TODO: why do I have to manually set this
    # {
    #   plugin = t-smart-manager;
    #   extraConfig = ''
    #     set -g @t-fzf-prompt '  '
    #     set -g @t-bind "T"
    #   '';
    # }
    # {
    #   plugin = tmux-super-fingers;
    #   extraConfig = "set -g @super-fingers-key f";
    # }
    # {
    #   plugin = tmux-browser;
    #   extraConfig = ''
    #     set -g @browser_close_on_deattach '1'
    #   '';
    # }

    tmuxPlugins.sensible
    # must be before continuum edits right status bar
    # {
    #   plugin = tmuxPlugins.catppuccin;
    #   extraConfig = '' 
    #     set -g @catppuccin_flavour 'frappe'
    #     set -g @catppuccin_window_tabs_enabled on
    #     set -g @catppuccin_date_time "%H:%M"
    #   '';
    # }
    {
      plugin = tmuxPlugins.resurrect;
      extraConfig = ''
        set -g @resurrect-strategy-vim 'session'
        set -g @resurrect-strategy-nvim 'session'
        set -g @resurrect-capture-pane-contents 'on'
      '';
    }
    {
      plugin = tmuxPlugins.continuum;
      extraConfig = ''
        set -g @continuum-restore 'on'
        set -g @continuum-boot 'on'
        set -g @continuum-save-interval '10'
      '';
    }
    # tmuxPlugins.better-mouse-mode
    # tmuxPlugins.yank
  ];


  programs.tmux.extraConfig = ''
    unbind C-b
    set-option -g prefix C-a
    bind-key C-a send-prefix
    
    set -g status-style 'bg=#000000 fg=#5eacd3'
    set -g status-right '%Y-%m-%d %H:%M'
    set -g base-index 1
    set -g mouse on
    set -g focus-events on
    set -s escape-time 0 # fix no delay on esc
    set -g allow-rename off
    set -g default-command zsh
    
    # reload configuration
    bind -n C-M-r source-file ~/.config/tmux/tmux.conf \; display '~/.tmux.conf sourced'
    
    # vim-style copy-paste
    bind -n C-M-u copy-mode
    bind -n C-M-p paste-buffer
    bind -T copy-mode-vi v send-keys -X begin-selection
    bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    bind -T copy-mode-vi r send-keys -X rectangle-toggle
    
    # navigate windows
    bind -n C-M-h previous-window
    bind -n C-M-l next-window
    
    # switch panes
    bind -n M-h select-pane -L
    bind -n M-j select-pane -D
    bind -n M-k select-pane -U
    bind -n M-l select-pane -R
    
    # resize panes
    bind -n M-H resize-pane -L 10
    bind -n M-J resize-pane -D 10
    bind -n M-K resize-pane -U 10
    bind -n M-L resize-pane -R 10
    
    # create new window
    bind -n C-M-n neww
    
    # kill pane / window
    bind -n C-M-q killp
    
    # create splits
    bind -n C-M-v split-window -h -c "#{pane_current_path}"
    bind -n C-M-s split-window -v -c "#{pane_current_path}"
    
    # zoom current pane
    bind -n C-M-f resize-pane -Z
    
    # tmux session picker
    bind -n M-i choose-window -sNZ
    
    # restore last env
    set -g @continuum-restore 'on'
    
    # resurrect env save files
    # set -g @resurrect-dir '$HOME/.config/tmux/resurrect'
    
    # resurrect additional programs
    # set -g @resurrect-processes 'lazygit'
    # set -g @resurrect-processes 'mosh-client'
    
    set -g @plugin 'tmux-plugins/tmux-resurrect'
    set -g @plugin 'tmux-plugins/tmux-continuum'
    # set -g @plugin 'tmux-plugins/tpm'
    # run '~/.config/tmux/plugins/tpm/tpm'
        '';

}
