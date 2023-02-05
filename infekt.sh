#!/usr/bin/env sh

. ./scripts/index.sh

if [ $DSL_OS != "MACOS" ]; then
    error "This script is only supported on macOS."
    exit 1
fi

info "Prompting for sudo password..."
if sudo -v; then
    # Keep-alive: update existing `sudo` timestamp until script has finished
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &

    success "Sudo password accepted."
else
    error "Failed to obtain sudo credentials."
    exit 1
fi

info "Installing XCode CLI tools..."
if xcode-select --print-path &>/dev/null; then
    success "XCode CLI tools already installed."
elif xcode-select --install &>/dev/null; then
    success "XCode CLI tools installed."
else
    error "XCode CLI tools install failed."
fi

info "Installing Rosetta..."
sudo softwareupdate --install-rosetta

success "Finished installing 'dotfiles'. Happy hacking!"
