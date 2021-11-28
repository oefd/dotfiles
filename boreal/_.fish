#!/usr/bin/env fish
# ex: et sw=4 ts=4

source "lib/_lib.fish"


##############
# sys config #
##############
__pacman \
    bash-completion \
    base-devel \
    python3 \
    ripgrep \
    neovim \
    man-db \
    acpi \
    fzf \
    fd \
    sudo

__file \
    --path /etc/pacman.conf \
    --source boreal/files/pacman.conf \
    --owner root \
    --group root \
    --perms 644

__file \
    --path /etc/bash.bashrc \
    --source boreal/files/bash.bashrc \
    --owner root \
    --group root \
    --perms 644

__file \
    --path /etc/profile.d/xdg.sh \
    --source boreal/files/profile-xdg.sh \
    --owner root \
    --group root \
    --perms 644


###############
# user config #
###############
# audio
__pacman \
    pipewire-jack \
    pipewire-pulse

# utils
__pacman \
    fish \
    git

# lsp
__pacman \
    rustup \
    rust-analyzer

# desktop
__pacman \
    xorg-xwayland \
    xdg-desktop-portal \
    xdg-desktop-portal-wlr \
    brightnessctl \
    slurp \
    grim \
    sway \
    swaylock \
    wofi \
    arc-solid-gtk-theme \
    waybar \
    foot \
    foot-terminfo \
    xdg-utils \
    libnotify \
    pavucontrol

# fonts
__pacman \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    ttf-liberation \
    ttf-ibm-plex \
    ttf-iosevka-nerd \
    ttf-nerd-fonts-symbols-mono

__user \
    --name terry \
    --shell /bin/bash \
    --group wheel

__symlink_recursive \
    --target_dir=boreal/tilde \
    --link_dir=~
