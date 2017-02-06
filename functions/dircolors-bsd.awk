#!/usr/bin/awk -f

BEGIN {
    colors[0] = "a"; colors[1] = "b"; colors[2] = "c"; colors[3] = "d";
    colors[4] = "e"; colors[5] = "f"; colors[6] = "g"; colors[7] = "h";

    file_types = "DIR LINK SOCK FIFO EXEC BLK CHR SETUID SETGID STICKY_OTHER_WRITABLE OTHER_WRITABLE"
    split(file_types, ft_ary, " ")
    for (i in ft_ary) {
        ftypes[ft_ary[i]] = i
        dir_colors[i] = "xx"
    }

    for (ft in ftypes) {
        re = (re ? re "|": "") ft
    }
    re = "^(" re ")[[:space:]]"
}

$0 ~ re {
    color_idx = ftypes[$1]
    color_seq = $2

    bold = 0; fg = "x"; bg = "x"
    split(color_seq, ccodes, ";")
    for (i in ccodes) {
        code = ccodes[i]
        if (code == 1)
            bold = 1
        else if (code >= 30 && code <= 37)
            fg = colors[code - 30]
        else if (code >= 40 && code <= 47)
            bg = colors[code - 40]
    }
    dir_colors[color_idx] = (bold ? toupper(fg): fg) bg
}

END {
    i = 1;
    while (s = dir_colors[i++]) {
        printf "%s", s
    }
    printf "\n"
}
