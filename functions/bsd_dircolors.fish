function bsd_dircolors
    set -l colorfile $argv[1]
    if not test -r "$colorfile"
        return 1
    end

    printf "set -gx LSCOLORS "
    for ftype in DIR LINK SOCK FIFO EXEC BLK CHR SETUID SETGID STICKY_OTHER_WRITABLE OTHER_WRITABLE
        awk -v ftype=$ftype '
        BEGIN {
            re = "^" ftype "[[:space:]]"
            map[0] = "a"; map[1] = "b"; map[2] = "c"; map[3] = "d";
            map[4] = "e"; map[5] = "f"; map[6] = "g"; map[7] = "h";
        }
        $0 ~ re {
            bold = 0; fg = "x"; bg = "x"
            split($2, ccodes, ";")
            for (i in ccodes) {
                code = ccodes[i]
                if (code == 1)
                    bold = 1
                else if (code >= 30 && code <= 37)
                    fg = map[code - 30]
                else if (code >= 40 && code <= 47)
                    bg = map[code - 40]
            }
            printf "%c%c", bold ? toupper(fg): fg, bg
        }' $colorfile
    end
end
