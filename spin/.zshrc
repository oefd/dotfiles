#!/usr/bin/env zsh
source /etc/zsh/zshrc.default.inc.zsh

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "$key[Up]" history-beginning-search-backward-end
bindkey "$key[Down]" history-beginning-search-forward-end

export PATH="$HOME/.local/bin:$PATH"

## wait for bootstrap
if ! test -e /run/dotfiles/done; then
    printf "✗ waiting for bootstrap"
    while true; do
        if test -e /run/dotfiles/done; then
            break
        else
            printf "."
            sleep 0.25
        fi
    done
    printf "\n"
fi
## /wait for bootstrap

eval $(dircolors ~/.dir_colors)
