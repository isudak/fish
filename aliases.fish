function ls --description 'List contents of directory'
    if isatty 1
        command ls \
            --color=always \
            --indicator-style=classify \
            --group-directories-first \
            --time-style=long-iso \
            -vxh $argv \
            | less -XR --quit-if-one-screen
    else
        command ls $argv
    end
end


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
