set -g fish_greeting

set -ga PATH /home/terry/.local/cargo/bin
set -ga PATH /home/terry/.local/bin
set -x GTK_THEME Arc-solid

if status is-interactive
    alias ls="ls --color=auto"
    alias pacman="sudo pacman"
end
