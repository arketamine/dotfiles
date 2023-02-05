#!/usr/bin/env sh

COMMENT=\#*
PACKAGES_DIR=packages

DIR=$(dirname "$0")
cd "$DIR"

. ./scripts/index.sh

sudo -v

PREVIOUS_DIRECTORY=$(pwd)
cd $PACKAGES_DIR

info "Running standalone installers..."
. ./standalone.sh
success "Standalone installers ran successfully."

info "Installing Brewfile packages..."
warning "This may take a while..."
brew bundle
success "Brewfile packages installed."

info "Enabling NodeJS v18.X.X..."
eval "$(fnm env --use-on-cd)"
fnm install 18 1>/dev/null
fnm use 18 1>/dev/null
success "NodeJS v18.X.X enabled."

find * -name "*.list" | while read path; do
    command="${path%.*}"
    set -- $command
    info "Installing $1 packages..."
    while read package; do
        if [[ $package == $COMMENT ]]; then
            continue
        fi

        info "Installing $package..."
        $command $package 1>/dev/null
    done <"$path"
    success "$1 packages installed."
done

cd $PREVIOUS_DIRECTORY
