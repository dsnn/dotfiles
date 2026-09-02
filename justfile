set shell := ["bash", "-euo", "pipefail", "-c"]

# Resolve paths once. The repository may be cloned somewhere other than ~/dotfiles,
# and XDG_CONFIG_HOME should be respected when it is set.
HOME_DIR := env_var("HOME")
DOTFILES := justfile_directory()
CONFIG := env_var_or_default("XDG_CONFIG_HOME", HOME_DIR + "/.config")
OS := `uname -s`

# --------------------------------------------------
# Core
# --------------------------------------------------

[group("core")]
default:
    @just --list --unsorted

[group("core")]
bootstrap: zsh inputrc starship git ssh tmux bat lazygit lsd bottom htop nvim rider
    @echo "✓ dotfiles bootstrap complete ({{ OS }})"

[group("core")]
check: _check_ideavim _check_tmux _check_nvim
    @just --fmt --check --unstable
    @zsh -n "{{ DOTFILES }}/zsh/zshenv" "{{ DOTFILES }}/zsh/zprofile" "{{ DOTFILES }}/zsh/zshrc"
    @ssh -G -T -F "{{ DOTFILES }}/ssh/config" github.com >/dev/null
    @git config --file "{{ DOTFILES }}/git/config" --list >/dev/null
    @INPUTRC="{{ DOTFILES }}/inputrc" bash --noprofile --norc -c 'set -o emacs; bind -f "$INPUTRC"' 2>/dev/null
    @TERM=xterm-256color STARSHIP_CONFIG="{{ DOTFILES }}/starship" STARSHIP_CACHE="${TMPDIR:-/tmp}/dotfiles-starship-cache" starship prompt >/dev/null
    @bat --config-file "{{ DOTFILES }}/bat/config" --style=plain --color=never "{{ DOTFILES }}/bat/config" >/dev/null
    @bat --list-themes | rg -qx 'Catppuccin Mocha'
    @htop --version >/dev/null
    @echo "✓ configuration syntax checks passed"

[private]
_check_ideavim:
    #!/usr/bin/env bash
    set -euo pipefail

    config='{{ DOTFILES }}/ideavimrc'

    if rg -n '^\s*(map|nmap|xmap|nnoremap|xnoremap)\s+\S+\s+:action\s' "$config"; then
      printf 'error: use <Action>(...) instead of :action in IdeaVim mappings\n' >&2
      exit 1
    fi

    if rg -n '^\s*(noremap|nnoremap|xnoremap)\s+\S+\s+.*<Action>\(' "$config"; then
      printf 'error: IdeaVim <Action> mappings do not support noremap\n' >&2
      exit 1
    fi

    awk '
      $1 == "map" || $1 == "nmap" || $1 == "nnoremap" {
        if (++normal[$2] > 1) {
          printf "duplicate normal-mode mapping: %s\n", $2 > "/dev/stderr"
          failed = 1
        }
      }
      $1 == "map" || $1 == "xmap" || $1 == "xnoremap" {
        if (++visual[$2] > 1) {
          printf "duplicate visual-mode mapping: %s\n", $2 > "/dev/stderr"
          failed = 1
        }
      }
      /^let g:WhichKeyDesc_/ {
        description = $0
        sub(/^[^"]*"/, "", description)
        split(description, fields, /[[:space:]]+/)
        if (++which_key[fields[1]] > 1) {
          printf "duplicate which-key description: %s\n", fields[1] > "/dev/stderr"
          failed = 1
        }
      }
      END { exit failed }
    ' "$config"

[private]
_check_tmux:
    #!/usr/bin/env bash
    set -euo pipefail

    socket_dir="$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-tmux.XXXXXX")"
    socket="$socket_dir/socket"

    cleanup() {
      tmux -S "$socket" kill-server >/dev/null 2>&1 || true
      rmdir "$socket_dir" >/dev/null 2>&1 || true
    }
    trap cleanup EXIT

    tmux -S "$socket" -f '{{ DOTFILES }}/tmux/config' new-session -d -s dotfiles-check

[private]
_check_nvim:
    #!/usr/bin/env bash
    set -euo pipefail

    files=(
      '{{ DOTFILES }}/nvim/init.lua'
      '{{ DOTFILES }}/nvim/lua/config/'*.lua
      '{{ DOTFILES }}/nvim/lua/plugins/'*.lua
    )

    for file in "${files[@]}"; do
      nvim --clean --headless -i NONE "+lua assert(loadfile([[$file]]))" '+qa!'
    done

# Create or update a managed symlink without overwriting unique local content.
[private]
_link source target:
    #!/usr/bin/env bash
    set -euo pipefail

    source='{{ source }}'
    target='{{ target }}'

    if [[ ! -e "$source" ]]; then
      printf 'error: source does not exist: %s\n' "$source" >&2
      exit 1
    fi

    mkdir -p "$(dirname "$target")"

    if [[ -L "$target" ]]; then
      if [[ "$(readlink "$target")" == "$source" ]]; then
        printf '✓ already linked: %s\n' "$target"
      else
        ln -sfn "$source" "$target"
        printf '✓ relinked: %s -> %s\n' "$target" "$source"
      fi
    elif [[ -f "$source" && -f "$target" ]] && cmp -s "$source" "$target"; then
      ln -sfn "$source" "$target"
      printf '✓ adopted identical file: %s -> %s\n' "$target" "$source"
    elif [[ -e "$target" ]]; then
      printf 'error: refusing to overwrite existing path: %s\n' "$target" >&2
      printf 'move it aside and run the recipe again\n' >&2
      exit 1
    else
      ln -s "$source" "$target"
      printf '✓ linked: %s -> %s\n' "$target" "$source"
    fi

# --------------------------------------------------
# Dotfiles
# --------------------------------------------------

[group("dotfiles")]
zsh: (_link (DOTFILES + "/zsh/zshrc") (CONFIG + "/zsh/.zshrc")) (_link (DOTFILES + "/zsh/zprofile") (CONFIG + "/zsh/.zprofile")) (_link (DOTFILES + "/zsh/zshenv") (HOME_DIR + "/.zshenv"))

[group("dotfiles")]
inputrc: (_link (DOTFILES + "/inputrc") (HOME_DIR + "/.inputrc"))

[group("dotfiles")]
starship: (_link (DOTFILES + "/starship") (CONFIG + "/starship.toml"))

[group("dotfiles")]
git: (_link (DOTFILES + "/git/config") (CONFIG + "/git/config")) (_link (DOTFILES + "/git/ignore") (CONFIG + "/git/ignore"))

[group("dotfiles")]
ssh: (_link (DOTFILES + "/ssh/config") (HOME_DIR + "/.ssh/config"))
    @mkdir -p "{{ HOME_DIR }}/.ssh/controlmasters" "{{ HOME_DIR }}/.ssh/private"
    @chmod 700 "{{ HOME_DIR }}/.ssh" "{{ HOME_DIR }}/.ssh/controlmasters" "{{ HOME_DIR }}/.ssh/private"
    @chmod 600 "{{ DOTFILES }}/ssh/config"
    @echo "✓ SSH config linked and directories secured"

[group("dotfiles")]
tmux: (_link (DOTFILES + "/tmux/config") (CONFIG + "/tmux/tmux.conf"))
    #!/usr/bin/env bash
    set -euo pipefail

    mkdir -p '{{ CONFIG }}/tmux/plugins'
    tpm='{{ CONFIG }}/tmux/plugins/tpm'
    if [[ ! -x "$tpm/tpm" ]]; then
      if [[ -e "$tpm" ]]; then
        printf 'error: incomplete TPM installation: %s\n' "$tpm" >&2
        exit 1
      fi
      git clone --depth 1 https://github.com/tmux-plugins/tpm "$tpm"
      printf '✓ installed TPM: %s\n' "$tpm"
    else
      printf '✓ TPM already installed: %s\n' "$tpm"
    fi

[group("dotfiles")]
bat: (_link (DOTFILES + "/bat/config") (CONFIG + "/bat/config"))
    #!/usr/bin/env bash
    set -euo pipefail

    legacy_theme='{{ CONFIG }}/bat/themes/Catppuccin Mocha.tmTheme'
    managed_target='{{ DOTFILES }}/bat/themes/Catppuccin Mocha.tmTheme'
    if [[ -L "$legacy_theme" && "$(readlink "$legacy_theme")" == "$managed_target" ]]; then
      unlink "$legacy_theme"
      bat cache --build >/dev/null
      printf '✓ removed obsolete bat theme symlink; using built-in Catppuccin Mocha\n'
    fi

[group("dotfiles")]
lazygit: (_link (DOTFILES + "/lazygit") (CONFIG + "/lazygit/config.yml"))

[group("dotfiles")]
lsd: (_link (DOTFILES + "/lsd") (CONFIG + "/lsd/config.yaml"))

[group("dotfiles")]
bottom: (_link (DOTFILES + "/bottom") (CONFIG + "/bottom/bottom.toml"))

[group("dotfiles")]
htop: (_link (DOTFILES + "/htop") (CONFIG + "/htop/htoprc"))

[group("dotfiles")]
rider: (_link (DOTFILES + "/ideavimrc") (HOME_DIR + "/.ideavimrc"))

[group("dotfiles")]
nvim: (_link (DOTFILES + "/nvim") (CONFIG + "/nvim"))

[group("dotfiles")]
[linux]
x11: (_link (DOTFILES + "/x11/xinitrc") (HOME_DIR + "/.xinitrc")) (_link (DOTFILES + "/x11/xinitrc") (HOME_DIR + "/.Xclients")) (_link (DOTFILES + "/x11/Xresources") (HOME_DIR + "/.Xresources"))
    @chmod +x "{{ DOTFILES }}/x11/xinitrc"

[group("dotfiles")]
[linux]
rofi: (_link (DOTFILES + "/rofi") (CONFIG + "/rofi/config.rasi"))

[group("dotfiles")]
[linux]
picom: (_link (DOTFILES + "/picom") (CONFIG + "/picom/picom.conf"))

# --------------------------------------------------
# System
# --------------------------------------------------

[group("system")]
[linux]
pacman:
    sudo ln -sfn "{{ DOTFILES }}/arch/pacman.conf" /etc/pacman.conf

[group("system")]
[linux]
systemd:
    sudo ln -sfn "{{ DOTFILES }}/arch/systemd/paccache.service" /etc/systemd/system/paccache.service
    sudo ln -sfn "{{ DOTFILES }}/arch/systemd/paccache.timer" /etc/systemd/system/paccache.timer
    sudo ln -sfn "{{ DOTFILES }}/arch/systemd/reflector.service" /etc/systemd/system/reflector.service
    sudo ln -sfn "{{ DOTFILES }}/arch/systemd/reflector.timer" /etc/systemd/system/reflector.timer
    sudo systemctl daemon-reload
    sudo systemctl enable --now paccache.timer reflector.timer

# --------------------------------------------------
# Services
# --------------------------------------------------

[group("services")]
sys:
    sysz

[group("services")]
[linux]
list-inactive:
    systemctl list-units --all --state=inactive

[group("services")]
[linux]
list-failed:
    systemctl list-units --all --state=failed
