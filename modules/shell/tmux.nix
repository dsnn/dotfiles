{
  flake.modules.homeManager.shell =
    { pkgs, ... }:
    {
      programs.tmux = {
        enable = true;
        keyMode = "vi";
        shortcut = "a";
        shell = "${pkgs.zsh}/bin/zsh";
        baseIndex = 1;
        mouse = true;
        escapeTime = 0;
        disableConfirmationPrompt = true;
        clock24 = true;
        focusEvents = false;
        aggressiveResize = true;
        historyLimit = 1000000;
        terminal = "xterm-256color";
        extraConfig = ''
          bind -n -N "Send the prefix key through to the application" \
            C-a send-prefix

          bind-key -N "Kill the current window" & kill-window
          bind-key -N "Kill the current pane" x kill-pane

          # update status line every X seconds
          set -g status-interval 0

          # status line position
          set -g status-justify left
          set -g status-position top

           # this is for 256 color
          set -ga terminal-overrides ',*:Tc'

           # this is for the cursor shape
          set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'

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
          bind 'h' split-window -c "#{pane_current_path}"
          bind 'v' split-window -h -c "#{pane_current_path}"

          # vim-style copy-paste
          bind -n C-M-u copy-mode
          bind -n C-M-p paste-buffer
          bind -T copy-mode-vi v send-keys -X begin-selection
          bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
          bind -T copy-mode-vi r send-keys -X rectangle-toggle

          # sesh last session
          bind -N "last-session (via sesh) " L run-shell "sesh last"

          # sesh fzf tmux
          bind-key "K" run-shell "sesh connect \"$(
              sesh list --icons --hide-duplicates | fzf-tmux -p 100%,100% --no-border \
                --ansi \
                --list-border \
                --no-sort --prompt '⚡  ' \
                --color 'list-border:6,input-border:3,preview-border:4,header-bg:-1,header-border:6' \
                --input-border \
                --header-border \
                --bind 'tab:down,btab:up' \
                --bind 'ctrl-b:abort' \
                --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
                --bind 'ctrl-t:change-prompt(  )+reload(sesh list -t --icons)' \
                --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
                --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
                --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
                --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
                --preview-window 'right:70%' \
                --preview 'sesh preview {}' \
            )\""

        '';
        plugins = with pkgs; [
          {
            plugin = tmuxPlugins.catppuccin;
            extraConfig = ''
              set -g @catppuccin_flavour 'mocha'
              set -g @catppuccin_window_tabs_enabled on
              set -g @catppuccin_status_modules_right "application session"
            '';
          }
          {
            plugin = tmuxPlugins.tilish;
            extraConfig = "
                set -g @plugin 'jabirali/tmux-tilish'
            ";
          }
          {
            plugin = tmuxPlugins.tmux-fzf;
            extraConfig = ''
              TMUX_FZF_LAUNCH_KEY="f"
            '';
          }
          {
            plugin = tmuxPlugins.vim-tmux-navigator;
            extraConfig = ''
              set -g @plugin 'christoomey/vim-tmux-navigator'
              set -g @tilish-navigator 'on'
            '';
          }
        ];
      };
    };
}
