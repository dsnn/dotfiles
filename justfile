set shell := ["bash", "-cu"]

# --------------------------------------------------
# CORE PATHS (ALDRIG env_var i recipes)
# --------------------------------------------------

HOME := env_var("HOME")
DOTFILES := HOME + "/dotfiles"
CONFIG := HOME + "/.config"
LOCAL := HOME + "/.local"
BIN := LOCAL + "/bin"
WORK:= HOME + "/projects/work"
OS := `uname -s`

# --------------------------------------------------
# DEFAULT
# --------------------------------------------------

[group("core")]
default:
    @just --list --unsorted

[group("core")]
bootstrap: zsh starship git ssh tmux bat lsd bottom
    @echo "✓ dotfiles bootstrap complete ({{ OS }})"

# --------------------------------------------------
# Dotfiles
# --------------------------------------------------

[group('dotfiles')]
zsh:
    mkdir -p {{ CONFIG }}/zsh
    ln -sf {{ DOTFILES }}/zsh/zshrc {{ CONFIG }}/zsh/.zshrc
    ln -sf {{ DOTFILES }}/zsh/zshenv {{ HOME }}/.zshenv

#    if command -v volta >/dev/null 2>&1; then
#        volta completions zsh > {{ DOTFILES }}/zsh/completions/_volta
#    else
#        echo "volta not found; skipping _volta completion generation"
#    fi

#    if command -v sesh >/dev/null 2>&1; then
#        sesh completion zsh > {{ DOTFILES }}/zsh/completions/_sesh
#    else
#        echo "sesh not found; skipping _sesh completion generation"
#    fi
#    ln -sf {{ DOTFILES }}/zsh/completions {{ CONFIG }}/zsh/completions

[group('dotfiles')]
git:
    mkdir -p {{ CONFIG }}/git
    ln -sf {{ DOTFILES }}/git/config {{ CONFIG }}/git/config
    ln -sf {{ DOTFILES }}/git/ignore {{ CONFIG }}/git/ignore


[group('dotfiles')]
starship:
    ln -sf {{ DOTFILES }}/starship {{ CONFIG }}/starship.toml

[group('dotfiles')]
ssh:
    # Ensure SSH dirs exist
    mkdir -p {{ HOME }}/.ssh
    mkdir -p {{ HOME }}/.ssh/controlmasters

    # Symlink config from dotfiles (symlink, treat as normal file, force)
    ln -snf {{ DOTFILES }}/ssh/config {{ HOME }}/.ssh/config

    # Permissions (IMPORTANT: only real files/dirs, not symlinks)
    chmod 700 {{ HOME }}/.ssh
    chmod 700 {{ HOME }}/.ssh/controlmasters
    chmod 600 {{ HOME }}/.ssh/config

    # Fix key permissions (if present)
    find {{ HOME }}/.ssh -type f -name "id_*" ! -name "*.pub" -exec chmod 600 {} \;
    find {{ HOME }}/.ssh -type f -name "*.pub" -exec chmod 644 {} \;

    echo "SSH config linked + permissions applied"

[group('dotfiles')]
tmux:
    mkdir -p {{ CONFIG }}/tmux/plugins
    ln -sf {{ DOTFILES }}/tmux/config {{ CONFIG }}/tmux/tmux.conf

[group('dotfiles')]
x11:
    chmod +x {{ DOTFILES }}/x11/xinitrc
    ln -snf {{ DOTFILES }}/x11/xinitrc {{ HOME }}/.xinitrc
    ln -snf {{ DOTFILES }}/x11/xinitrc {{ HOME }}/.Xclients
    ln -snf {{ DOTFILES }}/x11/Xresources {{ HOME }}/.Xresources

[group('dotfiles')]
rofi:
    mkdir -p {{ CONFIG }}/rofi
    ln -sf {{ DOTFILES }}/rofi {{ CONFIG }}/rofi/config.rasi

[group('dotfiles')]
picom:
    mkdir -p {{ CONFIG }}/picom
    ln -sf {{ DOTFILES }}/picom {{ CONFIG }}/picom/picom.conf

[group('dotfiles')]
bat:
    mkdir -p {{ CONFIG }}/bat
    ln -sf {{ DOTFILES }}/bat/config {{ CONFIG }}/bat/config
    ln -sf {{ DOTFILES }}/bat/themes {{ CONFIG }}/bat/themes

[group('dotfiles')]
lsd:
    mkdir -p {{ CONFIG }}/lsd
    ln -sf {{ DOTFILES }}/lsd {{ CONFIG }}/lsd/config.yaml

[group('dotfiles')]
bottom:
    mkdir -p {{ CONFIG }}/bottom
    ln -sf {{ DOTFILES }}/bottom {{ CONFIG }}/bottom/bottom.toml

[group('dotfiles')]
htop:
    mkdir -p {{ CONFIG }}/htop
    ln -sf {{ DOTFILES }}/htop {{ CONFIG }}/htop/htoprc

[group('dotfiles')]
rider:
    ln -sf {{ DOTFILES }}/ideavimrc {{ HOME}}/.ideavimrc


# --------------------------------------------------
# System
# --------------------------------------------------

[group('system')]
pacman:
    sudo ln -sf {{ DOTFILES }}/arch/pacman.conf /etc/pacman.conf

[group('system')]
systemd:
    sudo ln -sf {{ DOTFILES }}/arch/systemd/paccache.service /etc/systemd/system/paccache.service
    sudo ln -sf {{ DOTFILES }}/arch/systemd/paccache.timer /etc/systemd/system/paccache.timer
    sudo ln -sf {{ DOTFILES }}/arch/systemd/reflector.service /etc/systemd/system/reflector.service
    sudo ln -sf {{ DOTFILES }}/arch/systemd/reflector.timer /etc/systemd/system/reflector.timer

    # enable timers
    sudo systemctl enable --now paccache.timer
    sudo systemctl enable --now reflector.timer

    # reload systemd
    sudo systemctl daemon-reload

# --------------------------------------------------
# Services
# --------------------------------------------------

[group('services')]
sys:
    sysz

[group('services')]
[linux]
list-inactive:
    systemctl list-units -all --state=inactive

[group('services')]
[linux]
list-failed:
    systemctl list-units -all --state=failed
