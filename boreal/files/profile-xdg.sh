#!/bin/sh
# Try to coerce various software to put configs and whatnot in XDG dirs

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local"

# config
export BASH_COMPLETION_USER_FILE="${XDG_CONFIG_HOME}/bash-completion/bash_completion"
export FFMPEG_DATADIR="${XDG_CONFIG_HOME}/ffmpeg"

# cache
export MYPY_CACHE_DIR="${XDG_CACHE_HOME}/mypy"
export NODE_REPL_HISTORY="${XDG_CACHE_HOME}/node_hst"
export LESSHISTFILE="${XDG_CACHE_HOME}/lesshist"
export HISTFILE="${XDG_CACHE_HOME}/hist"

# data
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export GOPATH="${XDG_DATA_HOME}/go"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
