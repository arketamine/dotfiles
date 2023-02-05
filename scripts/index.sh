#!/usr/bin/env sh

case $(uname -s) in
Linux*) DSL_OS=LINUX ;;
Darwin*) DSL_OS=MACOS ;;
*) DSL_OS=UNSUPPORTED ;;
esac

. ./scripts/logging.sh
. ./scripts/symlink.sh
