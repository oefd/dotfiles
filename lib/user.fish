#!/usr/bin/env fish
# ex: et sw=4 ts=4

function __user
    argparse 'name=' 'shell=' 'group=+' -- $argv
    if ! set -q _flag_name; exit_err "__user requires --name arg"; end
    if ! set -q _flag_shell; set -f _flag_shell "/bin/bash"; end
    if ! set -q _flag_group; set -f _flag_group; end

    # create user if they don't exist
    if id -u $_flag_name &>/dev/null
        set -l shell (awk -F: -v user="$_flag_name" '$1 == user {print $NF}' /etc/passwd)
        if test "$_flag_shell" = "$shell"
            no_change "[user] '$_flag_name' already exists"
        else
            failure "[user] '$_flag_name' must have shell manually changed to $_flag_shell"
            return
        end
    else
        useradd $_flag_name --create-home --shell $_flag_shell
        success "[user] '$_flag_name' created"
    end

    set -l existing_groups (string split " " (groups $_flag_name))
    set -l no_add_needed_groups
    set -l added_groups
    for desired_group in $_flag_group
        if ! contains $desired_group $existing_groups
            if sudo gpasswd -a terry $desired_group &>/dev/null
                set -a added_groups $desired_group
            else
                failure "[user] '$_flag_name' could not be added to '$desired_group'"
            end
        else
            set -a no_add_needed_groups $desired_group
        end
    end

    if test (count $added_groups) -gt 0
        success "[user] '$_flag_name' added user to groups: $added_groups"
    end
    if test (count $no_add_needed_groups) -gt 0
        no_change "[user] '$_flag_name' already in groups: $no_add_needed_groups"
    end
end
