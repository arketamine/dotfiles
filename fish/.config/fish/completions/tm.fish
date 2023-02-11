complete tm --no-files

set -l subcommands pg-stop

complete tm -x -n __fish_use_subcommand -a pg-stop -d "Stop the 'services' Nix's PostgreSQL instance"

complete tm -x -n "not __fish_seen_subcommand_from $subcommands" -s h -l help -d "Show help message"
