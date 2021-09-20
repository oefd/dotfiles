#!/bin/fish
set -g fish_greeting

set -g PATH $PATH                 $HOME/.local/bin $HOME/.local/cargo/bin /usr/local/sbin
set -x EDITOR                     /usr/local/bin/nvim
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
set -x GOPATH                     $HOME/.local/go

set -l add_kubeconfig             "/Users/terry/.kube/config:/Users/terry/.kube/config.shopify.cloudplatform"
if test -n "$KUBECONFIG"
    set -x KUBECONFIG             "$KUBECONFIG:$add_kubeconfig"
else
    set -x KUBECONFIG             "$add_kubeconfig"
end

alias ls="gls --color --hide=Applications --hide=Desktop --hide=Pictures --hide=Public --hide=Downloads --hide=Library --hide=Documents --hide=Movies"
alias rm="grm"
alias grep="ggrep"
alias mtr="sudo /usr/local/sbin/mtr"

if status --is-interactive
    fish_vi_key_bindings
end

if test -f /opt/dev/dev.fish
    source /opt/dev/dev.fish
end

