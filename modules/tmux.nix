{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    shortcut = "t";
    terminal = "screen-256color";
    keyMode = "vi";
    escapeTime = 0;
    extraConfig = ''
      unbind C-b
      set-option -g prefix C-a
      bind-key C-a send-prefix

      set -g status-style 'bg=#000000 fg=#5eacd3'
      set -g base-index 1
      set -g mouse on
      set -g focus-events on

      # vim-style copy-paste
      bind u copy-mode
      bind p paste-buffer
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      # bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
      bind -T copy-mode-vi r send-keys -X rectangle-toggle

      # copy also to clipboard
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -sel clip -i"

      # pane movement shortcuts
      bind -r ^ last-window
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R

      bind -r C-h select-window -t :-
      bind -r C-l select-window -t :+

      # Use alt to switch panes
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D 
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      # resize pane shortcuts
      bind -r H resize-pane -L 10
      bind -r J resize-pane -D 10
      bind -r K resize-pane -U 10
      bind -r L resize-pane -R 10
          '';
  };
}
