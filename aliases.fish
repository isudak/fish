function ls --description 'List contents of directory'
    set -l ls
    switch $__fish_os_name
        case Darwin FreeBSD DragonFly
            set ls (command -s gls); or begin
                command ls -GFh $argv
                return
            end

        case '*'
            set ls (command -s ls); or begin
                echo "Can't find 'ls' executable" >&2
                return 1
            end
    end

    set -l opts --group-directories-first --time-style=long-iso -vh

    if isatty 1
        eval $ls $opts --color=always --indicator-style=classify -x $argv | less -XR --quit-if-one-screen
    else
        eval $ls $opts $argv
    end
end


eval (__fish_dircolors)


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
