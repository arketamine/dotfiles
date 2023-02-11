## Main Command
function tm --argument-names subcommand --description "TerraMagna (c) development CLI"
    set -l options (fish_opt --short=h --long=help)
    argparse $options -- $argv

    if set --query _flag_help
        _tm_help
    else if functions --query _tm_$argv[1]
        _tm_$argv[1] $argv[2..]
    else
        _tm_help
    end
end

## Subcommands
# tm --help
function _tm_help --description "Show help message"
    echo "TerraMagna (c) development CLI"
    echo "Usage: tm [options] subcommand [options]"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo ""
    echo "Subcommands:"
    echo "  pg-stop        Stop the 'services' Nix's PostgreSQL instance"
end

# tm pg-stop
function _tm_pg-stop --description "Stop the 'services' Nix's PostgreSQL instance"
    if ! ss -l | grep -q 5432
        echo "No PostgreSQL instance to stop."
        return
    end

    if ! _tm_detect_nix_shell
        echo "Not in a Nix shell."
        return
    end

    if pg_stop 1>/dev/null
        echo "PostgreSQL stopped."
    else
        echo "No PostgreSQL instance to stop."
    end
end

## Helpers
function _tm_detect_nix_shell --description "Detect if we are in a nix-shell"
    if test -n "$IN_NIX_SHELL"
        return 0
    else
        return 1
    end
end
