{ config, pkgs, ... }:
let
  t-smart-manager = pkgs.tmuxPlugins.mkTmuxPlugin {
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

  # t-mem-cpu-load = pkgs.tmuxPlugins.mkTmuxPlugin {
  #   pluginName = "tmux-mem-cpu-load";
  #   version = "tmux-mem-cpu-load 3.8.0";
  #   rtpFilePath = "tmux-mem-cpu-load.plugin.tmux";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "thewtex";
  #     repo = "tmux-mem-cpu-load";
  #     rev = "451300eda243251b60d13da6d028b9ff4e8b92cb";
  #     sha256 = "";
  #   };
  # };
in {

  programs.zsh.initExtra = ''
    export PATH=${t-smart-manager}/share/tmux-plugins/t-smart-tmux-session-manager/bin/:$PATH
  '';

  programs.tmux.enable = true;
  programs.tmux.baseIndex = 1;
  programs.tmux.clock24 = true;
  programs.tmux.disableConfirmationPrompt = true;
  programs.tmux.escapeTime = 0;
  programs.tmux.historyLimit = 10000;
  programs.tmux.keyMode = "vi";
  programs.tmux.mouse = true;
  programs.tmux.prefix = "C-a";
  programs.tmux.reverseSplit = false;
  programs.tmux.sensibleOnTop = true;
  programs.tmux.terminal = "tmux-256color";

  programs.tmux.plugins = with pkgs.tmuxPlugins;
  [
    better-mouse-mode
    yank
    {

      # TODO: set -g @tilish-dmenu 'on' does not work, make your own implm.
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
      # TODO: does it work? https://github.com/sainnhe/tmux-fzf#key-binding
      extraConfig = ''
        TMUX_FZF_LAUNCH_KEY="f"
      '';
    }
    {
      plugin = catppuccin;
      extraConfig = ''
        set -g @catppuccin_flavour 'mocha'
      '';
    }
    # {
    #   plugin = t-mem-cpu-load;
    #   extraConfig = ''
    #     set -g @plugin 'thewtex/tmux-mem-cpu-load'
    #     set -g status-interval 2
    #     set -g status-left "#S #[fg=green,bg=black]#(tmux-mem-cpu-load --colors --interval 2)#[default]"
    #     set -g status-left-length 60
    #   '';
    # }
    {
      plugin = t-smart-manager;
      extraConfig = ''
        set -g @t-fzf-prompt '  '
        set -g @t-fzf-default-results 'sessions'
        set -g @t-bind "space"
      '';
    }
    {
      plugin = resurrect;
      extraConfig = ''
        set -g @resurrect-strategy-vim 'session'
        set -g @resurrect-strategy-nvim 'session'
        set -g @resurrect-capture-pane-contents 'on'
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
       # navigate windows
       bind -n C-M-h previous-window
       bind -n C-M-l next-window

       set-option -g status-position top
   '';

  # programs.tmux.extraConfig = ''
  #   unbind C-b
  #   set-option -g prefix C-a
  #   bind-key C-a send-prefix

  #   set -g status-style 'bg=#000000 fg=#5eacd3'
  #   set -g status-right '%Y-%m-%d %H:%M'
  #   set -g mouse on
  #   set -g focus-events on
  #   set -g detach-on-destroy off  # don't exit from tmux when closing a session
  #   set -g allow-rename off
  #   set -g default-command zsh

  #   # reload configuration
  #   bind -n C-M-r source-file ~/.config/tmux/tmux.conf \; display '~/.tmux.conf sourced'

  #   # vim-style copy-paste
  #   bind -n C-M-u copy-mode
  #   bind -n C-M-p paste-buffer
  #   bind -T copy-mode-vi v send-keys -X begin-selection
  #   bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
  #   bind -T copy-mode-vi r send-keys -X rectangle-toggle

  #   # navigate windows
  #   bind -n C-M-h previous-window
  #   bind -n C-M-l next-window

  #   # switch panes
  #   bind -n M-h select-pane -L
  #   bind -n M-j select-pane -D
  #   bind -n M-k select-pane -U
  #   bind -n M-l select-pane -R

  #   # resize panes
  #   bind -n M-H resize-pane -L 10
  #   bind -n M-J resize-pane -D 10
  #   bind -n M-K resize-pane -U 10
  #   bind -n M-L resize-pane -R 10

  #   # create new window
  #   bind -n C-M-n neww

  #   # kill pane / window
  #   bind -n C-M-q killp

  #   # create splits
  #   bind -n C-M-v split-window -h -c "#{pane_current_path}"
  #   bind -n C-M-s split-window -v -c "#{pane_current_path}"

  #   # zoom current pane
  #   bind -n C-M-f resize-pane -Z

  #   # tmux session picker
  #   bind -n M-i choose-window -sNZ

  #   # restore last env
  #   set -g @continuum-restore 'on'

  #   # resurrect env save files
  #   # set -g @resurrect-dir '$HOME/.config/tmux/resurrect'

  #   TMUX_FZF_LAUNCH_KEY="f"

  #   set -g @plugin 'tmux-plugins/tmux-resurrect'
  #   set -g @plugin 'tmux-plugins/tmux-continuum'
  # '';

}
