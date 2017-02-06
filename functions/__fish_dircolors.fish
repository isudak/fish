function __fish_dircolors -d 'Color setup for ls'
    set -l colorfile
    for file in $argv[-1] ~/.dir_colors ~/.dircolors /etc/DIR_COLORS
        if test -f "$file"
            set colorfile $file
            break
        end
    end

    if test -z "$colorfile"
        return 1
    end

    switch $__fish_os_name
        case Darwin FreeBSD DragonFly
            if command -s gdircolors > /dev/null
                command gdircolors -c $colorfile | string replace -r '^setenv ' 'set -gx '
            else
                set -l curdir (dirname (status -f))
                printf "set -gx LSCOLORS %s\n" (awk -f {$curdir}/dircolors-bsd.awk $colorfile)
            end

        case '*'
            if command -s dircolors > /dev/null
                command dircolors -c $colorfile | string replace -r '^setenv ' 'set -gx '
            end
    end
end
