#!/usr/bin/env fish
# ex: et sw=4 ts=4

set -g SHOW_NO_CHANGE 0
set -g EXIT_ON_FAILURE 0

function no_change
    if test $SHOW_NO_CHANGE -eq 1
        set_color -o yellow; printf ". $argv"
        set_color normal; printf "\n"
    end
end

function success
    set_color -o green; printf ". $argv"
    set_color normal; printf "\n"
end

function warning
    set_color -o magenta; printf "x $argv"
    set_color normal; printf "\n"
end

function failure
    set_color -o red; printf "x $argv"
    set_color normal; printf "\n"
    if test $EXIT_ON_FAILURE -eq 1
        exit 1
    end
end

function exit_err
    failure $argv
    exit 1
end

if ! test -d ".cache"
    mkdir .cache
end

source "lib/pacman.fish"
source "lib/user.fish"
source "lib/symlink.fish"
source "lib/file.fish"
