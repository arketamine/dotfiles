#!/usr/bin/env sh

WORKING_DIR=vscode

DIR=$(dirname "$0")
cd "$DIR"

. ./scripts/index.sh

sudo -v

PREVIOUS_DIRECTORY=$(pwd)
cd $WORKING_DIR

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~/Library/Application\ Support/Code/User)"

info "Setting up Visual Studio Code..."
info "Creating Visual Studio Code folders..."

mkdir -p "$DESTINATION"

find * -not -name "install.sh" -type f | while read path; do
    symlink "$SOURCE/$path" "$DESTINATION/$path"
done

success "Visual Studio Code setup complete."

cd $PREVIOUS_DIRECTORY
