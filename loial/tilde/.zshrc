autoload -Uz compinit; compinit

if test "$(uname)" = "Darwin"; then os="macos"; else os="linux"; fi

# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey -v

# bindkey "$key[Home]" beginning-of-line
# bindkey "$key[End]" end-of-line
# bindkey "$key[Delete]" delete-char

export LESSHISTFILE=~/.cache/lesshist
export HISTFILE=~/.cache/histfile
export HISTSIZE=10000
export SAVEHIST=10000

export RUSTUP_HOME=$HOME/.local/rustup
export CARGO_HOME=$HOME/.local/cargo
export GOPATH=$HOME/.local/go
export DENO_INSTALL_ROOT=$HOME/.local/deno

export PATH="$HOME/.local/bin:$HOME/.local/cargo/bin:$HOME/.local/go/bin:$HOME/.local/deno/bin:$PATH"

export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export HOMEBREW_SHELLENV_PREFIX="/opt/homebrew"
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"
export PATH="$PATH:/opt/homebrew/opt/coreutils/libexec/gnubin"
export KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}$HOME/.kube/config:$HOME/.kube/config.shopify.cloudplatform
eval "$(luarocks path --tree $HOME/.local/luapkgs | grep LUA_PATH)"
eval "$(luarocks path --tree $HOME/.local/luapkgs | grep LUA_CPATH)"
[[ -f /opt/dev/dev.sh ]] && source /opt/dev/dev.sh
[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }
[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
for file in $HOME/src/github.com/Shopify/cloudplatform/workflow-utils/*.bash; do source ${file}; done

# setopt prompt_subst
# precmd_functions+=(prompt_fn)
# function prompt_fn {
#     export LAST_RET="$?"
#     PROMPT="$(lua ~/.config/prompt.lua)"
# }

exec fish
