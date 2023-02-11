#!/usr/bin/env sh

colored() {
    local message="$1"
    local color="$2"
    local prefix="$3"

    if ! [[ $color =~ '^[0-9]$' ]]; then
        case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white | *) color=7 ;;
        esac
    fi

    tput bold
    tput setaf "$color"
    printf "$prefix"
    tput sgr0
    printf " $message \n"
}

info() {
    local message="$1"
    colored "$message" cyan "      Info"
}

success() {
    local message="$1"
    colored "$message" green "   Success"
}

error() {
    local message="$1"
    colored "$message" red "     Error"
}

warning() {
    local message="$1"
    colored "$message" yellow "   Warning"
}
