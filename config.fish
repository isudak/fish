set fish_greeting

set -x SHELL /usr/bin/fish
set -x EDITOR /usr/bin/vim
begin
    set -l visual (which e ^/dev/null)
    if test $status -eq 0
        set -x VISUAL $visual
    end
end

set -q fish_color_user; or set -U fish_color_user -o green
set -q fish_color_host; or set -U fish_color_host -o cyan

#if test -r ~/.dir_colors
#    eval set -x (dircolors ~/.dir_colors | sed 's/=/ /; q')
#end

begin
    set -l fish_dir ~/.config/fish
    source $fish_dir/aliases.fish
end
