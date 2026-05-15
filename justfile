set shell := ["bash", "-cu"]

# --------------------------------------------------
# CORE PATHS (ALDRIG env_var i recipes)
# --------------------------------------------------

HOME := env_var("HOME")
DOTFILES := HOME + "/dotfiles"
CONFIG := HOME + "/.config"
LOCAL := HOME + "/.local"
BIN := LOCAL + "/bin"

# --------------------------------------------------
# DEFAULT
# --------------------------------------------------

[group("core")]
default:
    @just --list --unsorted

[group("core")]
bootstrap: zsh starship git lazygit
    @echo "✓ dotfiles bootstrap complete"

# --------------------------------------------------
# Dotfiles
# --------------------------------------------------

[group('dotfiles')]
zsh:
    mkdir -p {{ CONFIG }}/zsh
    ln -sf {{ DOTFILES }}/zsh/zshrc {{ CONFIG }}/zsh/.zshrc
    ln -sf {{ DOTFILES }}/zsh/zshenv {{ HOME }}/.zshenv

    mkdir -p {{ CONFIG }}/zsh/completions
    volta completions zsh > {{HOME}}/.config/zsh/completions/_volta

[group('dotfiles')]
git:
    mkdir -p {{ CONFIG }}/git
    ln -sf {{ DOTFILES }}/git/config {{ CONFIG }}/git/config
    ln -sf {{ DOTFILES }}/git/ignore {{ CONFIG }}/git/ignore

[group('dotfiles')]
starship:
    ln -sf {{ DOTFILES }}/starship {{ CONFIG }}/starship.toml

[group('dotfiles')]
lazygit:
    mkdir -p {{ CONFIG }}/lazygit
    ln -sf {{ DOTFILES }}/lazygit.yml {{ CONFIG }}/lazygit/config.yml

[group('dotfiles')]
i3:
    mkdir -p {{ CONFIG }}/i3
    ln -sf {{ DOTFILES }}/i3/config {{ CONFIG }}/i3/config

[group('dotfiles')]
polybar:
    mkdir -p {{ CONFIG }}/polybar
    chmod +x {{ DOTFILES }}/polybar/launch
    ln -sf {{ DOTFILES }}/polybar/config {{ CONFIG }}/polybar/config
    ln -snf {{ DOTFILES }}/polybar/launch {{ CONFIG }}/polybar/launch.sh

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
    ln -sf {{ DOTFILES }}/tmux/config {{ CONFIG }}/tmux/.tmux.conf

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
