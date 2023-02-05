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
    echo "[$prefix]: $message"
    tput sgr0
}

info() {
    local message="$1"
    colored "$message" cyan "   INFO"
}

success() {
    local message="$1"
    colored "$message" green "SUCCESS"
}

error() {
    local message="$1"
    colored "$message" red "  ERROR"
}

warning() {
    local message="$1"
    colored "$message" yellow "WARNING"
}
