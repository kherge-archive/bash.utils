#!/usr/bin/env bash

###
#
##
function color
{
    local BACKGROUND=
    local FOREGROUND=

    local BLINK=0
    local BOLD=0
    local DIM=0
    local HIDDEN=0
    local INVERTED=0
    local RESET=0
    local UNDERLINED=0

    eval set -- "$(getopt -o f::,b::,l,o,d,h,i,r,u -l help,fg,bg,blink,bold,dim,hidden,inverted,reset,underlined -n color -- "$@")"

    while true; do
        case "$1" in
            --help)
                echo "Usage: color [OPTIONS]
Styles console output using a combination of flags and options.

OPTIONS

    -b, --background=COLOR  The foreground color.
    -f, --foreground=COLOR  The background color.

    -l, --blink             Makes the text blink.
    -o, --bold              Makes the text bold.
    -d, --dim               Dims the color of the text.
    -h, --hidden            Makes the text hidden (but copy & pasteable).
    -i, --inverted          Swaps the background and foreground.
    -r, --reset             Resets all styles.
    -u, --underlined        Underlines the text.

COLOR

    The following are the names of colors that are supported by the function:

        default, black, red, green, yellow, blue, magenta, cyan, light-gray,
        dark-gray, light-red, light-green, light-yellow, light-blue,
        light-magenta, light-cyan, white

" >&2
                shift
                ;;

            -f|--foreground)
                case "$2" in
                    "") FOREGROUND= ; shift 2 ;;
                    *)
                        case "$2" in
                            default) FOREGROUND=39 ;;
                            black) FOREGROUND=30 ;;
                            red) FOREGROUND=31 ;;
                            green) FOREGROUND=32 ;;
                            yellow) FOREGROUND=33 ;;
                            blue) FOREGROUND=34 ;;
                            magenta) FOREGROUND=35 ;;
                            cyan) FOREGROUND=36 ;;
                            light-gray) FOREGROUND=37 ;;
                            dark-gray) FOREGROUND=90 ;;
                            light-red) FOREGROUND=91 ;;
                            light-green) FOREGROUND=92 ;;
                            light-yellow) FOREGROUND=93 ;;
                            light-blue) FOREGROUND=94 ;;
                            light-magenta) FOREGROUND=95 ;;
                            light-cyan) FOREGROUND=96 ;;
                            white) FOREGROUND=97 ;;

                            *)
                                echo "color: invalid foreground color: $2"
                                return 1 ;;
                        esac ; shift 2 ;;
                esac ;;
            -b|--background)
                case "$2" in
                    "") BACKGROUND= ; shift 2 ;;
                    *)
                        case "$2" in
                            default) BACKGROUND=49 ;;
                            black) BACKGROUND=40 ;;
                            red) BACKGROUND=41 ;;
                            green) BACKGROUND=42 ;;
                            yellow) BACKGROUND=43 ;;
                            blue) BACKGROUND=44 ;;
                            magenta) BACKGROUND=45 ;;
                            cyan) BACKGROUND=46 ;;
                            light-gray) BACKGROUND=47 ;;
                            dark-gray) BACKGROUND=100 ;;
                            light-red) BACKGROUND=101 ;;
                            light-green) BACKGROUND=102 ;;
                            light-yellow) BACKGROUND=103 ;;
                            light-blue) BACKGROUND=104 ;;
                            light-magenta) BACKGROUND=105 ;;
                            light-cyan) BACKGROUND=106 ;;
                            white) BACKGROUND=107 ;;

                            *)
                                echo "color: invalid background color: $2"
                                return 1 ;;
                        esac ; shift 2 ;;
                esac ;;

            -l|--blink) BLINK=1 ; shift ;;
            -o|--bold) BOLD=1 ; shift ;;
            -d|--dim) DIM=1 ; shift ;;
            -h|--hidden) HIDDEN=1 ; shift ;;
            -i|--inverted) INVERTED=1 ; shift ;;
            -r|--reset) RESET=1 ; shift ;;
            -u|--underlined) UNDERLINED=1 ; shift ;;

            --) shift ; break ;;
            *) echo "'$1'" ; return 1 ;;
        esac
    done

    local SEQUENCE=""

    function append
    {
        if [ "$1" != '' ]; then
            if [ "$SEQUENCE" != '' ]; then
                SEQUENCE="$SEQUENCE;"
            fi

            SEQUENCE="$SEQUENCE$1"
        fi
    }

    function append_if
    {
        if [ $1 -eq 1 ]; then
            if [ "$SEQUENCE" != '' ]; then
                SEQUENCE="$SEQUENCE;"
            fi

            SEQUENCE="$SEQUENCE$2"
        fi
    }

    if [ $RESET -eq 0 ]; then
        append "$BACKGROUND"
        append "$FOREGROUND"

        append_if $BLINK 5
        append_if $BOLD 1
        append_if $DIM 2
        append_if $HIDDEN 8
        append_if $INVERTED 7
        append_if $UNDERLINED 4
    else
        append 0
    fi

    if [ "$SEQUENCE" != '' ]; then
        echo -en "\e[${SEQUENCE}m"
    fi
}
