function fish_user_key_bindings
    bind \el forward-char
    bind \ej backward-char
    bind \eu backward-word
    bind \eo forward-word
    bind \eJ beginning-of-line
    bind \eL end-of-line
    bind \eY beginning-of-buffer
    bind \eH end-of-buffer

    bind \ef delete-char
    bind \ed backward-delete-char
    bind \eD backward-kill-line
    bind \eF kill-line

    bind \et '__fish_toggle_word_case'
    bind \er kill-word
    bind \ee backward-kill-word
    bind \ew backward-kill-path-component

    bind \ev yank
    bind \eV yank-pop
    bind \ex '__fish_cancel_or_delete_command'
    bind \eX kill-whole-line

    bind \ei up-or-search
    bind \ek down-or-search
    bind \eI history-token-search-backward
    bind \eK history-token-search-forward

    bind \ey 'commandline -r (printf "cd %s/" (dirname $PWD | sed -e "s|^$HOME|~|"))'
    bind \eh '__fish_go-back'
    bind \e. '__fish_list_current_token'
    bind \e,  'commandline -f complete down-line'

    bind \e\  execute
    bind \em  execute
    bind \eM  "commandline -i \n"
end


function __fish_cancel_or_delete_command
    if commandline --paging-mode
        commandline -f cancel
    else
        commandline -f end-of-buffer \
                       begin-selection \
                       beginning-of-buffer \
                       kill-selection \
                       end-selection
    end
end


function __fish_toggle_word_case
    set -l token (commandline -pt)
    commandline -f backward-word
    if test "$token" = (echo $token | awk '{print toupper($0)}')
        commandline -f downcase-word
    else
        commandline -f upcase-word
    end
end


function go-back --description "Prints the visited directories"
    if not count $argv > /dev/null
        set -l alldirs $dirprev $dirnext
        set -l dirhist
        for dir in $alldirs[-1..1]
            if test -d "$dir" -a ! \( $dir = $PWD \)
                if not contains -- $dir $dirhist
                    set dirhist $dirhist $dir
                    echo (count $dirhist):$dir
                end
            end
        end
    else
        set -l string (type -t string ^ /dev/null)
        if test "$string" = builtin
            cd (string replace -r '^\d+:' '' -- $argv[1])
        else
            cd (printf "%s\n" $argv[1] | sed -r 's/^[0-9]+://')
        end
    end
end


complete -c go-back -x -a "(go-back)"


function __fish_go-back
    if commandline --search-mode
        return
    end

    set -l cmd_line (commandline)
    if echo "$cmd_line" | grep -q '[^ ]'
        # in v2.3: if string match -qr '^ *go-back ' "$cmd_line"
        if echo "$cmd_line" | grep -q '^ *go-back '
            commandline -f execute
            if commandline --paging-mode
                commandline -f execute
            end
        end
        return
    end

    set -l dirhist (go-back)
    if test -n "$dirhist"
        commandline -r " go-back "
        commandline -f complete down-line
        return
    end

    printf "<directory history is empty>"
    printf "\n%.0s" (fish_prompt)
    commandline -f repaint
end
