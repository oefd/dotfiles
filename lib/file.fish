#!/usr/bin/env fish
# ex: et sw=4 ts=4

function __file
    argparse 'path=' 'source=' 'owner=' 'group=' 'perms=' -- $argv
    if ! set -q _flag_path; exit_err "__file requires --path arg"; end
    if ! set -q _flag_source; exit_err "__file requires --source arg"; end
    if ! set -q _flag_owner; exit_err "__file requires --owner arg"; end
    if ! set -q _flag_group; exit_err "__file requires --group arg"; end
    if ! set -q _flag_perms; exit_err "__file requires --perms arg"; end

    if test -f $_flag_path
        warning "[file] TODO check '$_flag_path' is correct"
    else if ! test -e $_flag_path; and ! test -L $_flag_path
        sudo cp $_flag_source $_flag_path
        sudo chown "$_flag_owner:$_flag_group" $_flag_path
        sudo chmod $_flag_perms $_flag_path
        success "[file] created '$_flag_path'"
    else
        failure "[file] not overwriting existing path '$_flag_path'"
    end
end
