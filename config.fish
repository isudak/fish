function add_to_path --description 'Add path(s) to $PATH'
    for d in $argv[-1..1]
        if test -d $d; and not contains -- $d $PATH
            set PATH $d $PATH
        end
    end
end

add_to_path ~/local/bin /opt/local/bin /opt/local/sbin

set -x SHELL  (command -s fish)
set -x VISUAL (command -s e)
set -x EDITOR (command -s vim)

set fish_greeting

set -q fish_color_user; or set -U fish_color_user -o green
set -q fish_color_host; or set -U fish_color_host -o cyan

set -q __fish_prompt_hostname; or set -U __fish_prompt_hostname (hostname -s)
set -q __fish_os_name; or set -U __fish_os_name (uname -s)

source ~/.config/fish/aliases.fish
