#!/usr/bin/env fish
# ex: et sw=4 ts=4

function __pacman
    set -l cache ".cache/__pacman-pkgs"
    if ! test -e $cache; touch $cache; end

    set -l already_installed
    for pkg in (cat $cache)
        set -a already_installed $pkg
    end

    set -l no_install_needed
    set -l to_install
    for pkg in $argv
        if ! contains $pkg $already_installed
            set -a to_install $pkg
        else
            set -a no_install_needed $pkg
        end
    end

    if test (count $to_install) -gt 0; and sudo pacman -S --needed --noconfirm $to_install
        for pkg in $to_install
            echo $pkg >> $cache
        end

        success "[pacman] installed: $to_install"
        if test (count $no_install_needed) -gt 0
            no_change "[pacman] installed: $no_install_needed"
        end
    else
        no_change "[pacman] installed: $no_install_needed"
    end
end
