function add_to_path --description 'Add path(s) to $PATH'
    for d in $argv[-1..1]
        if test -d $d; and not contains -- $d $PATH
            set PATH $d $PATH
        end
    end
end

set -q __fish_os_name
    or set -U __fish_os_name (uname -s)
set -q __fish_prompt_hostname
    or set -gx __fish_prompt_hostname (hostname -s)

if test "$__fish_os_name" = Darwin
    add_to_path /opt/local/bin /opt/local/sbin
end

add_to_path ~/local/bin

set -x SHELL  (command -s fish)
set -q VISUAL
    or set -x VISUAL (command -s e)
set -q EDITOR
    or set -x EDITOR (command -s vim)

if not status --is-interactive
    exit
end

set fish_greeting
set -q fish_color_user
    or set -U fish_color_user -o green
set -q fish_color_host
    or set -U fish_color_host -o cyan

source ~/.config/fish/aliases.fish
