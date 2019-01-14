#!/usr/bin/env bash

###
# Outputs an escape sequence to STDOUT for stylized console output.
#
# Example:
#
#     echo "$(color -fred -bgreen)CHRISTMAS$(color -r)"
#
# For complete usage information, run:
#
#     color --help
##
function color
{
    local ECHO=0

    local BACKGROUND=
    local FOREGROUND=

    local BLINK=0
    local BOLD=0
    local DIM=0
    local HIDDEN=0
    local INVERTED=0
    local RESET=0
    local UNDERLINED=0

    eval set -- "$(getopt -o 'e,f::,b::,l,o,d,h,i,r,u' -l echo,help,fg,bg,blink,bold,dim,hidden,inverted,reset,underlined -n color -- "$@")"

    while true; do
        case "$1" in
            -e|--echo) ECHO=1; shift ;;

            --help)
                echo "Usage: color [OPTIONS]
Styles console output using a combination of flags and options.

OPTIONS

    -e, --echo              Echos the sequence unescaped.
        --help              Displays this help screen.

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
                            default) FOREGROUND="$(tput setaf 9)" ;;
                            black) FOREGROUND="$(tput setaf 0)" ;;
                            red) FOREGROUND="$(tput setaf 1)" ;;
                            green) FOREGROUND="$(tput setaf 2)" ;;
                            yellow) FOREGROUND="$(tput setaf 3)" ;;
                            blue) FOREGROUND="$(tput setaf 4)" ;;
                            magenta) FOREGROUND="$(tput setaf 5)" ;;
                            cyan) FOREGROUND="$(tput setaf 6)" ;;
                            white) FOREGROUND="$(tput setaf 7)" ;;

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
                            default) FOREGROUND="$(tput setab 9)" ;;
                            black) FOREGROUND="$(tput setab 0)" ;;
                            red) FOREGROUND="$(tput setab 1)" ;;
                            green) FOREGROUND="$(tput setab 2)" ;;
                            yellow) FOREGROUND="$(tput setab 3)" ;;
                            blue) FOREGROUND="$(tput setab 4)" ;;
                            magenta) FOREGROUND="$(tput setab 5)" ;;
                            cyan) FOREGROUND="$(tput setab 6)" ;;
                            white) FOREGROUND="$(tput setab 7)" ;;

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
        append "$(tput sgr0)"
    fi

    if [ "$SEQUENCE" != '' ]; then
        if [ $ECHO -eq 1 ]; then
            echo "\[$SEQUENCE\]"
        else
            echo -en "\[$SEQUENCE\]"
        fi
    fi
}
