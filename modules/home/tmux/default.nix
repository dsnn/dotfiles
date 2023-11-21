{ config, pkgs, ... }:
let
  t-smart-manager = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "t-smart-tmux-session-manager";
    version = "unstable-2023-09-20";
    rtpFilePath = "t-smart-tmux-session-manager.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "t-smart-tmux-session-manager";
      rev = "63360755451a1d536f5847b3a3dc41bb3050b10c";
      sha256 = "00051slyy55qdxf0l41kfw6sr46nm2br31hdkwpy879ia5acligi";
    };
  };
  tmux-super-fingers = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-super-fingers";
    version = "unstable-2023-09-04";
    src = pkgs.fetchFromGitHub {
      owner = "artemave";
      repo = "tmux_super_fingers";
      rev = "19945b066ecea03165231d45a73ec0862a1e5e03";
      sha256 = "0vgh1nc2l5lsp2gwl0kbd9bxr3acj5g647p9522f5yzlhw7sbr33";
    };
  };
in {

  home.packages = with pkgs; [ tmuxp lsof ];
  home.file.".config/tmuxp".source = ./tmuxp;

  programs.zsh.initExtra = ''
    # tmux
    export PATH=${t-smart-manager}/share/tmux-plugins/t-smart-tmux-session-manager/bin/:$PATH

    # tmuxp
    export TMUXP_CONFIGDIR=$HOME/.config/tmuxp
  '';

  programs.tmux.enable = true;
  programs.tmux.terminal = "tmux-256color";
  programs.tmux.shortcut = "a";
  programs.tmux.prefix = "C-a";
  programs.tmux.historyLimit = 100000;
  programs.tmux.keyMode = "vi";
  programs.tmux.clock24 = true;
  programs.tmux.baseIndex = 1;
  programs.tmux.escapeTime = 0;
  programs.tmux.sensibleOnTop = true;
  programs.tmux.mouse = true;

  programs.tmux.plugins = with pkgs.tmuxPlugins;
  [
    better-mouse-mode
    yank
    tmux-thumbs
    sensible
    {
      plugin = t-smart-manager;
      extraConfig = ''
        set -g @t-fzf-prompt '  '
        set -g @t-bind "T"

        # skip "kill-pane 1? (y/n)" prompt
        bind-key x kill-pane

      '';
    }
    {
      plugin = tmux-super-fingers;
      extraConfig = "set -g @super-fingers-key f";
    }
    {
      plugin = resurrect;
      extraConfig = ''
        set -g @resurrect-strategy-vim 'session'
        set -g @resurrect-strategy-nvim 'session'
        set -g @resurrect-capture-pane-contents 'on'
        # set -g @resurrect-processes 'lazygit'
        # set -g @resurrect-processes 'mosh-client'
      '';
    }
    {
      plugin = continuum;
      extraConfig = ''
        set -g @continuum-restore 'on'
        set -g @continuum-boot 'on'
        set -g @continuum-save-interval '10'
        set -g @continuum-systemd-start-cmd 'start-server'
      '';
    }
  ];


  programs.tmux.extraConfig = ''
    unbind C-b
    set-option -g prefix C-a
    bind-key C-a send-prefix

    set -g status-style 'bg=#000000 fg=#5eacd3'
    set -g status-right '%Y-%m-%d %H:%M'
    set -g mouse on
    set -g focus-events on
    set -g detach-on-destroy off  # don't exit from tmux when closing a session
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

    set -g @plugin 'tmux-plugins/tmux-resurrect'
    set -g @plugin 'tmux-plugins/tmux-continuum'
  '';

}
