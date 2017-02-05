function  __fish_dircolors
    command dircolors $argv
end

function __fish_ls
    command ls $argv
end

function __load_dir_colors
    if test -r ~/.dir_colors
        eval (__fish_dircolors -c ~/.dir_colors | string replace -r '^setenv ' 'set -gx ')
    end
end

function ls --description 'List contents of directory'
    if isatty 1
        __fish_ls \
        --color=always \
        --indicator-style=classify \
        --group-directories-first \
        --time-style=long-iso \
        -vxh $argv \
        | less -XR --quit-if-one-screen
    else
        __fish_ls $argv
    end
end

switch (uname -s)
    case Darwin FreeBSD
        if command -s gdircolors > /dev/null; and command -s gls > /dev/null
            function  __fish_dircolors
                command gdircolors $argv
            end

            function __fish_ls
                command gls $argv
            end
        else
            function __load_dir_colors
                set -gx LSCOLORS (bsd_dircolors ~/.dir_colors ^ /dev/null)
            end
            function ls --description 'List contents of directory'
                command ls -GFh $argv
            end
        end
end

__load_dir_colors
functions -e __load_dir_colors


function la --description "List contents of directory, including hidden files"
    ls -lA $argv
end


function df --description 'Report file system disk space usage'
    command df -h $argv
end


function du --description 'Estimate file space usage'
    command du -hs $argv
end


function grep --description 'Search for patterns'
    command grep --color=auto -Hn $argv
end
