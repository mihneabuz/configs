alias ls="ls --group-directories-first"

function __fish_set_lscolors --description 'Set $LS_COLORS if possible'
    if ! set -qx LS_COLORS && set -l cmd (command -s {g,}dircolors)[1]
        set -l colorfile
        for file in ~/.dir_colors ~/.dircolors /etc/DIR_COLORS
            if test -f $file
                set colorfile $file
                break
            end
        end

        set -gx LS_COLORS ($cmd -c $colorfile | string split ' ')[3]
        if string match -qr '^([\'"]).*\1$' -- $LS_COLORS
            set LS_COLORS (string match -r '^.(.*).$' $LS_COLORS)[2]
        end
    end
end

function ls --description 'List contents of directory'
    if not set -q __fish_ls_color_opt
        set -g __fish_ls_color_opt
        set -g __fish_ls_command ls
        for opt in --color=auto -G --color -F
            if command ls $opt / >/dev/null 2>/dev/null
                set -g __fish_ls_color_opt $opt
                break
            end
        end
    end

    __fish_set_lscolors

    isatty stdout
    and set -a opt -F

    command $__fish_ls_command $__fish_ls_color_opt $opt --group-directories-first $argv
end
