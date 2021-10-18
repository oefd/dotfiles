autoload -Uz compinit; compinit
autoload -Uz history-search-end

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey -v

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "$key[Up]" history-beginning-search-backward-end
bindkey "$key[Down]" history-beginning-search-forward-end

bindkey "$key[Home]" beginning-of-line
bindkey "$key[End]" end-of-line
bindkey "$key[Delete]" delete-char

alias apt="sudo apt"

export LESSHISTFILE=~/.cache/lesshist
export HISTFILE=~/.cache/histfile
export HISTSIZE=10000
export SAVEHIST=10000

export RUSTUP_HOME=~/.local/rustup
export CARGO_HOME=~/.local/cargo

export PATH="/home/terry/.local/cargo/bin:$PATH"
export PATH="/home/terry/.cache/venv/bin:$PATH"
export PATH="/home/terry/.local/bin:$PATH"

setopt prompt_subst
precmd_functions+=(prompt_fn)
function prompt_fn {
    export LAST_RET="$?"
    PROMPT="$(lua ~/.config/prompt.lua)"
}
