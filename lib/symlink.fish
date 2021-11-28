#!/usr/bin/env fish
# ex: et sw=4 ts=4

function __symlink_recursive
    argparse 'target_dir=' 'link_dir=' -- $argv
    if ! set -q _flag_target_dir; exit_err "__symlink_recursive requires --target_dir arg"; end
    if ! set -q _flag_link_dir; exit_err "[symlink_recursive] require --link_dir arg"; end
    if ! realpath _flag_target_dir &>/dev/null; exit_err "[symlink_recursive] cannot get realpath of --target_dir"; end

    set -l _flag_link_dir (realpath (string replace --regex "^~" $HOME $_flag_link_dir))
    set -l _flag_target_dir (realpath (string replace --regex "^~" $HOME $_flag_target_dir))
    if ! test -d $_flag_link_dir; and ! mkdir -p $_flag_link_dir
        failure "[symlink_recursive] unabled to create link dir $_flag_link_dir"
        return
    end

    for child in (find "$_flag_target_dir")
        if test "$child" = "$_flag_target_dir"; or test $child = ".."; continue; end
        set -l target (realpath $child)
        set -l rel_path (string replace $_flag_target_dir "" $target)
        set -l rel_path (string replace --regex '^/' "" $rel_path)
        set -l link "$_flag_link_dir/$rel_path"

        if test -d $target
            ___handle_dir $target $link
        else if test -f $target
            ___handle_file $target $link
        else
            failure "[symlink_recursive] target path not a file/dir: $target"
        end
    end
end

function ___handle_dir
    set -l target $argv[1]
    set -l link $argv[2]

    if test -d $link
        no_change "[symlink_recursive] dir already exists: $link"
    else
        if mkdir -p $link
            success "[symlink_recursive] created dir  $link"
        else
            failure "[symlink_recursive] failed to create dir $link"
        end
    end
end

function ___handle_file
    set -l target $argv[1]
    set -l link $argv[2]

    if test -L $link
        set -l existing_dest (readlink -f $link)
        if test "$existing_dest" = "$target"
            no_change "[symlink_recursive] link already exists: $link -> $target"
        else
            failure "[symlink_recursive] conflict with existing link: $link"
        end
    else if test -e $link
        failure "[symlink_recursive] conflict with existing file/dir: $link"
    else
        ln -s $target $link
        success "[symlink_recursive] created link: $link -> $target"
    end
end
