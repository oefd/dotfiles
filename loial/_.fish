#!/usr/bin/env fish
# ex: et sw=4 ts=4

source "lib/_lib.fish"


###############
# user config #
###############
__symlink_recursive \
    --target_dir=loial/tilde \
    --link_dir=~
