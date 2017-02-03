function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    # User
    set_color $fish_color_user
    printf $USER
    set_color normal

    printf '@'

    # Host
    set_color $fish_color_host
    printf "$__fish_prompt_hostname"
    set_color normal

    printf ':'

    # PWD
    set_color $fish_color_cwd
    printf "%s" (string replace -r "^$HOME" '~' $PWD)
    set_color normal

    # Git branch
    set -l git_branch (
        command -s git > /dev/null
        and git rev-parse --abbrev-ref HEAD ^ /dev/null
    )
    if test -n "$git_branch"
        printf " (%s)" $git_branch
    end

    # Prompt symbol
    if not test $last_status -eq 0
        set_color $fish_color_error
    end
    printf '\n$ '
    set_color normal
end
