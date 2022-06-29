set -g fish_greeting

set -ga PATH /Users/oefd/.local/cargo/bin
set -ga PATH /Users/oefd/.local/bin

if test -f /opt/dev/dev.fish
    source /opt/dev/dev.fish
end

pyenv init - | source
# hack to prevent homebrew linking pyenv python versions
alias brew="env PATH=(string replace (pyenv root)/shims '' \"\$PATH\") brew"

if status is-interactive
    alias ls="gls --color=auto --hide=Pictures --hide=Desktop --hide=Documents --hide=Music --hide=Public --hide=Movies --hide=Applications --hide=Downloads --hide=Library"
end
