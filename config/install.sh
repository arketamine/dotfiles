#!/usr/bin/env sh

WORKING_DIR=config

DIR=$(dirname "$0")
cd "$DIR"

. ./scripts/index.sh

sudo -v

PREVIOUS_DIRECTORY=$(pwd)
cd $WORKING_DIR

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~)"

mkdir -p "$DESTINATION/.config/flameshot"

find . -type f -not -name "install.sh" -not -name "." | while read path; do
    symlink "$SOURCE/$path" "$DESTINATION/$path"
done

cd $PREVIOUS_DIRECTORY
